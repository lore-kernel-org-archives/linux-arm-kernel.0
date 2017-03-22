From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 22 Mar 2017 15:32:17 +0800
Subject: [PATCH] ARM: dts: imx: add Gateworks Ventana GW5903 support
In-Reply-To: <1490125452-5712-1-git-send-email-tharvey@gateworks.com>
References: <1490125452-5712-1-git-send-email-tharvey@gateworks.com>
Message-ID: <20170322073213.GL3443@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 21, 2017 at 12:44:12PM -0700, Tim Harvey wrote:
> The Gateworks Ventana GW5903 is a single-board computer based on the NXP
> IMX6 SoC with the following features:
>  * IMX6 DualLite Soc (supports IMX6S,IMX6DL,IMX6Q)
>  * 4GiB DDR3 DRAM
>  * 32GB eMMC
>  * 1x microSD connector
>  * Gateworks System Controller:
>   - hardware watchdog
>   - hardware monitor
>   - pushbutton controller
>   - EEPROM storage
>   - power control
>  * JTAG programmable
>  * Inertial Module
>  * uBlox EMMY-W1 (bluetooth/nfc/802.11ac)
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  arch/arm/boot/dts/Makefile            |   2 +
>  arch/arm/boot/dts/imx6dl-gw5903.dts   |  55 +++
>  arch/arm/boot/dts/imx6q-gw5903.dts    |  55 +++
>  arch/arm/boot/dts/imx6qdl-gw5903.dtsi | 660 ++++++++++++++++++++++++++++++++++
>  4 files changed, 772 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6dl-gw5903.dts
>  create mode 100644 arch/arm/boot/dts/imx6q-gw5903.dts
>  create mode 100644 arch/arm/boot/dts/imx6qdl-gw5903.dtsi
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 7e2adf0..9e907cd 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -352,6 +352,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>  	imx6dl-gw551x.dtb \
>  	imx6dl-gw552x.dtb \
>  	imx6dl-gw553x.dtb \
> +	imx6dl-gw5903.dtb \
>  	imx6dl-gw5904.dtb \
>  	imx6dl-hummingboard.dtb \
>  	imx6dl-icore.dtb \
> @@ -396,6 +397,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>  	imx6q-gw551x.dtb \
>  	imx6q-gw552x.dtb \
>  	imx6q-gw553x.dtb \
> +	imx6q-gw5903.dtb \
>  	imx6q-gw5904.dtb \
>  	imx6q-h100.dtb \
>  	imx6q-hummingboard.dtb \
> diff --git a/arch/arm/boot/dts/imx6dl-gw5903.dts b/arch/arm/boot/dts/imx6dl-gw5903.dts
> new file mode 100644
> index 0000000..103261e
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6dl-gw5903.dts
> @@ -0,0 +1,55 @@
> +/*
> + * Copyright 2017 Gateworks Corporation
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of
> + *     the License, or (at your option) any later version.
> + *
> + *     This file is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + *     You should have received a copy of the GNU General Public
> + *     License along with this file; if not, write to the Free
> + *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
> + *     MA 02110-1301 USA
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +/dts-v1/;
> +#include "imx6dl.dtsi"
> +#include "imx6qdl-gw5903.dtsi"
> +
> +/ {
> +	model = "Gateworks Ventana i.MX6 Duallite/Solo GW5903";
> +	compatible = "gw,imx6dl-gw5903", "gw,ventana", "fsl,imx6dl";
> +};
> diff --git a/arch/arm/boot/dts/imx6q-gw5903.dts b/arch/arm/boot/dts/imx6q-gw5903.dts
> new file mode 100644
> index 0000000..a182e4c
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-gw5903.dts
> @@ -0,0 +1,55 @@
> +/*
> + * Copyright 2017 Gateworks Corporation
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of
> + *     the License, or (at your option) any later version.
> + *
> + *     This file is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + *     You should have received a copy of the GNU General Public
> + *     License along with this file; if not, write to the Free
> + *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
> + *     MA 02110-1301 USA
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +/dts-v1/;
> +#include "imx6q.dtsi"
> +#include "imx6qdl-gw5903.dtsi"
> +
> +/ {
> +	model = "Gateworks Ventana i.MX6 Dual/Quad GW5903";
> +	compatible = "gw,imx6q-gw5903", "gw,ventana", "fsl,imx6q";
> +};
> diff --git a/arch/arm/boot/dts/imx6qdl-gw5903.dtsi b/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
> new file mode 100644
> index 0000000..41f390e
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
> @@ -0,0 +1,660 @@
> +/*
> + * Copyright 2017 Gateworks Corporation
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of
> + *     the License, or (at your option) any later version.
> + *
> + *     This file is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + *     You should have received a copy of the GNU General Public
> + *     License along with this file; if not, write to the Free
> + *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
> + *     MA 02110-1301 USA
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	chosen {
> +		bootargs = "console=ttymxc1,115200";

stdout-path please.

> +	};
> +
> +	backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm1 0 5000000>;
> +		brightness-levels = <
> +			0  /*1  2  3  4  5  6*/  7  8  9

Why are 1 ~ 6 commented out?

> +			10 11 12 13 14 15 16 17 18 19
> +			20 21 22 23 24 25 26 27 28 29
> +			30 31 32 33 34 35 36 37 38 39
> +			40 41 42 43 44 45 46 47 48 49
> +			50 51 52 53 54 55 56 57 58 59
> +			60 61 62 63 64 65 66 67 68 69
> +			70 71 72 73 74 75 76 77 78 79
> +			80 81 82 83 84 85 86 87 88 89
> +			90 91 92 93 94 95 96 97 98 99
> +			100
> +			>;
> +		default-brightness-level = <94>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_leds>;

It configures GPIO6_IO14 ...

> +
> +		led0: user1 {
> +			label = "user1";
> +			gpios = <&gpio6 11 GPIO_ACTIVE_LOW>; /* MX6_LOCLED# */

... it use gpio6_11 however?

> +			default-state = "off";
> +		};
> +	};
> +
> +	memory {
> +		reg = <0x10000000 0x40000000>;
> +	};
> +
> +	reg_5p0v: regulator-5p0v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "5P0V";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +	};
> +
> +	reg_3p3v: regulator-3p3v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "3P3V";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +	};
> +
> +	reg_2p5v: regulator-2p5v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "2P5V";
> +		regulator-min-microvolt = <2500000>;
> +		regulator-max-microvolt = <2500000>;
> +		regulator-always-on;
> +	};
> +
> +	reg_usb_h1_vbus: regulator-usb-h1-vbus {
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb_h1_vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&gpio3 30 0>;
> +		enable-active-high;
> +	};
> +
> +	reg_usb_otg_vbus: regulator-usb-otg-vbus {
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb_otg_vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&gpio4 15 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reg_12p0: regulator-12p0v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "12P0V";
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +		gpio = <&gpio1 7 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	sound {
> +		compatible = "fsl,imx-audio-tlv320";
> +		model = "imx-tlv320";
> +		ssi-controller = <&ssi1>;
> +		audio-codec = <&tlv320aic3105>;
> +		/* routing of sink, soruce */

s/soruce/source?

> +		audio-routing =
> +			/* TLV320 LINE1L pin <-> Mic Jack connector */
> +			"LINE1L", "Mic Jack",
> +			/* board Headphone Jack <-> HPOUT */
> +			"Headphone Jack", "HPLOUT",
> +			"Headphone Jack", "HPROUT",
> +			"Mic Jack", "Mic Bias";
> +		mux-int-port = <1>;
> +		mux-ext-port = <6>;
> +	};
> +};
> +
> +&audmux {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_audmux>;
> +	status = "okay";
> +};
> +
> +&clks {
> +	assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
> +			  <&clks IMX6QDL_CLK_LDB_DI1_SEL>;
> +	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL3_USB_OTG>,
> +				 <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
> +};
> +
> +&fec {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_enet>;
> +	phy-mode = "rgmii-id";
> +	pinctrl-assert-gpios = <&gpio1 25 GPIO_ACTIVE_HIGH>; /* PHY_EN */

Unsupported bindings?

> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	status = "okay";
> +
> +	pca9555: gpio at 23 {
> +		compatible = "nxp,pca9555";
> +		reg = <0x23>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};
> +
> +	eeprom1: eeprom at 50 {
> +		compatible = "atmel,24c02";
> +		reg = <0x50>;
> +		pagesize = <16>;
> +	};
> +
> +	eeprom2: eeprom at 51 {
> +		compatible = "atmel,24c02";
> +		reg = <0x51>;
> +		pagesize = <16>;
> +	};
> +
> +	eeprom3: eeprom at 52 {
> +		compatible = "atmel,24c02";
> +		reg = <0x52>;
> +		pagesize = <16>;
> +	};
> +
> +	eeprom4: eeprom at 53 {
> +		compatible = "atmel,24c02";
> +		reg = <0x53>;
> +		pagesize = <16>;
> +	};
> +
> +	dts1672: rtc at 68 {
> +		compatible = "dallas,ds1672";
> +		reg = <0x68>;
> +	};
> +};
> +
> +&i2c2 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	status = "okay";
> +
> +	ltc3676: pmic at 3c {
> +		compatible = "lltc,ltc3676";
> +		reg = <0x3c>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
> +
> +		regulators {
> +			/* VDD_1P8 (1+R1/R2 = 2.505): Aud/eMMC/microSD/Touch */
> +			reg_1p8v: sw1 {
> +				regulator-name = "vdd1p8";
> +				regulator-min-microvolt = <1033310>;
> +				regulator-max-microvolt = <2004000>;
> +				lltc,fb-voltage-divider = <301000 200000>;
> +				regulator-ramp-delay = <7000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			/* VDD_DDR (1+R1/R2 = 2.105) */
> +			reg_vdd_ddr: sw2 {
> +				regulator-name = "vddddr";
> +				regulator-min-microvolt = <868310>;
> +				regulator-max-microvolt = <1684000>;
> +				lltc,fb-voltage-divider = <221000 200000>;
> +				regulator-ramp-delay = <7000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			/* VDD_ARM (1+R1/R2 = 1.635) */
> +			reg_vdd_arm: sw3 {
> +				regulator-name = "vddarm";
> +				regulator-min-microvolt = <674400>;
> +				regulator-max-microvolt = <1308000>;
> +				lltc,fb-voltage-divider = <127000 200000>;
> +				regulator-ramp-delay = <7000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				linux,phandle = <&reg_vdd_arm>;
> +			};
> +
> +			/* VDD_SOC (1+R1/R2 = 1.635) */
> +			reg_vdd_soc: sw4 {
> +				regulator-name = "vddsoc";
> +				regulator-min-microvolt = <674400>;
> +				regulator-max-microvolt = <1308000>;
> +				lltc,fb-voltage-divider = <127000 200000>;
> +				regulator-ramp-delay = <7000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				linux,phandle = <&reg_vdd_soc>;
> +			};
> +
> +			/* VDD_1P0 (1+R1/R2 = 1.38): */
> +			reg_1p0v: ldo2 {
> +				regulator-name = "vdd1p0";
> +				regulator-min-microvolt = <1002777>;
> +				regulator-max-microvolt = <1002777>;
> +				lltc,fb-voltage-divider = <100000 261000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			/* VDD_HIGH (1+R1/R2 = 4.17) */
> +			reg_3p0v: ldo4 {
> +				regulator-name = "vdd3p0";
> +				regulator-min-microvolt = <3023250>;
> +				regulator-max-microvolt = <3023250>;
> +				lltc,fb-voltage-divider = <634000 200000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +};
> +
> +&i2c3 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	status = "okay";
> +
> +	tlv320aic3105: codec at 18 {
> +		compatible = "ti,tlv320aic3x";
> +		reg = <0x18>;
> +		gpio-reset = <&gpio5 17 GPIO_ACTIVE_LOW>;
> +		clocks = <&clks IMX6QDL_CLK_CKO>;
> +		ai3x-micbias-vg = <2>; /* MICBIAS_2_5V */
> +		status = "okay";

The okay status shouldn't be needed for this node.

> +

We do not usually have newlines in middle of property list.

> +		/* Regulators */
> +		DRVDD-supply = <&reg_3p3v>;
> +		AVDD-supply = <&reg_3p3v>;
> +		IOVDD-supply = <&reg_3p3v>;
> +		DVDD-supply = <&reg_1p8v>;
> +	};
> +
> +	/* accelerometer */
> +	mma8653fc at 1d {

Node name should probably be accelerometer, so that the comment above
can be saved.

> +		compatible = "fsl,mma8451";
> +		reg = <0x1d>;
> +		interrupt-parent = <&gpio7>;
> +		interrupts = <11 IRQ_TYPE_EDGE_RISING>;
> +		interrupt-route = <1>;
> +		position = <7>;
> +		vdd-supply = <&reg_3p3v>;

Quite a few property cannot be found in bindings/iio/accel/mma8452.txt.

> +	};
> +
> +	/* headphone detect */
> +	ts3a227e at 3b {
> +		compatible = "ti,ts3a227e";
> +		reg = <0x3b>;
> +		interrupt-parent = <&gpio5>;
> +		interrupts = <15 IRQ_TYPE_LEVEL_LOW>;
> +		ti,micbias = <4>; /* 2.5V micbias */
> +	};
> +};

Shawn
