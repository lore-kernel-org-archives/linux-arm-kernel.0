From: dongas86@gmail.com (Dong Aisheng)
Date: Thu, 25 Jan 2018 23:30:25 +0800
Subject: [PATCH] ARM: dts: imx6sx: add pu power domain support
In-Reply-To: <1516720343-21933-1-git-send-email-Anson.Huang@nxp.com>
References: <1516720343-21933-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180125153025.GC24622@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 23, 2018 at 11:12:23PM +0800, Anson Huang wrote:
> Add PU power domain support, GPU is the only
> module inside PU power domain, and PU power
> is supplied by LDO_SOC.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm/boot/dts/imx6sx.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
> index fd78793..42ef4c6 100644
> --- a/arch/arm/boot/dts/imx6sx.dtsi
> +++ b/arch/arm/boot/dts/imx6sx.dtsi
> @@ -188,6 +188,7 @@
>  				 <&clks IMX6SX_CLK_GPU>,
>  				 <&clks IMX6SX_CLK_GPU>;
>  			clock-names = "bus", "core", "shader";
> +			power-domains = <&pd_pu>;
>  		};
>  
>  		dma_apbh: dma-apbh at 1804000 {
> @@ -767,6 +768,13 @@
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  
> +					pd_pu: power-domain at 1 {
> +						reg = <1>;
> +						#power-domain-cells = <0>;
> +						power-supply = <&reg_soc>;

I wonder we may not need this as it's a non-stop domain
just like we did for arm domain, right?

Otherwise, the patch looks fine to me.

Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng

> +						clocks = <&clks IMX6SX_CLK_GPU>;
> +					};
> +
>  					pd_pci: power-domain at 3 {
>  						reg = <3>;
>  						#power-domain-cells = <0>;
> -- 
> 2.7.4
> 
