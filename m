From: marex@denx.de (Marek Vasut)
Date: Tue, 03 May 2016 12:44:23 +0200
Subject: [PATCH] ARM: mx5: dts: Enable USB OTG on M53EVK
In-Reply-To: <1461105361-6742-1-git-send-email-marex@denx.de>
References: <1461105361-6742-1-git-send-email-marex@denx.de>
Message-ID: <57288107.4000908@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/20/2016 12:36 AM, Marek Vasut wrote:
> Add USB OTG support to M53EVK instead of just USB gadget.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>

Bump ?

btw. Shawn, is the @k.org the address I should use now ?

> ---
>  arch/arm/boot/dts/imx53-m53evk.dts | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx53-m53evk.dts b/arch/arm/boot/dts/imx53-m53evk.dts
> index 53f4088..dcee1e0f 100644
> --- a/arch/arm/boot/dts/imx53-m53evk.dts
> +++ b/arch/arm/boot/dts/imx53-m53evk.dts
> @@ -84,6 +84,15 @@
>  			regulator-max-microvolt = <5000000>;
>  			gpio = <&gpio1 2 0>;
>  		};
> +
> +		reg_usb_otg_vbus: regulator at 4 {
> +			compatible = "regulator-fixed";
> +			reg = <4>;
> +			regulator-name = "usb_otg_vbus";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			gpio = <&gpio1 4 0>;
> +		};
>  	};
>  
>  	sound {
> @@ -168,6 +177,12 @@
>  			>;
>  		};
>  
> +		pinctrl_usbotg: usbotggrp {
> +			fsl,pins = <
> +				MX53_PAD_GPIO_4__GPIO1_4		0x000b0
> +			>;
> +		};
> +
>  		led_pin_gpio: led_gpio at 0 {
>  			fsl,pins = <
>  				MX53_PAD_PATA_DATA8__GPIO2_8		0x80000000
> @@ -351,6 +366,10 @@
>  };
>  
>  &usbotg {
> -	dr_mode = "peripheral";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usbotg>;
> +	dr_mode = "otg";
> +	vbus-supply = <&reg_usb_otg_vbus>;
> +	disable-over-current;
>  	status = "okay";
>  };
> 


-- 
Best regards,
Marek Vasut
