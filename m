From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 4 May 2018 16:23:13 +0800
Subject: [PATCH] ARM: dts: imx6sx-sabreauto: add debug LED support
In-Reply-To: <1524812288-799-1-git-send-email-Anson.Huang@nxp.com>
References: <1524812288-799-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180504082312.GB3443@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2018 at 02:58:08PM +0800, Anson Huang wrote:
> There is a debug LED(D11) connected to GPIO1_IO24, add
> support for it.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> this patch is based on patch series (ARM: dts: imx6sx-sabreauto: add wdog external reset support).

In this case, you can include these two patches into the series, if you
need to resend the series.

Shawn

>  arch/arm/boot/dts/imx6sx-sabreauto.dts | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> index eb1452c..6b94f24 100644
> --- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
> +++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> @@ -18,6 +18,18 @@
>  		reg = <0x80000000 0x80000000>;
>  	};
>  
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_led>;
> +
> +		user {
> +			label = "debug";
> +			gpios = <&gpio1 24 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +
>  	regulators {
>  		compatible = "simple-bus";
>  		#address-cells = <1>;
> @@ -119,6 +131,12 @@
>  &iomuxc {
>  	imx6x-sabreauto {
>  
> +		pinctrl_led: ledgrp {
> +			fsl,pins = <
> +				MX6SX_PAD_CSI_PIXCLK__GPIO1_IO_24 0x17059
> +			>;
> +		};
> +

Try to sort the pinctrl node alphabetically.

Shawn

>  		pinctrl_enet1_1: enet1grp-1 {
>  			fsl,pins = <
>  				MX6SX_PAD_ENET1_MDIO__ENET1_MDIO        0xa0b1
> -- 
> 2.7.4
> 
