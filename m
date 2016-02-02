From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 2 Feb 2016 14:36:48 +0800
Subject: [PATCH 4/6] ARM: dts: imx6: change TX6 module names due to new
 HW revision
In-Reply-To: <1453294626-17608-5-git-send-email-LW@KARO-electronics.de>
References: <1453294626-17608-1-git-send-email-LW@KARO-electronics.de>
 <1453294626-17608-5-git-send-email-LW@KARO-electronics.de>
Message-ID: <20160202063648.GG8307@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 20, 2016 at 01:57:04PM +0100, Lothar Wa?mann wrote:
> The second last digit of the Ka-Ro electronics TX-module names denotes
> the HW revision of the module. HW rev 1 and 3 of the TX6 modules can
> use the same DTB. Change this digit to 'x' to indicate that the DTB
> file can be used for both HW revisions.

This is simply a unnecessary churn of the source tree.  I wouldn't take
it.

Shawn

> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> ---
>  arch/arm/boot/dts/Makefile                   |  10 +-
>  arch/arm/boot/dts/imx6dl-tx6u-801x.dts       | 177 -------------------
>  arch/arm/boot/dts/imx6dl-tx6u-80xx.dts       | 185 ++++++++++++++++++++
>  arch/arm/boot/dts/imx6dl-tx6u-811x.dts       | 150 ----------------
>  arch/arm/boot/dts/imx6dl-tx6u-81xx.dts       | 156 +++++++++++++++++
>  arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dts | 103 -----------
>  arch/arm/boot/dts/imx6q-tx6q-1010.dts        | 177 -------------------
>  arch/arm/boot/dts/imx6q-tx6q-10x0-comtft.dts | 119 +++++++++++++
>  arch/arm/boot/dts/imx6q-tx6q-10x0.dts        | 191 ++++++++++++++++++++
>  arch/arm/boot/dts/imx6q-tx6q-1110.dts        | 154 -----------------
>  arch/arm/boot/dts/imx6q-tx6q-11x0.dts        | 249 +++++++++++++++++++++++++++
>  11 files changed, 905 insertions(+), 766 deletions(-)
>  delete mode 100644 arch/arm/boot/dts/imx6dl-tx6u-801x.dts
>  create mode 100644 arch/arm/boot/dts/imx6dl-tx6u-80xx.dts
>  delete mode 100644 arch/arm/boot/dts/imx6dl-tx6u-811x.dts
>  create mode 100644 arch/arm/boot/dts/imx6dl-tx6u-81xx.dts
>  delete mode 100644 arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dts
>  delete mode 100644 arch/arm/boot/dts/imx6q-tx6q-1010.dts
>  create mode 100644 arch/arm/boot/dts/imx6q-tx6q-10x0-comtft.dts
>  create mode 100644 arch/arm/boot/dts/imx6q-tx6q-10x0.dts
>  delete mode 100644 arch/arm/boot/dts/imx6q-tx6q-1110.dts
>  create mode 100644 arch/arm/boot/dts/imx6q-tx6q-11x0.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index a4a6d70..5759aac 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -312,8 +312,8 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>  	imx6dl-sabrelite.dtb \
>  	imx6dl-sabresd.dtb \
>  	imx6dl-tx6dl-comtft.dtb \
> -	imx6dl-tx6u-801x.dtb \
> -	imx6dl-tx6u-811x.dtb \
> +	imx6dl-tx6u-80xx.dtb \
> +	imx6dl-tx6u-81xx.dtb \
>  	imx6dl-udoo.dtb \
>  	imx6dl-wandboard.dtb \
>  	imx6dl-wandboard-revb1.dtb \
> @@ -342,11 +342,11 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>  	imx6q-sabresd.dtb \
>  	imx6q-sbc6x.dtb \
>  	imx6q-tbs2910.dtb \
> -	imx6q-tx6q-1010.dtb \
> -	imx6q-tx6q-1010-comtft.dtb \
>  	imx6q-tx6q-1020.dtb \
>  	imx6q-tx6q-1020-comtft.dtb \
> -	imx6q-tx6q-1110.dtb \
> +	imx6q-tx6q-10x0-comtft.dtb \
> +	imx6q-tx6q-10x0.dtb \
> +	imx6q-tx6q-11x0.dtb \
>  	imx6q-udoo.dtb \
>  	imx6q-wandboard.dtb \
>  	imx6q-wandboard-revb1.dtb
> diff --git a/arch/arm/boot/dts/imx6dl-tx6u-801x.dts b/arch/arm/boot/dts/imx6dl-tx6u-801x.dts
> deleted file mode 100644
> index 5fe465c..0000000
> --- a/arch/arm/boot/dts/imx6dl-tx6u-801x.dts
> +++ /dev/null
> @@ -1,177 +0,0 @@
> -/*
> - * Copyright 2014 Lothar Wa?mann <LW@KARO-electronics.de>
> - *
> - * The code contained herein is licensed under the GNU General Public
> - * License. You may obtain a copy of the GNU General Public License
> - * Version 2 at the following locations:
> - *
> - * http://www.opensource.org/licenses/gpl-license.html
> - * http://www.gnu.org/copyleft/gpl.html
> - */
> -
> -/dts-v1/;
> -#include "imx6dl.dtsi"
> -#include "imx6qdl-tx6.dtsi"
> -
> -/ {
> -	model = "Ka-Ro electronics TX6U-801x Module";
> -	compatible = "karo,imx6dl-tx6dl", "fsl,imx6dl";
> -
> -	aliases {
> -		display = &display;
> -	};
> -
> -	backlight: backlight {
> -		compatible = "pwm-backlight";
> -		pwms = <&pwm2 0 500000 PWM_POLARITY_INVERTED>;
> -		power-supply = <&reg_3v3>;
> -		/*
> -		 * a poor man's way to create a 1:1 relationship between
> -		 * the PWM value and the actual duty cycle
> -		 */
> -		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
> -				     10 11 12 13 14 15 16 17 18 19
> -				     20 21 22 23 24 25 26 27 28 29
> -				     30 31 32 33 34 35 36 37 38 39
> -				     40 41 42 43 44 45 46 47 48 49
> -				     50 51 52 53 54 55 56 57 58 59
> -				     60 61 62 63 64 65 66 67 68 69
> -				     70 71 72 73 74 75 76 77 78 79
> -				     80 81 82 83 84 85 86 87 88 89
> -				     90 91 92 93 94 95 96 97 98 99
> -				    100>;
> -		default-brightness-level = <50>;
> -	};
> -
> -	display: display at di0 {
> -		compatible = "fsl,imx-parallel-display";
> -		interface-pix-fmt = "rgb24";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pinctrl_disp0_1>;
> -		status = "okay";
> -
> -		port {
> -			display0_in: endpoint {
> -				remote-endpoint = <&ipu1_di0_disp0>;
> -			};
> -		};
> -
> -		display-timings {
> -			VGA {
> -				clock-frequency = <25200000>;
> -				hactive = <640>;
> -				vactive = <480>;
> -				hback-porch = <48>;
> -				hsync-len = <96>;
> -				hfront-porch = <16>;
> -				vback-porch = <31>;
> -				vsync-len = <2>;
> -				vfront-porch = <12>;
> -				hsync-active = <0>;
> -				vsync-active = <0>;
> -				de-active = <1>;
> -				pixelclk-active = <0>;
> -			};
> -
> -			ETV570 {
> -				clock-frequency = <25200000>;
> -				hactive = <640>;
> -				vactive = <480>;
> -				hback-porch = <114>;
> -				hsync-len = <30>;
> -				hfront-porch = <16>;
> -				vback-porch = <32>;
> -				vsync-len = <3>;
> -				vfront-porch = <10>;
> -				hsync-active = <0>;
> -				vsync-active = <0>;
> -				de-active = <1>;
> -				pixelclk-active = <0>;
> -			};
> -
> -			ET0350 {
> -				clock-frequency = <6413760>;
> -				hactive = <320>;
> -				vactive = <240>;
> -				hback-porch = <34>;
> -				hsync-len = <34>;
> -				hfront-porch = <20>;
> -				vback-porch = <15>;
> -				vsync-len = <3>;
> -				vfront-porch = <4>;
> -				hsync-active = <0>;
> -				vsync-active = <0>;
> -				de-active = <1>;
> -				pixelclk-active = <0>;
> -			};
> -
> -			ET0430 {
> -				clock-frequency = <9009000>;
> -				hactive = <480>;
> -				vactive = <272>;
> -				hback-porch = <2>;
> -				hsync-len = <41>;
> -				hfront-porch = <2>;
> -				vback-porch = <2>;
> -				vsync-len = <10>;
> -				vfront-porch = <2>;
> -				hsync-active = <0>;
> -				vsync-active = <0>;
> -				de-active = <1>;
> -				pixelclk-active = <1>;
> -			};
> -
> -			ET0500 {
> -				clock-frequency = <33264000>;
> -				hactive = <800>;
> -				vactive = <480>;
> -				hback-porch = <88>;
> -				hsync-len = <128>;
> -				hfront-porch = <40>;
> -				vback-porch = <33>;
> -				vsync-len = <2>;
> -				vfront-porch = <10>;
> -				hsync-active = <0>;
> -				vsync-active = <0>;
> -				de-active = <1>;
> -				pixelclk-active = <0>;
> -			};
> -
> -			ET0700 { /* same as ET0500 */
> -				clock-frequency = <33264000>;
> -				hactive = <800>;
> -				vactive = <480>;
> -				hback-porch = <88>;
> -				hsync-len = <128>;
> -				hfront-porch = <40>;
> -				vback-porch = <33>;
> -				vsync-len = <2>;
> -				vfront-porch = <10>;
> -				hsync-active = <0>;
> -				vsync-active = <0>;
> -				de-active = <1>;
> -				pixelclk-active = <0>;
> -			};
> -
> -			ETQ570 {
> -				clock-frequency = <6596040>;
> -				hactive = <320>;
> -				vactive = <240>;
> -				hback-porch = <38>;
> -				hsync-len = <30>;
> -				hfront-porch = <30>;
> -				vback-porch = <16>;
> -				vsync-len = <3>;
> -				vfront-porch = <4>;
> -				hsync-active = <0>;
> -				vsync-active = <0>;
> -				de-active = <1>;
> -				pixelclk-active = <0>;
> -			};
> -		};
> -        };
> -};
> -
> -&ipu1_di0_disp0 {
> -	remote-endpoint = <&display0_in>;
> -};
> diff --git a/arch/arm/boot/dts/imx6dl-tx6u-80xx.dts b/arch/arm/boot/dts/imx6dl-tx6u-80xx.dts
> new file mode 100644
> index 0000000..f6621d6
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6dl-tx6u-80xx.dts
> @@ -0,0 +1,185 @@
> +/*
> + * Copyright 2014 Lothar Wa?mann <LW@KARO-electronics.de>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/dts-v1/;
> +#include "imx6dl.dtsi"
> +#include "imx6qdl-tx6.dtsi"
> +
> +/ {
> +	model = "Ka-Ro electronics TX6U-801x/-803x Module";
> +	compatible = "karo,imx6dl-tx6dl", "fsl,imx6dl";
> +
> +	aliases {
> +		display = &display;
> +	};
> +
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm2 0 500000 PWM_POLARITY_INVERTED>;
> +		power-supply = <&reg_3v3>;
> +		/*
> +		 * a poor man's way to create a 1:1 relationship between
> +		 * the PWM value and the actual duty cycle
> +		 */
> +		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
> +				     10 11 12 13 14 15 16 17 18 19
> +				     20 21 22 23 24 25 26 27 28 29
> +				     30 31 32 33 34 35 36 37 38 39
> +				     40 41 42 43 44 45 46 47 48 49
> +				     50 51 52 53 54 55 56 57 58 59
> +				     60 61 62 63 64 65 66 67 68 69
> +				     70 71 72 73 74 75 76 77 78 79
> +				     80 81 82 83 84 85 86 87 88 89
> +				     90 91 92 93 94 95 96 97 98 99
> +				    100>;
> +		default-brightness-level = <50>;
> +	};
> +
> +	display: display at di0 {
> +		compatible = "fsl,imx-parallel-display";
> +		interface-pix-fmt = "rgb24";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_disp0_1>;
> +		status = "okay";
> +
> +		port {
> +			display0_in: endpoint {
> +				remote-endpoint = <&ipu1_di0_disp0>;
> +			};
> +		};
> +
> +		display-timings {
> +			VGA {
> +				clock-frequency = <25200000>;
> +				hactive = <640>;
> +				vactive = <480>;
> +				hback-porch = <48>;
> +				hsync-len = <96>;
> +				hfront-porch = <16>;
> +				vback-porch = <31>;
> +				vsync-len = <2>;
> +				vfront-porch = <12>;
> +				hsync-active = <0>;
> +				vsync-active = <0>;
> +				de-active = <1>;
> +				pixelclk-active = <0>;
> +			};
> +
> +			ETV570 {
> +				clock-frequency = <25200000>;
> +				hactive = <640>;
> +				vactive = <480>;
> +				hback-porch = <114>;
> +				hsync-len = <30>;
> +				hfront-porch = <16>;
> +				vback-porch = <32>;
> +				vsync-len = <3>;
> +				vfront-porch = <10>;
> +				hsync-active = <0>;
> +				vsync-active = <0>;
> +				de-active = <1>;
> +				pixelclk-active = <0>;
> +			};
> +
> +			ET0350 {
> +				clock-frequency = <6413760>;
> +				hactive = <320>;
> +				vactive = <240>;
> +				hback-porch = <34>;
> +				hsync-len = <34>;
> +				hfront-porch = <20>;
> +				vback-porch = <15>;
> +				vsync-len = <3>;
> +				vfront-porch = <4>;
> +				hsync-active = <0>;
> +				vsync-active = <0>;
> +				de-active = <1>;
> +				pixelclk-active = <0>;
> +			};
> +
> +			ET0430 {
> +				clock-frequency = <9009000>;
> +				hactive = <480>;
> +				vactive = <272>;
> +				hback-porch = <2>;
> +				hsync-len = <41>;
> +				hfront-porch = <2>;
> +				vback-porch = <2>;
> +				vsync-len = <10>;
> +				vfront-porch = <2>;
> +				hsync-active = <0>;
> +				vsync-active = <0>;
> +				de-active = <1>;
> +				pixelclk-active = <1>;
> +			};
> +
> +			ET0500 {
> +				clock-frequency = <33264000>;
> +				hactive = <800>;
> +				vactive = <480>;
> +				hback-porch = <88>;
> +				hsync-len = <128>;
> +				hfront-porch = <40>;
> +				vback-porch = <33>;
> +				vsync-len = <2>;
> +				vfront-porch = <10>;
> +				hsync-active = <0>;
> +				vsync-active = <0>;
> +				de-active = <1>;
> +				pixelclk-active = <0>;
> +			};
> +
> +			ET0700 { /* same as ET0500 */
> +				clock-frequency = <33264000>;
> +				hactive = <800>;
> +				vactive = <480>;
> +				hback-porch = <88>;
> +				hsync-len = <128>;
> +				hfront-porch = <40>;
> +				vback-porch = <33>;
> +				vsync-len = <2>;
> +				vfront-porch = <10>;
> +				hsync-active = <0>;
> +				vsync-active = <0>;
> +				de-active = <1>;
> +				pixelclk-active = <0>;
> +			};
> +
> +			ETQ570 {
> +				clock-frequency = <6596040>;
> +				hactive = <320>;
> +				vactive = <240>;
> +				hback-porch = <38>;
> +				hsync-len = <30>;
> +				hfront-porch = <30>;
> +				vback-porch = <16>;
> +				vsync-len = <3>;
> +				vfront-porch = <4>;
> +				hsync-active = <0>;
> +				vsync-active = <0>;
> +				de-active = <1>;
> +				pixelclk-active = <0>;
> +			};
> +		};
> +	};
> +};
> +
> +&ipu1_di0_disp0 {
> +	remote-endpoint = <&display0_in>;
> +};
> +
> +&reg_lcd0_pwr {
> +	status = "okay";
> +};
> +
> +&reg_lcd1_pwr {
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/imx6dl-tx6u-811x.dts b/arch/arm/boot/dts/imx6dl-tx6u-811x.dts
> deleted file mode 100644
> index c275eec..0000000
> --- a/arch/arm/boot/dts/imx6dl-tx6u-811x.dts
> +++ /dev/null
> @@ -1,150 +0,0 @@
> -/*
> - * Copyright 2014 Lothar Wa?mann <LW@KARO-electronics.de>
> - *
> - * The code contained herein is licensed under the GNU General Public
> - * License. You may obtain a copy of the GNU General Public License
> - * Version 2 at the following locations:
> - *
> - * http://www.opensource.org/licenses/gpl-license.html
> - * http://www.gnu.org/copyleft/gpl.html
> - */
> -
> -/dts-v1/;
> -#include "imx6dl.dtsi"
> -#include "imx6qdl-tx6.dtsi"
> -
> -/ {
> -	model = "Ka-Ro electronics TX6U-811x Module";
> -	compatible = "karo,imx6dl-tx6dl", "fsl,imx6dl";
> -
> -	aliases {
> -		display = &lvds0;
> -		lvds0 = &lvds0;
> -		lvds1 = &lvds1;
> -	};
> -
> -	backlight0: backlight0 {
> -		compatible = "pwm-backlight";
> -		pwms = <&pwm2 0 500000 0>;
> -		power-supply = <&reg_lcd0_pwr>;
> -		/*
> -		 * a poor man's way to create a 1:1 relationship between
> -		 * the PWM value and the actual duty cycle
> -		 */
> -		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
> -				     10 11 12 13 14 15 16 17 18 19
> -				     20 21 22 23 24 25 26 27 28 29
> -				     30 31 32 33 34 35 36 37 38 39
> -				     40 41 42 43 44 45 46 47 48 49
> -				     50 51 52 53 54 55 56 57 58 59
> -				     60 61 62 63 64 65 66 67 68 69
> -				     70 71 72 73 74 75 76 77 78 79
> -				     80 81 82 83 84 85 86 87 88 89
> -				     90 91 92 93 94 95 96 97 98 99
> -				    100>;
> -		default-brightness-level = <50>;
> -	};
> -
> -	backlight1: backlight1 {
> -		compatible = "pwm-backlight";
> -		pwms = <&pwm1 0 500000 0>;
> -		power-supply = <&reg_lcd1_pwr>;
> -		/*
> -		 * a poor man's way to create a 1:1 relationship between
> -		 * the PWM value and the actual duty cycle
> -		 */
> -		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
> -				     10 11 12 13 14 15 16 17 18 19
> -				     20 21 22 23 24 25 26 27 28 29
> -				     30 31 32 33 34 35 36 37 38 39
> -				     40 41 42 43 44 45 46 47 48 49
> -				     50 51 52 53 54 55 56 57 58 59
> -				     60 61 62 63 64 65 66 67 68 69
> -				     70 71 72 73 74 75 76 77 78 79
> -				     80 81 82 83 84 85 86 87 88 89
> -				     90 91 92 93 94 95 96 97 98 99
> -				    100>;
> -		default-brightness-level = <50>;
> -	};
> -};
> -
> -&i2c3 {
> -	polytouch2: eeti at 04 {
> -		compatible = "eeti,egalax_ts";
> -		reg = <0x04>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pinctrl_eeti>;
> -		interrupt-parent = <&gpio3>;
> -		interrupts = <22 0>;
> -		wakeup-gpios = <&gpio3 22 GPIO_ACTIVE_HIGH>;
> -		linux,wakeup;
> -	};
> -};
> -
> -&iomuxc {
> -	imx6dl-tx6u-811x {
> -		pinctrl_eeti: eetigrp {
> -			fsl,pins = <
> -				MX6QDL_PAD_EIM_D22__GPIO3_IO22 0x1b0b1 /* Interrupt */
> -			>;
> -		};
> -	};
> -};
> -
> -&kpp {
> -	status = "disabled"; /* pad conflict with backlight1 PWM */
> -};
> -
> -&ldb {
> -	status = "okay";
> -
> -	lvds0: lvds-channel at 0 {
> -		fsl,data-mapping = "spwg";
> -		fsl,data-width = <18>;
> -		status = "okay";
> -
> -		display-timings {
> -			native-mode = <&lvds_timing0>;
> -			lvds_timing0: hsd100pxn1 {
> -				clock-frequency = <65000000>;
> -				hactive = <1024>;
> -				vactive = <768>;
> -				hback-porch = <220>;
> -				hfront-porch = <40>;
> -				vback-porch = <21>;
> -				vfront-porch = <7>;
> -				hsync-len = <60>;
> -				vsync-len = <10>;
> -				de-active = <1>;
> -				pixelclk-active = <1>;
> -			};
> -		};
> -	};
> -
> -	lvds1: lvds-channel at 1 {
> -		fsl,data-mapping = "spwg";
> -		fsl,data-width = <18>;
> -		status = "disabled";
> -
> -		display-timings {
> -			native-mode = <&lvds_timing1>;
> -			lvds_timing1: hsd100pxn1 {
> -				clock-frequency = <65000000>;
> -				hactive = <1024>;
> -				vactive = <768>;
> -				hback-porch = <220>;
> -				hfront-porch = <40>;
> -				vback-porch = <21>;
> -				vfront-porch = <7>;
> -				hsync-len = <60>;
> -				vsync-len = <10>;
> -				de-active = <1>;
> -				pixelclk-active = <1>;
> -			};
> -		};
> -	};
> -};
> -
> -&pwm1 {
> -	status = "okay";
> -};
> diff --git a/arch/arm/boot/dts/imx6dl-tx6u-81xx.dts b/arch/arm/boot/dts/imx6dl-tx6u-81xx.dts
> new file mode 100644
> index 0000000..5ff8e13
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6dl-tx6u-81xx.dts
> @@ -0,0 +1,156 @@
> +/*
> + * Copyright 2014 Lothar Wa?mann <LW@KARO-electronics.de>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/dts-v1/;
> +#include "imx6dl.dtsi"
> +#include "imx6qdl-tx6.dtsi"
> +
> +/ {
> +	model = "Ka-Ro electronics TX6U-81xx Module";
> +	compatible = "karo,imx6dl-tx6dl", "fsl,imx6dl";
> +
> +	aliases {
> +		display = &lvds0;
> +		lvds0 = &lvds0;
> +		lvds1 = &lvds1;
> +	};
> +
> +	backlight0: backlight0 {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm2 0 500000 0>;
> +		power-supply = <&reg_3v3>;
> +		/*
> +		 * a poor man's way to create a 1:1 relationship between
> +		 * the PWM value and the actual duty cycle
> +		 */
> +		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
> +				     10 11 12 13 14 15 16 17 18 19
> +				     20 21 22 23 24 25 26 27 28 29
> +				     30 31 32 33 34 35 36 37 38 39
> +				     40 41 42 43 44 45 46 47 48 49
> +				     50 51 52 53 54 55 56 57 58 59
> +				     60 61 62 63 64 65 66 67 68 69
> +				     70 71 72 73 74 75 76 77 78 79
> +				     80 81 82 83 84 85 86 87 88 89
> +				     90 91 92 93 94 95 96 97 98 99
> +				    100>;
> +		default-brightness-level = <50>;
> +	};
> +
> +	backlight1: backlight1 {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm1 0 500000 0>;
> +		power-supply = <&reg_3v3>;
> +		/*
> +		 * a poor man's way to create a 1:1 relationship between
> +		 * the PWM value and the actual duty cycle
> +		 */
> +		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
> +				     10 11 12 13 14 15 16 17 18 19
> +				     20 21 22 23 24 25 26 27 28 29
> +				     30 31 32 33 34 35 36 37 38 39
> +				     40 41 42 43 44 45 46 47 48 49
> +				     50 51 52 53 54 55 56 57 58 59
> +				     60 61 62 63 64 65 66 67 68 69
> +				     70 71 72 73 74 75 76 77 78 79
> +				     80 81 82 83 84 85 86 87 88 89
> +				     90 91 92 93 94 95 96 97 98 99
> +				    100>;
> +		default-brightness-level = <50>;
> +	};
> +};
> +
> +&i2c3 {
> +	polytouch1: eeti at 04 {
> +		compatible = "eeti,egalax_ts";
> +		reg = <0x04>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_eeti>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <22 0>;
> +		wakeup-gpios = <&gpio3 22 GPIO_ACTIVE_HIGH>;
> +		linux,wakeup;
> +	};
> +};
> +
> +&iomuxc {
> +	imx6dl-tx6u-81xx {
> +		pinctrl_eeti: eetigrp {
> +			fsl,pins = <
> +				MX6QDL_PAD_EIM_D22__GPIO3_IO22 0x1b0b1 /* Interrupt */
> +			>;
> +		};
> +	};
> +};
> +
> +&kpp {
> +	status = "disabled"; /* pads partially clash with backlight1 PWM */
> +};
> +
> +&ldb {
> +	status = "okay";
> +
> +	lvds0: lvds-channel at 0 {
> +		fsl,data-mapping = "spwg";
> +		fsl,data-width = <18>;
> +		status = "okay";
> +
> +		display-timings {
> +			native-mode = <&lvds0_timing0>;
> +
> +			lvds0_timing0: hsd100pxn1 {
> +				clock-frequency = <65000000>;
> +				hactive = <1024>;
> +				vactive = <768>;
> +				hback-porch = <220>;
> +				hfront-porch = <40>;
> +				vback-porch = <21>;
> +				vfront-porch = <7>;
> +				hsync-len = <60>;
> +				vsync-len = <10>;
> +				hsync-active = <0>;
> +				vsync-active = <0>;
> +				de-active = <1>;
> +				pixelclk-active = <1>;
> +			};
> +		};
> +	};
> +
> +	lvds1: lvds-channel at 1 {
> +		fsl,data-mapping = "spwg";
> +		fsl,data-width = <18>;
> +		status = "disabled";
> +
> +		display-timings {
> +			native-mode = <&lvds1_timing0>;
> +
> +			lvds1_timing0: hsd100pxn1 {
> +				clock-frequency = <65000000>;
> +				hactive = <1024>;
> +				vactive = <768>;
> +				hback-porch = <220>;
> +				hfront-porch = <40>;
> +				vback-porch = <21>;
> +				vfront-porch = <7>;
> +				hsync-len = <60>;
> +				vsync-len = <10>;
> +				hsync-active = <0>;
> +				vsync-active = <0>;
> +				de-active = <1>;
> +				pixelclk-active = <1>;
> +			};
> +		};
> +	};
> +};
> +
> +&pwm1 {
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dts b/arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dts
> deleted file mode 100644
> index b18fae1..0000000
> --- a/arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dts
> +++ /dev/null
> @@ -1,103 +0,0 @@
> -/*
> - * Copyright 2014 Lothar Wa?mann <LW@KARO-electronics.de>
> - *
> - * The code contained herein is licensed under the GNU General Public
> - * License. You may obtain a copy of the GNU General Public License
> - * Version 2 at the following locations:
> - *
> - * http://www.opensource.org/licenses/gpl-license.html
> - * http://www.gnu.org/copyleft/gpl.html
> - */
> -
> -/dts-v1/;
> -#include "imx6q.dtsi"
> -#include "imx6qdl-tx6.dtsi"
> -
> -/ {
> -	model = "Ka-Ro electronics TX6Q-1010 Module on CoMpact TFT";
> -	compatible = "karo,imx6q-tx6q", "fsl,imx6q";
> -
> -	aliases {
> -		display = &display;
> -	};
> -
> -	backlight: backlight {
> -		compatible = "pwm-backlight";
> -		pwms = <&pwm2 0 500000 0>;
> -		power-supply = <&reg_3v3>;
> -		/*
> -		 * a poor man's way to create a 1:1 relationship between
> -		 * the PWM value and the actual duty cycle
> -		 */
> -		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
> -				     10 11 12 13 14 15 16 17 18 19
> -				     20 21 22 23 24 25 26 27 28 29
> -				     30 31 32 33 34 35 36 37 38 39
> -				     40 41 42 43 44 45 46 47 48 49
> -				     50 51 52 53 54 55 56 57 58 59
> -				     60 61 62 63 64 65 66 67 68 69
> -				     70 71 72 73 74 75 76 77 78 79
> -				     80 81 82 83 84 85 86 87 88 89
> -				     90 91 92 93 94 95 96 97 98 99
> -				    100>;
> -		default-brightness-level = <50>;
> -	};
> -
> -	display: display at di0 {
> -		compatible = "fsl,imx-parallel-display";
> -		interface-pix-fmt = "rgb24";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pinctrl_disp0_1>;
> -		status = "okay";
> -
> -		port {
> -			display0_in: endpoint {
> -				remote-endpoint = <&ipu1_di0_disp0>;
> -			};
> -		};
> -
> -		display-timings {
> -			native-mode = <&ET070001DM6>;
> -
> -			ET070001DM6: CoMTFT { /* same as ET0700 but with inverted pixel clock */
> -				clock-frequency = <33264000>;
> -				hactive = <800>;
> -				vactive = <480>;
> -				hback-porch = <88>;
> -				hsync-len = <128>;
> -				hfront-porch = <40>;
> -				vback-porch = <33>;
> -				vsync-len = <2>;
> -				vfront-porch = <10>;
> -				hsync-active = <0>;
> -				vsync-active = <0>;
> -				de-active = <1>;
> -				pixelclk-active = <1>;
> -			};
> -		};
> -        };
> -};
> -
> -&can1 {
> -	status = "disabled";
> -};
> -
> -&can2 {
> -	xceiver-supply = <&reg_3v3>;
> -};
> -
> -&ipu1_di0_disp0 {
> -	remote-endpoint = <&display0_in>;
> -};
> -
> -&kpp {
> -	status = "disabled";
> -};
> -
> -&reg_can_xcvr {
> -	status = "disabled";
> -};
> -
> -&touchscreen {
> -	status = "disabled";
> -};
> diff --git a/arch/arm/boot/dts/imx6q-tx6q-1010.dts b/arch/arm/boot/dts/imx6q-tx6q-1010.dts
> deleted file mode 100644
> index b58ec9c..0000000
> --- a/arch/arm/boot/dts/imx6q-tx6q-1010.dts
> +++ /dev/null
> @@ -1,177 +0,0 @@
> -/*
> - * Copyright 2014 Lothar Wa?mann <LW@KARO-electronics.de>
> - *
> - * The code contained herein is licensed under the GNU General Public
> - * License. You may obtain a copy of the GNU General Public License
> - * Version 2 at the following locations:
> - *
> - * http://www.opensource.org/licenses/gpl-license.html
> - * http://www.gnu.org/copyleft/gpl.html
> - */
> -
> -/dts-v1/;
> -#include "imx6q.dtsi"
> -#include "imx6qdl-tx6.dtsi"
> -
> -/ {
> -	model = "Ka-Ro electronics TX6Q-1010 Module";
> -	compatible = "karo,imx6q-tx6q", "fsl,imx6q";
> -
> -	aliases {
> -		display = &display;
> -	};
> -
> -	backlight: backlight {
> -		compatible = "pwm-backlight";
> -		pwms = <&pwm2 0 500000 PWM_POLARITY_INVERTED>;
> -		power-supply = <&reg_3v3>;
> -		/*
> -		 * a poor man's way to create a 1:1 relationship between
> -		 * the PWM value and the actual duty cycle
> -		 */
> -		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
> -				     10 11 12 13 14 15 16 17 18 19
> -				     20 21 22 23 24 25 26 27 28 29
> -				     30 31 32 33 34 35 36 37 38 39
> -				     40 41 42 43 44 45 46 47 48 49
> -				     50 51 52 53 54 55 56 57 58 59
> -				     60 61 62 63 64 65 66 67 68 69
> -				     70 71 72 73 74 75 76 77 78 79
> -				     80 81 82 83 84 85 86 87 88 89
> -				     90 91 92 93 94 95 96 97 98 99
> -				    100>;
> -		default-brightness-level = <50>;
> -	};
> -
> -	display: display at di0 {
> -		compatible = "fsl,imx-parallel-display";
> -		interface-pix-fmt = "rgb24";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pinctrl_disp0_1>;
> -		status = "okay";
> -
> -		port {
> -			display0_in: endpoint {
> -				remote-endpoint = <&ipu1_di0_disp0>;
> -			};
> -		};
> -
> -		display-timings {
> -			VGA {
> -				clock-frequency = <25200000>;
> -				hactive = <640>;
> -				vactive = <480>;
> -				hback-porch = <48>;
> -				hsync-len = <96>;
> -				hfront-porch = <16>;
> -				vback-porch = <31>;
> -				vsync-len = <2>;
> -				vfront-porch = <12>;
> -				hsync-active = <0>;
> -				vsync-active = <0>;
> -				de-active = <1>;
> -				pixelclk-active = <0>;
> -			};
> -
> -			ETV570 {
> -				clock-frequency = <25200000>;
> -				hactive = <640>;
> -				vactive = <480>;
> -				hback-porch = <114>;
> -				hsync-len = <30>;
> -				hfront-porch = <16>;
> -				vback-porch = <32>;
> -				vsync-len = <3>;
> -				vfront-porch = <10>;
> -				hsync-active = <0>;
> -				vsync-active = <0>;
> -				de-active = <1>;
> -				pixelclk-active = <0>;
> -			};
> -
> -			ET0350 {
> -				clock-frequency = <6413760>;
> -				hactive = <320>;
> -				vactive = <240>;
> -				hback-porch = <34>;
> -				hsync-len = <34>;
> -				hfront-porch = <20>;
> -				vback-porch = <15>;
> -				vsync-len = <3>;
> -				vfront-porch = <4>;
> -				hsync-active = <0>;
> -				vsync-active = <0>;
> -				de-active = <1>;
> -				pixelclk-active = <0>;
> -			};
> -
> -			ET0430 {
> -				clock-frequency = <9009000>;
> -				hactive = <480>;
> -				vactive = <272>;
> -				hback-porch = <2>;
> -				hsync-len = <41>;
> -				hfront-porch = <2>;
> -				vback-porch = <2>;
> -				vsync-len = <10>;
> -				vfront-porch = <2>;
> -				hsync-active = <0>;
> -				vsync-active = <0>;
> -				de-active = <1>;
> -				pixelclk-active = <1>;
> -			};
> -
> -			ET0500 {
> -				clock-frequency = <33264000>;
> -				hactive = <800>;
> -				vactive = <480>;
> -				hback-porch = <88>;
> -				hsync-len = <128>;
> -				hfront-porch = <40>;
> -				vback-porch = <33>;
> -				vsync-len = <2>;
> -				vfront-porch = <10>;
> -				hsync-active = <0>;
> -				vsync-active = <0>;
> -				de-active = <1>;
> -				pixelclk-active = <0>;
> -			};
> -
> -			ET0700 { /* same as ET0500 */
> -				clock-frequency = <33264000>;
> -				hactive = <800>;
> -				vactive = <480>;
> -				hback-porch = <88>;
> -				hsync-len = <128>;
> -				hfront-porch = <40>;
> -				vback-porch = <33>;
> -				vsync-len = <2>;
> -				vfront-porch = <10>;
> -				hsync-active = <0>;
> -				vsync-active = <0>;
> -				de-active = <1>;
> -				pixelclk-active = <0>;
> -			};
> -
> -			ETQ570 {
> -				clock-frequency = <6596040>;
> -				hactive = <320>;
> -				vactive = <240>;
> -				hback-porch = <38>;
> -				hsync-len = <30>;
> -				hfront-porch = <30>;
> -				vback-porch = <16>;
> -				vsync-len = <3>;
> -				vfront-porch = <4>;
> -				hsync-active = <0>;
> -				vsync-active = <0>;
> -				de-active = <1>;
> -				pixelclk-active = <0>;
> -			};
> -		};
> -        };
> -};
> -
> -&ipu1_di0_disp0 {
> -	remote-endpoint = <&display0_in>;
> -};
> diff --git a/arch/arm/boot/dts/imx6q-tx6q-10x0-comtft.dts b/arch/arm/boot/dts/imx6q-tx6q-10x0-comtft.dts
> new file mode 100644
> index 0000000..8997553
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-tx6q-10x0-comtft.dts
> @@ -0,0 +1,119 @@
> +/*
> + * Copyright 2014 Lothar Wa?mann <LW@KARO-electronics.de>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/dts-v1/;
> +#include "imx6q.dtsi"
> +#include "imx6qdl-tx6.dtsi"
> +
> +/ {
> +	model = "Ka-Ro electronics TX6Q-1010/-1030 Module on CoMpact TFT";
> +	compatible = "karo,imx6q-tx6q", "fsl,imx6q";
> +
> +	aliases {
> +		display = &mxcfb0;
> +		mxcfb0 = &mxcfb0;
> +	};
> +
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm2 0 500000 0>;
> +		power-supply = <&reg_3v3>;
> +		/*
> +		 * a poor man's way to create a 1:1 relationship between
> +		 * the PWM value and the actual duty cycle
> +		 */
> +		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
> +				     10 11 12 13 14 15 16 17 18 19
> +				     20 21 22 23 24 25 26 27 28 29
> +				     30 31 32 33 34 35 36 37 38 39
> +				     40 41 42 43 44 45 46 47 48 49
> +				     50 51 52 53 54 55 56 57 58 59
> +				     60 61 62 63 64 65 66 67 68 69
> +				     70 71 72 73 74 75 76 77 78 79
> +				     80 81 82 83 84 85 86 87 88 89
> +				     90 91 92 93 94 95 96 97 98 99
> +				    100>;
> +		default-brightness-level = <50>;
> +	};
> +
> +	mxcfb0: fb at 2 {
> +		compatible = "fsl,mxc_sdc_fb";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_disp0_2>;
> +		disp_dev = "lcd";
> +		interface_pix_fmt = "RGB24";
> +		mode_str = "";
> +		default_bpp = <32>;
> +		int_clk = <1>;
> +		late_init = <0>;
> +		status = "okay";
> +
> +		display-timings {
> +			native-mode = <&ET070001DM6>;
> +
> +			ET070001DM6: CoMTFT { /* same as ET0700 but with inverted pixel clock */
> +				clock-frequency = <33264000>;
> +				hactive = <800>;
> +				vactive = <480>;
> +				hback-porch = <88>;
> +				hsync-len = <128>;
> +				hfront-porch = <40>;
> +				vback-porch = <33>;
> +				vsync-len = <2>;
> +				vfront-porch = <10>;
> +				hsync-active = <0>;
> +				vsync-active = <0>;
> +				de-active = <1>;
> +				pixelclk-active = <1>;
> +			};
> +		};
> +	};
> +
> +	lcd: lcd at 0 {
> +		compatible = "fsl,lcd";
> +		ipu_id = <0>;
> +		disp_id = <0>;
> +		default_ifmt = "RGB24";
> +		status = "okay";
> +	};
> +};
> +
> +&can1 {
> +	status = "disabled";
> +};
> +
> +&can2 {
> +	xceiver-supply = <&reg_3v3>;
> +};
> +
> +&ipu2 {
> +	status = "disabled";
> +};
> +
> +&kpp {
> +	status = "disabled";
> +};
> +
> +&reg_can_xcvr {
> +	status = "disabled";
> +};
> +
> +&reg_lcd0_pwr {
> +	status = "okay";
> +};
> +
> +&reg_lcd1_pwr {
> +	status = "okay";
> +};
> +
> +&touchscreen {
> +	status = "disabled";
> +};
> diff --git a/arch/arm/boot/dts/imx6q-tx6q-10x0.dts b/arch/arm/boot/dts/imx6q-tx6q-10x0.dts
> new file mode 100644
> index 0000000..c3782af
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-tx6q-10x0.dts
> @@ -0,0 +1,191 @@
> +/*
> + * Copyright 2014 Lothar Wa?mann <LW@KARO-electronics.de>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/dts-v1/;
> +#include "imx6q.dtsi"
> +#include "imx6qdl-tx6.dtsi"
> +
> +/ {
> +	model = "Ka-Ro electronics TX6Q-1010/-1030 Module";
> +	compatible = "karo,imx6q-tx6q", "fsl,imx6q";
> +
> +	aliases {
> +		display = &display;
> +		ipu1 = &ipu1;
> +		ipu2 = &ipu2;
> +	};
> +
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm2 0 500000 PWM_POLARITY_INVERTED>;
> +		power-supply = <&reg_3v3>;
> +		/*
> +		 * a poor man's way to create a 1:1 relationship between
> +		 * the PWM value and the actual duty cycle
> +		 */
> +		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
> +				     10 11 12 13 14 15 16 17 18 19
> +				     20 21 22 23 24 25 26 27 28 29
> +				     30 31 32 33 34 35 36 37 38 39
> +				     40 41 42 43 44 45 46 47 48 49
> +				     50 51 52 53 54 55 56 57 58 59
> +				     60 61 62 63 64 65 66 67 68 69
> +				     70 71 72 73 74 75 76 77 78 79
> +				     80 81 82 83 84 85 86 87 88 89
> +				     90 91 92 93 94 95 96 97 98 99
> +				    100>;
> +		default-brightness-level = <50>;
> +	};
> +
> +	display: display at di0 {
> +		compatible = "fsl,imx-parallel-display";
> +		interface-pix-fmt = "rgb24";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_disp0_1>;
> +		status = "okay";
> +
> +		port {
> +			display0_in: endpoint {
> +				remote-endpoint = <&ipu1_di0_disp0>;
> +			};
> +		};
> +
> +		display-timings {
> +			VGA {
> +				clock-frequency = <25200000>;
> +				hactive = <640>;
> +				vactive = <480>;
> +				hback-porch = <48>;
> +				hsync-len = <96>;
> +				hfront-porch = <16>;
> +				vback-porch = <31>;
> +				vsync-len = <2>;
> +				vfront-porch = <12>;
> +				hsync-active = <0>;
> +				vsync-active = <0>;
> +				de-active = <1>;
> +				pixelclk-active = <0>;
> +			};
> +
> +			ETV570 {
> +				clock-frequency = <25200000>;
> +				hactive = <640>;
> +				vactive = <480>;
> +				hback-porch = <114>;
> +				hsync-len = <30>;
> +				hfront-porch = <16>;
> +				vback-porch = <32>;
> +				vsync-len = <3>;
> +				vfront-porch = <10>;
> +				hsync-active = <0>;
> +				vsync-active = <0>;
> +				de-active = <1>;
> +				pixelclk-active = <0>;
> +			};
> +
> +			ET0350 {
> +				clock-frequency = <6413760>;
> +				hactive = <320>;
> +				vactive = <240>;
> +				hback-porch = <34>;
> +				hsync-len = <34>;
> +				hfront-porch = <20>;
> +				vback-porch = <15>;
> +				vsync-len = <3>;
> +				vfront-porch = <4>;
> +				hsync-active = <0>;
> +				vsync-active = <0>;
> +				de-active = <1>;
> +				pixelclk-active = <0>;
> +			};
> +
> +			ET0430 {
> +				clock-frequency = <9009000>;
> +				hactive = <480>;
> +				vactive = <272>;
> +				hback-porch = <2>;
> +				hsync-len = <41>;
> +				hfront-porch = <2>;
> +				vback-porch = <2>;
> +				vsync-len = <10>;
> +				vfront-porch = <2>;
> +				hsync-active = <0>;
> +				vsync-active = <0>;
> +				de-active = <1>;
> +				pixelclk-active = <1>;
> +			};
> +
> +			ET0500 {
> +				clock-frequency = <33264000>;
> +				hactive = <800>;
> +				vactive = <480>;
> +				hback-porch = <88>;
> +				hsync-len = <128>;
> +				hfront-porch = <40>;
> +				vback-porch = <33>;
> +				vsync-len = <2>;
> +				vfront-porch = <10>;
> +				hsync-active = <0>;
> +				vsync-active = <0>;
> +				de-active = <1>;
> +				pixelclk-active = <0>;
> +			};
> +
> +			ET0700 { /* same as ET0500 */
> +				clock-frequency = <33264000>;
> +				hactive = <800>;
> +				vactive = <480>;
> +				hback-porch = <88>;
> +				hsync-len = <128>;
> +				hfront-porch = <40>;
> +				vback-porch = <33>;
> +				vsync-len = <2>;
> +				vfront-porch = <10>;
> +				hsync-active = <0>;
> +				vsync-active = <0>;
> +				de-active = <1>;
> +				pixelclk-active = <0>;
> +			};
> +
> +			ETQ570 {
> +				clock-frequency = <6596040>;
> +				hactive = <320>;
> +				vactive = <240>;
> +				hback-porch = <38>;
> +				hsync-len = <30>;
> +				hfront-porch = <30>;
> +				vback-porch = <16>;
> +				vsync-len = <3>;
> +				vfront-porch = <4>;
> +				hsync-active = <0>;
> +				vsync-active = <0>;
> +				de-active = <1>;
> +				pixelclk-active = <0>;
> +			};
> +		};
> +	};
> +};
> +
> +&ipu1_di0_disp0 {
> +	remote-endpoint = <&display0_in>;
> +};
> +
> +&ipu2 {
> +	status = "disabled";
> +};
> +
> +&reg_lcd0_pwr {
> +	status = "okay";
> +};
> +
> +&reg_lcd1_pwr {
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/imx6q-tx6q-1110.dts b/arch/arm/boot/dts/imx6q-tx6q-1110.dts
> deleted file mode 100644
> index 88aa1e4..0000000
> --- a/arch/arm/boot/dts/imx6q-tx6q-1110.dts
> +++ /dev/null
> @@ -1,154 +0,0 @@
> -/*
> - * Copyright 2014 Lothar Wa?mann <LW@KARO-electronics.de>
> - *
> - * The code contained herein is licensed under the GNU General Public
> - * License. You may obtain a copy of the GNU General Public License
> - * Version 2 at the following locations:
> - *
> - * http://www.opensource.org/licenses/gpl-license.html
> - * http://www.gnu.org/copyleft/gpl.html
> - */
> -
> -/dts-v1/;
> -#include "imx6q.dtsi"
> -#include "imx6qdl-tx6.dtsi"
> -
> -/ {
> -	model = "Ka-Ro electronics TX6Q-1110 Module";
> -	compatible = "karo,imx6q-tx6q", "fsl,imx6q";
> -
> -	aliases {
> -		display = &lvds0;
> -		lvds0 = &lvds0;
> -		lvds1 = &lvds1;
> -	};
> -
> -	backlight0: backlight0 {
> -		compatible = "pwm-backlight";
> -		pwms = <&pwm2 0 500000 0>;
> -		power-supply = <&reg_lcd0_pwr>;
> -		/*
> -		 * a poor man's way to create a 1:1 relationship between
> -		 * the PWM value and the actual duty cycle
> -		 */
> -		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
> -				     10 11 12 13 14 15 16 17 18 19
> -				     20 21 22 23 24 25 26 27 28 29
> -				     30 31 32 33 34 35 36 37 38 39
> -				     40 41 42 43 44 45 46 47 48 49
> -				     50 51 52 53 54 55 56 57 58 59
> -				     60 61 62 63 64 65 66 67 68 69
> -				     70 71 72 73 74 75 76 77 78 79
> -				     80 81 82 83 84 85 86 87 88 89
> -				     90 91 92 93 94 95 96 97 98 99
> -				    100>;
> -		default-brightness-level = <50>;
> -	};
> -
> -	backlight1: backlight1 {
> -		compatible = "pwm-backlight";
> -		pwms = <&pwm1 0 500000 0>;
> -		power-supply = <&reg_lcd1_pwr>;
> -		/*
> -		 * a poor man's way to create a 1:1 relationship between
> -		 * the PWM value and the actual duty cycle
> -		 */
> -		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
> -				     10 11 12 13 14 15 16 17 18 19
> -				     20 21 22 23 24 25 26 27 28 29
> -				     30 31 32 33 34 35 36 37 38 39
> -				     40 41 42 43 44 45 46 47 48 49
> -				     50 51 52 53 54 55 56 57 58 59
> -				     60 61 62 63 64 65 66 67 68 69
> -				     70 71 72 73 74 75 76 77 78 79
> -				     80 81 82 83 84 85 86 87 88 89
> -				     90 91 92 93 94 95 96 97 98 99
> -				    100>;
> -		default-brightness-level = <50>;
> -	};
> -};
> -
> -&i2c3 {
> -	polytouch1: eeti at 04 {
> -		compatible = "eeti,egalax_ts";
> -		reg = <0x04>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pinctrl_eeti>;
> -		interrupt-parent = <&gpio3>;
> -		interrupts = <22 0>;
> -		wakeup-gpios = <&gpio3 22 GPIO_ACTIVE_HIGH>;
> -		linux,wakeup;
> -	};
> -};
> -
> -&iomuxc {
> -	imx6q-tx6q-1110 {
> -		pinctrl_eeti: eetigrp {
> -			fsl,pins = <
> -				MX6QDL_PAD_EIM_D22__GPIO3_IO22 0x1b0b1 /* Interrupt */
> -			>;
> -		};
> -	};
> -};
> -
> -&kpp {
> -	status = "disabled"; /* pad conflict with backlight1 PWM */
> -};
> -
> -&ldb {
> -	status = "okay";
> -
> -	lvds0: lvds-channel at 0 {
> -		fsl,data-mapping = "spwg";
> -		fsl,data-width = <18>;
> -		status = "okay";
> -
> -		display-timings {
> -			native-mode = <&lvds_timing0>;
> -			lvds_timing0: hsd100pxn1 {
> -				clock-frequency = <65000000>;
> -				hactive = <1024>;
> -				vactive = <768>;
> -				hback-porch = <220>;
> -				hfront-porch = <40>;
> -				vback-porch = <21>;
> -				vfront-porch = <7>;
> -				hsync-len = <60>;
> -				vsync-len = <10>;
> -				de-active = <1>;
> -				pixelclk-active = <1>;
> -			};
> -		};
> -	};
> -
> -	lvds1: lvds-channel at 1 {
> -		fsl,data-mapping = "spwg";
> -		fsl,data-width = <18>;
> -		status = "disabled";
> -
> -		display-timings {
> -			native-mode = <&lvds_timing1>;
> -			lvds_timing1: hsd100pxn1 {
> -				clock-frequency = <65000000>;
> -				hactive = <1024>;
> -				vactive = <768>;
> -				hback-porch = <220>;
> -				hfront-porch = <40>;
> -				vback-porch = <21>;
> -				vfront-porch = <7>;
> -				hsync-len = <60>;
> -				vsync-len = <10>;
> -				de-active = <1>;
> -				pixelclk-active = <1>;
> -			};
> -		};
> -	};
> -};
> -
> -&pwm1 {
> -	status = "okay";
> -};
> -
> -&sata {
> -	status = "okay";
> -};
> diff --git a/arch/arm/boot/dts/imx6q-tx6q-11x0.dts b/arch/arm/boot/dts/imx6q-tx6q-11x0.dts
> new file mode 100644
> index 0000000..c66524b
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-tx6q-11x0.dts
> @@ -0,0 +1,249 @@
> +/*
> + * Copyright 2014 Lothar Wa?mann <LW@KARO-electronics.de>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/dts-v1/;
> +#include "imx6q.dtsi"
> +#include "imx6qdl-tx6.dtsi"
> +
> +/ {
> +	model = "Ka-Ro electronics TX6Q-1110/-1130 Module";
> +	compatible = "karo,imx6q-tx6q", "fsl,imx6q";
> +
> +	aliases {
> +		display = &lvds0;
> +		ipu1 = &ipu2;
> +		lvds0 = &lvds0;
> +		lvds1 = &lvds1;
> +		mxcfb0 = &lvds0;
> +		mxcfb1 = &lvds1;
> +	};
> +
> +	backlight0: backlight0 {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm2 0 500000 0>;
> +		/*
> +		 * a poor man's way to create a 1:1 relationship between
> +		 * the PWM value and the actual duty cycle
> +		 */
> +		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
> +				     10 11 12 13 14 15 16 17 18 19
> +				     20 21 22 23 24 25 26 27 28 29
> +				     30 31 32 33 34 35 36 37 38 39
> +				     40 41 42 43 44 45 46 47 48 49
> +				     50 51 52 53 54 55 56 57 58 59
> +				     60 61 62 63 64 65 66 67 68 69
> +				     70 71 72 73 74 75 76 77 78 79
> +				     80 81 82 83 84 85 86 87 88 89
> +				     90 91 92 93 94 95 96 97 98 99
> +				    100>;
> +		default-brightness-level = <50>;
> +	};
> +
> +	backlight1: backlight1 {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm1 0 500000 0>;
> +		/*
> +		 * a poor man's way to create a 1:1 relationship between
> +		 * the PWM value and the actual duty cycle
> +		 */
> +		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
> +				     10 11 12 13 14 15 16 17 18 19
> +				     20 21 22 23 24 25 26 27 28 29
> +				     30 31 32 33 34 35 36 37 38 39
> +				     40 41 42 43 44 45 46 47 48 49
> +				     50 51 52 53 54 55 56 57 58 59
> +				     60 61 62 63 64 65 66 67 68 69
> +				     70 71 72 73 74 75 76 77 78 79
> +				     80 81 82 83 84 85 86 87 88 89
> +				     90 91 92 93 94 95 96 97 98 99
> +				    100>;
> +		default-brightness-level = <50>;
> +	};
> +
> +	lvds0: fb at 0 {
> +		compatible = "fsl,mxc_sdc_fb";
> +		disp_dev = "ldb";
> +		interface_pix_fmt = "RGB666";
> +		mode_str = "LDB-XGA";
> +		default_bpp = <32>;
> +		int_clk = <0>;
> +		late_init = <0>;
> +		fsl,data-mapping = "spwg";
> +		fsl,data-width = <18>;
> +		status = "okay";
> +
> +		display-timings {
> +			native-mode = <&lvds0_timing0>;
> +
> +			lvds0_timing0: hsd100pxn1 {
> +				clock-frequency = <65000000>;
> +				hactive = <1024>;
> +				vactive = <768>;
> +				hback-porch = <220>;
> +				hfront-porch = <40>;
> +				vback-porch = <21>;
> +				vfront-porch = <7>;
> +				hsync-len = <60>;
> +				vsync-len = <10>;
> +				hsync-active = <0>;
> +				vsync-active = <0>;
> +				de-active = <1>;
> +				pixelclk-active = <1>;
> +			};
> +
> +			lvds0_timing1: VGA {
> +				clock-frequency = <25200000>;
> +				hactive = <640>;
> +				vactive = <480>;
> +				hback-porch = <48>;
> +				hfront-porch = <16>;
> +				vback-porch = <31>;
> +				vfront-porch = <12>;
> +				hsync-len = <96>;
> +				vsync-len = <2>;
> +				hsync-active = <0>;
> +				vsync-active = <0>;
> +				de-active = <1>;
> +				pixelclk-active = <0>;
> +			};
> +
> +			lvds0_timing2: nl12880bc20 {
> +				clock-frequency = <71000000>;
> +				hactive = <1280>;
> +				vactive = <800>;
> +				hback-porch = <50>;
> +				hfront-porch = <50>;
> +				vback-porch = <5>;
> +				vfront-porch = <5>;
> +				hsync-len = <60>;
> +				vsync-len = <13>;
> +				hsync-active = <0>;
> +				vsync-active = <0>;
> +				de-active = <1>;
> +				pixelclk-active = <0>;
> +			};
> +		};
> +	};
> +
> +	lvds1: fb at 1 {
> +		compatible = "fsl,mxc_sdc_fb";
> +		disp_dev = "ldb";
> +		interface_pix_fmt = "RGB666";
> +		mode_str = "LDB-XGA";
> +		default_bpp = <32>;
> +		int_clk = <0>;
> +		late_init = <0>;
> +		fsl,data-mapping = "spwg";
> +		fsl,data-width = <18>;
> +		status = "okay";
> +
> +		display-timings {
> +			native-mode = <&lvds1_timing0>;
> +
> +			lvds1_timing0: hsd100pxn1 {
> +				clock-frequency = <65000000>;
> +				hactive = <1024>;
> +				vactive = <768>;
> +				hback-porch = <220>;
> +				hfront-porch = <40>;
> +				vback-porch = <21>;
> +				vfront-porch = <7>;
> +				hsync-len = <60>;
> +				vsync-len = <10>;
> +				hsync-active = <0>;
> +				vsync-active = <0>;
> +				de-active = <1>;
> +				pixelclk-active = <0>;
> +			};
> +
> +			lvds1_timing1: VGA {
> +				clock-frequency = <25200000>;
> +				hactive = <640>;
> +				vactive = <480>;
> +				hback-porch = <48>;
> +				hfront-porch = <16>;
> +				vback-porch = <31>;
> +				vfront-porch = <12>;
> +				hsync-len = <96>;
> +				vsync-len = <2>;
> +				hsync-active = <0>;
> +				vsync-active = <0>;
> +				de-active = <1>;
> +				pixelclk-active = <0>;
> +			};
> +
> +			lvds1_timing2: nl12880bc20 {
> +				clock-frequency = <71000000>;
> +				hactive = <1280>;
> +				vactive = <800>;
> +				hback-porch = <50>;
> +				hfront-porch = <50>;
> +				vback-porch = <5>;
> +				vfront-porch = <5>;
> +				hsync-len = <60>;
> +				vsync-len = <13>;
> +				hsync-active = <0>;
> +				vsync-active = <0>;
> +				de-active = <1>;
> +				pixelclk-active = <0>;
> +			};
> +		};
> +	};
> +};
> +
> +&i2c3 {
> +	polytouch1: eeti at 04 {
> +		compatible = "eeti,egalax_ts";
> +		reg = <0x04>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_eeti>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <22 0>;
> +		wakeup-gpios = <&gpio3 22 GPIO_ACTIVE_HIGH>;
> +		linux,wakeup;
> +	};
> +};
> +
> +&iomuxc {
> +	imx6q-tx6q-11x0 {
> +		pinctrl_eeti: eetigrp {
> +			fsl,pins = <
> +				MX6QDL_PAD_EIM_D22__GPIO3_IO22 0x1b0b1 /* Interrupt */
> +			>;
> +		};
> +	};
> +};
> +
> +&ipu2 {
> +	status = "disabled";
> +};
> +
> +&kpp {
> +	status = "disabled"; /* pads partially clash with backlight1 PWM */
> +};
> +
> +&ldb {
> +	ipu_id = <0>;
> +	disp_id = <0>;
> +	ext_ref = <0>;
> +	mode = "sep0";
> +	sec_ipu_id = <0>;
> +	sec_disp_id = <1>;
> +	status = "okay";
> +};
> +
> +&pwm1 {
> +	status = "okay";
> +};
> +
> +&sata {
> +	status = "okay";
> +};
> -- 
> 2.1.4
> 
> 
