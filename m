From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 29 Jan 2018 14:36:11 +0800
Subject: [PATCH 2/2] ARM: dts: imx27-eukrea-cpuimx27: Remove 'simple-bus'
 from clocks node
In-Reply-To: <1514391804-9518-2-git-send-email-festevam@gmail.com>
References: <1514391804-9518-1-git-send-email-festevam@gmail.com>
 <1514391804-9518-2-git-send-email-festevam@gmail.com>
Message-ID: <20180129063610.GA26461@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 27, 2017 at 02:23:24PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> clock node should not have a 'simple-bus' compatible string, so remove it
> in order to fix the following build warning with W=1:
> 
> arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dtb: Warning (simple_bus_reg): Node /clocks/osc26m missing or empty reg/ranges property
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi b/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi
> index 2cf896c..7c75147 100644
> --- a/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi
> +++ b/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi
> @@ -23,7 +23,6 @@
>  	clocks {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> -		compatible = "simple-bus";
>  
>  		clk14745600: clock at 0 {
>  			#clock-cells = <0>;

We should probably fix it in another way - put the node directly under
root with a unique node name and drop unit-address.

Shawn
