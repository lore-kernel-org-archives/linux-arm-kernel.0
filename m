From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 29 Apr 2014 14:01:07 +0800
Subject: [PATCH 2/3] ARM: dts: imx: add LVDS backlight for Ventana
In-Reply-To: <1398377247-3901-3-git-send-email-tharvey@gateworks.com>
References: <1398377247-3901-1-git-send-email-tharvey@gateworks.com>
 <1398377247-3901-3-git-send-email-tharvey@gateworks.com>
Message-ID: <20140429060106.GG16451@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 24, 2014 at 03:07:26PM -0700, Tim Harvey wrote:
> The GW54xx/GW53xx/GW52xx all support LVDS with a PWM controlled backlight.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 20 ++++++++++++++++++++
>  arch/arm/boot/dts/imx6qdl-gw53xx.dtsi | 20 ++++++++++++++++++++
>  arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 20 ++++++++++++++++++++
>  3 files changed, 60 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
> index 607888c..9c9259b 100644
> --- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
> @@ -27,6 +27,14 @@
>  		bootargs = "console=ttymxc1,115200";
>  	};
>  
> +	backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm4 0 5000000>;
> +		brightness-levels = <0 4 8 16 32 64 128 255>;
> +		default-brightness-level = <7>;
> +		status = "okay";

This might be copied from some existing dts file.  But the "okay" status
line is only needed for nodes that have a "disabled" status line in
<soc>.dtsi.  You can just drop the line from this backlight node.

Shawn

> +	};
> +
>  	leds {
>  		compatible = "gpio-leds";
>  
> @@ -399,6 +407,12 @@
>  			>;
>  		};
>  
> +		pinctrl_pwm4: pwm4grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_SD1_CMD__PWM4_OUT		0x1b0b1
> +			>;
> +		};
> +
>  		pinctrl_uart1: uart1grp {
>  			fsl,pins = <
>  				MX6QDL_PAD_SD3_DAT7__UART1_TX_DATA	0x1b0b1
> @@ -451,6 +465,12 @@
>  	status = "okay";
>  };
>  
> +&pwm4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pwm4>;
> +	status = "okay";
> +};
> +
>  &ssi1 {
>  	fsl,mode = "i2s-slave";
>  	status = "okay";
> diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
> index ef7bd99..3e146d6 100644
> --- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
> @@ -30,6 +30,14 @@
>  		bootargs = "console=ttymxc1,115200";
>  	};
>  
> +	backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm4 0 5000000>;
> +		brightness-levels = <0 4 8 16 32 64 128 255>;
> +		default-brightness-level = <7>;
> +		status = "okay";
> +	};
> +
>  	leds {
>  		compatible = "gpio-leds";
>  
> @@ -439,6 +447,12 @@
>  			>;
>  		};
>  
> +		pinctrl_pwm4: pwm4grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_SD1_CMD__PWM4_OUT		0x1b0b1
> +			>;
> +		};
> +
>  		pinctrl_uart1: uart1grp {
>  			fsl,pins = <
>  				MX6QDL_PAD_SD3_DAT7__UART1_TX_DATA	0x1b0b1
> @@ -513,6 +527,12 @@
>  	};
>  };
>  
> +&pwm4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pwm4>;
> +	status = "okay";
> +};
> +
>  &ssi1 {
>  	fsl,mode = "i2s-slave";
>  	status = "okay";
> diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
> index 4ce8f68..d145f8c 100644
> --- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
> @@ -30,6 +30,14 @@
>  		bootargs = "console=ttymxc1,115200";
>  	};
>  
> +	backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm4 0 5000000>;
> +		brightness-levels = <0 4 8 16 32 64 128 255>;
> +		default-brightness-level = <7>;
> +		status = "okay";
> +	};
> +
>  	leds {
>  		compatible = "gpio-leds";
>  
> @@ -461,6 +469,12 @@
>  			>;
>  		};
>  
> +		pinctrl_pwm4: pwm4grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_SD1_CMD__PWM4_OUT		0x1b0b1
> +			>;
> +		};
> +
>  		pinctrl_uart1: uart1grp {
>  			fsl,pins = <
>  				MX6QDL_PAD_SD3_DAT7__UART1_TX_DATA	0x1b0b1
> @@ -535,6 +549,12 @@
>  	};
>  };
>  
> +&pwm4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pwm4>;
> +	status = "okay";
> +};
> +
>  &ssi1 {
>  	fsl,mode = "i2s-slave";
>  	status = "okay";
> -- 
> 1.8.3.2
> 
> 
> 
