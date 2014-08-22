From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 22 Aug 2014 15:46:05 +0800
Subject: [PATCH v2] ARM: dts: Gateworks GW5520 support (i.MX6)
In-Reply-To: <1408679706-18200-1-git-send-email-tharvey@gateworks.com>
References: <1407572602-14017-1-git-send-email-tharvey@gateworks.com>
 <1408679706-18200-1-git-send-email-tharvey@gateworks.com>
Message-ID: <20140822074604.GB2540@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 21, 2014 at 08:55:06PM -0700, Tim Harvey wrote:
> +&iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hog>;

  DTC     arch/arm/boot/dts/imx6dl-gw552x.dtb
ERROR (phandle_references): Reference to non-existent node or label "pinctrl_hog"

> +
> +	imx6qdl-gw552x {
> +		pinctrl_gpio: gpiogrp {
> +			fsl,pins = <
> +				MX6QDL_PAD_GPIO_9__GPIO1_IO09	0x4001b0b0 /* USBHUB_RST# */
> +				MX6QDL_PAD_GPIO_17__GPIO7_IO12	0x4001b0b0 /* PCIESKT_WDIS# */
> +			>;
> +		};

pinctrl_gpio is not referenced by any client device, so kernel will not
set up these two pins.

Shawn

> +
> +		pinctrl_gpio_leds: gpioledsgrp {
> +			fsl,pins = <
> +				MX6QDL_PAD_KEY_COL0__GPIO4_IO06		0x1b0b0
> +				MX6QDL_PAD_KEY_ROW0__GPIO4_IO07		0x1b0b0
> +				MX6QDL_PAD_KEY_ROW4__GPIO4_IO15		0x1b0b0
> +			>;
> +		};
> +
> +		pinctrl_gpmi_nand: gpminandgrp {
> +			fsl,pins = <
> +				MX6QDL_PAD_NANDF_CLE__NAND_CLE		0xb0b1
> +				MX6QDL_PAD_NANDF_ALE__NAND_ALE		0xb0b1
> +				MX6QDL_PAD_NANDF_WP_B__NAND_WP_B	0xb0b1
> +				MX6QDL_PAD_NANDF_RB0__NAND_READY_B	0xb000
> +				MX6QDL_PAD_NANDF_CS0__NAND_CE0_B	0xb0b1
> +				MX6QDL_PAD_NANDF_CS1__NAND_CE1_B	0xb0b1
> +				MX6QDL_PAD_SD4_CMD__NAND_RE_B		0xb0b1
> +				MX6QDL_PAD_SD4_CLK__NAND_WE_B		0xb0b1
> +				MX6QDL_PAD_NANDF_D0__NAND_DATA00	0xb0b1
> +				MX6QDL_PAD_NANDF_D1__NAND_DATA01	0xb0b1
> +				MX6QDL_PAD_NANDF_D2__NAND_DATA02	0xb0b1
> +				MX6QDL_PAD_NANDF_D3__NAND_DATA03	0xb0b1
> +				MX6QDL_PAD_NANDF_D4__NAND_DATA04	0xb0b1
> +				MX6QDL_PAD_NANDF_D5__NAND_DATA05	0xb0b1
> +				MX6QDL_PAD_NANDF_D6__NAND_DATA06	0xb0b1
> +				MX6QDL_PAD_NANDF_D7__NAND_DATA07	0xb0b1
> +			>;
> +		};
> +
> +		pinctrl_i2c1: i2c1grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_EIM_D21__I2C1_SCL		0x4001b8b1
> +				MX6QDL_PAD_EIM_D28__I2C1_SDA		0x4001b8b1
> +			>;
> +		};
> +
> +		pinctrl_i2c2: i2c2grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_KEY_COL3__I2C2_SCL		0x4001b8b1
> +				MX6QDL_PAD_KEY_ROW3__I2C2_SDA		0x4001b8b1
> +			>;
> +		};
> +
> +		pinctrl_i2c3: i2c3grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_GPIO_3__I2C3_SCL		0x4001b8b1
> +				MX6QDL_PAD_GPIO_6__I2C3_SDA		0x4001b8b1
> +			>;
> +		};
> +
> +		pinctrl_pcie: pciegrp {
> +			fsl,pins = <
> +				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29	0x1b0b0
> +			>;
> +		};
> +
> +		pinctrl_uart2: uart2grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_SD4_DAT7__UART2_TX_DATA	0x1b0b1
> +				MX6QDL_PAD_SD4_DAT4__UART2_RX_DATA	0x1b0b1
> +			>;
> +		};
> +
> +		pinctrl_uart3: uart3grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_EIM_D24__UART3_TX_DATA	0x1b0b1
> +				MX6QDL_PAD_EIM_D25__UART3_RX_DATA	0x1b0b1
> +			>;
> +		};
> +
> +		pinctrl_uart5: uart5grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_KEY_COL1__UART5_TX_DATA	0x1b0b1
> +				MX6QDL_PAD_KEY_ROW1__UART5_RX_DATA	0x1b0b1
> +			>;
> +                };
> +	};
> +};
> -- 
> 1.8.3.2
> 
