From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 14 Jun 2013 14:24:05 +0800
Subject: [PATCH 7/9] ARM: dtsi: imx6qdl-sabresd: Enable SSI2 and AUDMUX
In-Reply-To: <499493b4fd86c318da5990521678642bc0733d3c.1371123426.git.b42378@freescale.com>
References: <cover.1371123426.git.b42378@freescale.com>
 <499493b4fd86c318da5990521678642bc0733d3c.1371123426.git.b42378@freescale.com>
Message-ID: <20130614062404.GD20513@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 07:51:02PM +0800, Nicolin Chen wrote:
> Enable SSI2 and its pin configuration in AUDMUX.
> 
> Signed-off-by: Nicolin Chen <b42378@freescale.com>
> ---
>  arch/arm/boot/dts/imx6qdl-sabresd.dtsi |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> index 4ee2413..a76e37a 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> @@ -93,6 +93,17 @@
>  	status = "okay";
>  };
>  
> +&ssi2 {
> +	status = "okay";
> +	fsl,mode = "i2s-slave";
> +};
> +
> +&audmux {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_audmux_2>;
> +};
> +

I moved these two nodes around to have them properly sorted, and also
move "status" to be the last property.

Shawn

>  &i2c1 {
>  	status = "okay";
>  	clock-frequency = <100000>;
> -- 
> 1.7.1
> 
> 
