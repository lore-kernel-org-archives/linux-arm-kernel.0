From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 13 Mar 2017 19:59:46 +0800
Subject: [PATCH v4 1/7] arm: dts: imx6qdl-icore: Add backlight support
 for lvds
In-Reply-To: <1488957477-5621-1-git-send-email-jagan@openedev.com>
References: <1488957477-5621-1-git-send-email-jagan@openedev.com>
Message-ID: <20170313115944.GD3618@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 08, 2017 at 12:47:51PM +0530, Jagan Teki wrote:
> From: Jagan Teki <jagan@amarulasolutions.com>
> 
> This patch add support for lvds backlight on i.CoreM6 QDL
> variant boards.
> 
> Cc: Domenico Acri <domenico.acri@engicam.com>
> Cc: Matteo Lisi <matteo.lisi@engicam.com>
> Cc: Michael Trimarchi <michael@amarulasolutions.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

For sake of consistency, please use 'ARM: ...' than 'arm: ...' in
subject prefix for i.MX patches.

> ---
> Changes for v4, v3, v2:
> - none
> 
>  arch/arm/boot/dts/imx6qdl-icore.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-icore.dtsi b/arch/arm/boot/dts/imx6qdl-icore.dtsi
> index 55bebfc..7dda608 100644
> --- a/arch/arm/boot/dts/imx6qdl-icore.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-icore.dtsi
> @@ -48,6 +48,14 @@
>  		reg = <0x10000000 0x80000000>;
>  	};
>  
> +	backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm3 0 100000>;
> +		brightness-levels = <0 4 8 16 32 64 128 255>;
> +		default-brightness-level = <7>;
> +		status = "okay";

The okay status doesn't make a difference for such case, and can be
saved.

> +	};
> +
>  	reg_3p3v: regulator-3p3v {
>  		compatible = "regulator-fixed";
>  		regulator-name = "3P3V";
> @@ -136,6 +144,12 @@
>  	status = "okay";
>  };
>  
> +&pwm3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pwm3>;
> +	status = "okay";
> +};
> +
>  &uart4 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_uart4>;
> @@ -246,6 +260,12 @@
>  		>;
>  	};
>  
> +	pinctrl_pwm3: pwm3grp-1 {

The '-1' suffix is meaningless.

Shawn

> +		fsl,pins = <
> +			MX6QDL_PAD_SD4_DAT1__PWM3_OUT 0x1b0b1
> +		>;
> +	};
> +
>  	pinctrl_usbotg: usbotggrp {
>  		fsl,pins = <
>  			MX6QDL_PAD_GPIO_1__USB_OTG_ID 0x17059
> -- 
> 1.9.1
> 
