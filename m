From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 22 Jul 2013 15:55:54 +0800
Subject: [PATCH 1/2] ARM: dts: mx6: Add support for mx6q nitrogen board
In-Reply-To: <1374118960-19060-1-git-send-email-festevam@gmail.com>
References: <1374118960-19060-1-git-send-email-festevam@gmail.com>
Message-ID: <20130722075552.GB20271@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 12:42:39AM -0300, Fabio Estevam wrote:
> +&ecspi1 {
> +	fsl,spi-num-chipselects = <1>;
> +	cs-gpios = <&gpio3 19 0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi1_1>;
> +	status = "okay";
> +
> +	flash: m25p80 at 0 {
> +		compatible = "sst,sst25vf016b";
> +		spi-max-frequency = <20000000>;
> +		reg = <0>;
> +	};
> +};
> +
> +&ssi1 {
> +	fsl,mode = "i2s-slave";
> +	status = "okay";
> +};
> +

Please take the chance to sort these node alphabetically.

Shawn

> +&iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hog>;
> +
> +	hog {
> +		pinctrl_hog: hoggrp {
> +			fsl,pins = <
> +				MX6QDL_PAD_NANDF_D6__GPIO2_IO06 0x80000000
> +				MX6QDL_PAD_NANDF_D7__GPIO2_IO07 0x80000000
> +				MX6QDL_PAD_EIM_D19__GPIO3_IO19  0x80000000
> +				MX6QDL_PAD_EIM_D22__GPIO3_IO22  0x80000000
> +				MX6QDL_PAD_EIM_D23__GPIO3_IO23  0x80000000
> +				MX6QDL_PAD_SD3_DAT5__GPIO7_IO00 0x80000000
> +				MX6QDL_PAD_SD3_DAT4__GPIO7_IO01 0x1f0b0
> +				MX6QDL_PAD_GPIO_0__CCM_CLKO1    0x80000000
> +			>;
> +		};
> +	};
> +};
> +
> +&usbotg {
> +	vbus-supply = <&reg_usb_otg_vbus>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usbotg_1>;
> +	disable-over-current;
> +	status = "okay";
> +};
> +
> +&usbh1 {
> +	status = "okay";
> +};
> +
> +&fec {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_enet_1>;
> +	phy-mode = "rgmii";
> +	phy-reset-gpios = <&gpio3 23 0>;
> +	status = "okay";
> +};
> +
> +&usdhc3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc3_2>;
> +	cd-gpios = <&gpio7 0 0>;
> +	wp-gpios = <&gpio7 1 0>;
> +	vmmc-supply = <&reg_3p3v>;
> +	status = "okay";
> +};
> +
> +&usdhc4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc4_2>;
> +	cd-gpios = <&gpio2 6 0>;
> +	wp-gpios = <&gpio2 7 0>;
> +	vmmc-supply = <&reg_3p3v>;
> +	status = "okay";
> +};
> +
> +&audmux {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_audmux_1>;
> +};
> +
> +&uart2 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2_1>;
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1_1>;
> +
> +	codec: sgtl5000 at 0a {
> +		compatible = "fsl,sgtl5000";
> +		reg = <0x0a>;
> +		clocks = <&clks 169>;
> +		VDDA-supply = <&reg_2p5v>;
> +		VDDIO-supply = <&reg_3p3v>;
> +	};
> +};
> -- 
> 1.8.1.2
> 
