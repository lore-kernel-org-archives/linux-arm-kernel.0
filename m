From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 28 Jun 2014 23:15:53 +0800
Subject: [PATCH 1/2] ARM: dts: mx5: Split M53EVK into SoM and EVK parts
In-Reply-To: <1403722113-5721-1-git-send-email-marex@denx.de>
References: <1403722113-5721-1-git-send-email-marex@denx.de>
Message-ID: <20140628151551.GE7869@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 08:48:32PM +0200, Marek Vasut wrote:
> @@ -226,14 +158,11 @@
>  
>  &iomuxc {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_hog>;
> +	pinctrl-0 = <&pinctrl_hog &pinctrl_usb>;

Hmm, shouldn't pinctrl_usb be put into some USB related node?

Shawn

>  
>  	imx53-m53evk {
> -		pinctrl_hog: hoggrp {
> +		pinctrl_usb: usbgrp {
>  			fsl,pins = <
> -				MX53_PAD_GPIO_0__CCM_SSI_EXT1_CLK	0x80000000
> -				MX53_PAD_EIM_EB3__GPIO2_31		0x80000000
> -				MX53_PAD_PATA_DA_0__GPIO7_6		0x80000000
>  				MX53_PAD_GPIO_2__GPIO1_2		0x80000000
>  				MX53_PAD_GPIO_3__USBOH3_USBH1_OC	0x80000000
>  			>;
