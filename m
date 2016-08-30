From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 30 Aug 2016 20:25:41 +0800
Subject: [PATCH v3] ARM: dts: imx6ul-geam: Add Engicam IMX6UL GEA M6UL
 initial support
In-Reply-To: <1472548411-25018-1-git-send-email-jagan@amarulasolutions.com>
References: <1472548411-25018-1-git-send-email-jagan@amarulasolutions.com>
Message-ID: <20160830122541.GD8363@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2016 at 02:43:31PM +0530, Jagan Teki wrote:

<snip>

> +&lcdif {
> +	display = <&display0>;
> +	status = "okay";
> +
> +	display0: display {
> +		bits-per-pixel = <16>;
> +		bus-width = <18>;
> +
> +		display-timings {
> +			native-mode = <&timing0>;
> +			timing0: timing0 {
> +				clock-frequency = <28000000>;
> +				hactive = <800>;
> +				vactive = <480>;
> +				hfront-porch = <30>;
> +				hback-porch = <30>;
> +				hsync-len = <64>;
> +				vback-porch = <5>;
> +				vfront-porch = <5>;
> +				vsync-len = <20>;
> +

Drop this newline.

> +				hsync-active = <0>;
> +				vsync-active = <0>;
> +				de-active = <1>;
> +				pixelclk-active = <0>;
> +			};
> +		};
> +	};
> +};
> +
> +&usdhc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	status = "okay";
> +};
> +
> +&tsc {
> +	measure_delay_time = <0x1ffff>;

measure-delay-time

> +	pre_charge_time = <0x1fff>;

pre-charge-time

> +	status = "okay";
> +};

<snip>

> +&gpmi {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_gpmi_nand>;
> +	status = "okay";

Please put 'status' property at the end of property list.

> +	nand-on-flash-bbt;
> +};
> +
> +&lcdif {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_lcdif_dat
> +		     &pinctrl_lcdif_ctrl>;
> +	display = <&display0>;

It is set in imx6ul-geam-kit.dts, isn't it?

> +};

<snip>
j
> +&i2c1 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	status = "okay";
> +};
> +
> +&i2c2 {

Except &iomuxc, please sort these node alphabetically in name.

> +	clock_frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +

Drop this newline.

> +	pinctrl_enet1: enet1grp {
> +		fsl,pins = <
> +			MX6UL_PAD_ENET1_RX_EN__ENET1_RX_EN	0x1b0b0
> +			MX6UL_PAD_ENET1_RX_DATA0__ENET1_RDATA00	0x1b0b0
> +			MX6UL_PAD_ENET1_RX_DATA1__ENET1_RDATA01	0x1b0b0
> +			MX6UL_PAD_ENET1_TX_EN__ENET1_TX_EN	0x1b0b0
> +			MX6UL_PAD_ENET1_TX_DATA0__ENET1_TDATA00	0x1b0b0
> +			MX6UL_PAD_ENET1_TX_DATA1__ENET1_TDATA01	0x1b0b0
> +			MX6UL_PAD_ENET1_TX_CLK__ENET1_REF_CLK1	0x4001b031
> +		>;
> +	};

<snip>

> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins = <
> +			MX6UL_PAD_CSI_VSYNC__USDHC2_CLK     0x17070
> +			MX6UL_PAD_CSI_HSYNC__USDHC2_CMD     0x10070
> +			MX6UL_PAD_CSI_DATA00__USDHC2_DATA0  0x17070
> +			MX6UL_PAD_CSI_DATA01__USDHC2_DATA1  0x17070
> +			MX6UL_PAD_CSI_DATA02__USDHC2_DATA2  0x17070
> +			MX6UL_PAD_CSI_DATA03__USDHC2_DATA3  0x17070
> +		>;
> +	};
> +
> +	pinctrl_tsc: tscgrp {

This one is not sorted.

Shawn

> +		fsl,pin = <
> +			MX6UL_PAD_GPIO1_IO01__GPIO1_IO01	0xb0
> +			MX6UL_PAD_GPIO1_IO02__GPIO1_IO02	0xb0
> +			MX6UL_PAD_GPIO1_IO03__GPIO1_IO03	0xb0
> +			MX6UL_PAD_GPIO1_IO04__GPIO1_IO04	0xb0
> +		>;
> +	};
> +};
> -- 
> 2.7.4
> 
