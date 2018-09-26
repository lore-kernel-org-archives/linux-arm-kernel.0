From: aisheng.dong@nxp.com (A.s. Dong)
Date: Wed, 26 Sep 2018 14:29:05 +0000
Subject: [PATCh v3 3/4] arm64: add support for i.MX8M EVK board
In-Reply-To: <20180921125626.21971-3-l.stach@pengutronix.de>
References: <20180921125626.21971-1-l.stach@pengutronix.de>
 <20180921125626.21971-3-l.stach@pengutronix.de>
Message-ID: <AM0PR04MB42114C0C434A90BBC091701B80150@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Lucas Stach [mailto:l.stach at pengutronix.de]
> Sent: Friday, September 21, 2018 8:56 PM
> To: Shawn Guo <shawnguo@kernel.org>; Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>; Catalin Marinas
> <catalin.marinas@arm.com>; Will Deacon <will.deacon@arm.com>;
> Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> <fabio.estevam@nxp.com>; dl-linux-imx <linux-imx@nxp.com>;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> patchwork-lst at pengutronix.de; Abel Vesa <abel.vesa@nxp.com>
> Subject: [PATCh v3 3/4] arm64: add support for i.MX8M EVK board
> 
> This is the evaluation kit board for the i.MX8M. The current level of support
> yields a working console and is able to boot userspace from SD card or
> Network.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com> (v1)
> Tested-by: Tested-by: Baruch Siach <baruch@tkos.co.il> (v1)


[...]

> +&iomuxc {
> +	pinctrl_fec1: fec1grp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_ENET_MDC_ENET1_MDC			0x3
> +			MX8MQ_IOMUXC_ENET_MDIO_ENET1_MDIO		0x23
> +			MX8MQ_IOMUXC_ENET_TD3_ENET1_RGMII_TD3		0x1f
> +			MX8MQ_IOMUXC_ENET_TD2_ENET1_RGMII_TD2		0x1f
> +			MX8MQ_IOMUXC_ENET_TD1_ENET1_RGMII_TD1		0x1f
> +			MX8MQ_IOMUXC_ENET_TD0_ENET1_RGMII_TD0		0x1f
> +			MX8MQ_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0x91
> +			MX8MQ_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x91
> +			MX8MQ_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x91
> +			MX8MQ_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x91
> +			MX8MQ_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x1f
> +			MX8MQ_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x91
> +			MX8MQ_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
> +			MX8MQ_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
> +			MX8MQ_IOMUXC_GPIO1_IO09_GPIO1_IO9		0x19
> +		>;
> +	};
> +
> +

One more unnecessary blank line.

Otherwise:
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng

> +	pinctrl_i2c1: i2c1grp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_I2C1_SCL_I2C1_SCL			0x4000007f
> +			MX8MQ_IOMUXC_I2C1_SDA_I2C1_SDA
> 	0x4000007f
> +		>;
> +	};
> +
> +	pinctrl_reg_usdhc2: regusdhc2grpgpio {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_SD2_RESET_B_GPIO2_IO19		0x41
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_UART1_RXD_UART1_DCE_RX		0x49
> +			MX8MQ_IOMUXC_UART1_TXD_UART1_DCE_TX		0x49
> +		>;
> +	};
> +
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x83
> +			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xc3
> +			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xc3
> +			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xc3
> +			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xc3
> +			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xc3
> +			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xc3
> +			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xc3
> +			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xc3
> +			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xc3
> +			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x83
> +			MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_100mhz: usdhc1-100grp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x85
> +			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xc5
> +			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xc5
> +			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xc5
> +			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xc5
> +			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xc5
> +			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xc5
> +			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xc5
> +			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xc5
> +			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xc5
> +			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x85
> +			MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_200mhz: usdhc1-200grp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x87
> +			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xc7
> +			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xc7
> +			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xc7
> +			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xc7
> +			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xc7
> +			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xc7
> +			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xc7
> +			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xc7
> +			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xc7
> +			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x87
> +			MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
> +		>;
> +	};
> +
> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x83
> +			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc3
> +			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc3
> +			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc3
> +			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc3
> +			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc3
> +			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_100mhz: usdhc2-100grp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x85
> +			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc5
> +			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc5
> +			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc5
> +			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc5
> +			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc5
> +			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_200mhz: usdhc2-200grp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x87
> +			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc7
> +			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc7
> +			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc7
> +			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc7
> +			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc7
> +			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
> +		>;
> +	};
> +};
> --
> 2.19.0
