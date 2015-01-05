From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 5 Jan 2015 21:08:31 +0800
Subject: [PATCH] ARM: imx: apf51dev: add gpio-backlight support
In-Reply-To: <1418728857-21070-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1418728857-21070-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <20150105130829.GB24511@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 16, 2014 at 12:20:57PM +0100, Gwenhael Goavec-Merou wrote:
> Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>

Applied, thanks.

Shawn

> ---
>  arch/arm/boot/dts/imx51-apf51dev.dts | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx51-apf51dev.dts b/arch/arm/boot/dts/imx51-apf51dev.dts
> index c5a9a24..93d3ea1 100644
> --- a/arch/arm/boot/dts/imx51-apf51dev.dts
> +++ b/arch/arm/boot/dts/imx51-apf51dev.dts
> @@ -16,6 +16,14 @@
>  	model = "Armadeus Systems APF51Dev docking/development board";
>  	compatible = "armadeus,imx51-apf51dev", "armadeus,imx51-apf51", "fsl,imx51";
>  
> +	backlight at bl1{
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_backlight>;
> +		compatible = "gpio-backlight";
> +		gpios = <&gpio3 4 GPIO_ACTIVE_HIGH>;
> +		default-on;
> +	};
> +
>  	display at di1 {
>  		compatible = "fsl,imx-parallel-display";
>  		interface-pix-fmt = "bgr666";
> @@ -114,6 +122,12 @@
>  	pinctrl-0 = <&pinctrl_hog>;
>  
>  	imx51-apf51dev {
> +		pinctrl_backlight: bl1grp {
> +			fsl,pins = <
> +				MX51_PAD_DI1_D1_CS__GPIO3_4 0x1F5
> +			>;
> +		};
> +
>  		pinctrl_hog: hoggrp {
>  			fsl,pins = <
>  				MX51_PAD_EIM_EB2__GPIO2_22   0x0C5
> -- 
> 2.0.4
> 
