From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 18 Feb 2014 15:17:08 +0100
Subject: [PATCH 2/3] ARM: dts: imx6sl: move pingroups back into soc dtsi
In-Reply-To: <10555869.uLtJmrqZh3@phil>
References: <10555869.uLtJmrqZh3@phil>
Message-ID: <2746462.2Wuo7TxMql@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Heiko Stuebner <heiko.stuebner@bqreaders.com>

Using the delete-unreferenced flag, the pingroups can be kept globally but won't
be unecessarily included in dts files not using them.

Signed-off-by: Heiko Stuebner <heiko.stuebner@bqreaders.com>
---
 arch/arm/boot/dts/imx6sl-evk.dts | 181 --------------------------------------
 arch/arm/boot/dts/imx6sl.dtsi    | 185 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 185 insertions(+), 181 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
index 889422c..07876e0 100644
--- a/arch/arm/boot/dts/imx6sl-evk.dts
+++ b/arch/arm/boot/dts/imx6sl-evk.dts
@@ -267,192 +267,11 @@
 			>;
 		};
 
-		pinctrl_audmux3: audmux3grp {
-			fsl,pins = <
-				MX6SL_PAD_AUD_RXD__AUD3_RXD	  0x4130b0
-				MX6SL_PAD_AUD_TXC__AUD3_TXC	  0x4130b0
-				MX6SL_PAD_AUD_TXD__AUD3_TXD	  0x4110b0
-				MX6SL_PAD_AUD_TXFS__AUD3_TXFS	  0x4130b0
-			>;
-		};
-
-		pinctrl_ecspi1: ecspi1grp {
-			fsl,pins = <
-				MX6SL_PAD_ECSPI1_MISO__ECSPI1_MISO	0x100b1
-				MX6SL_PAD_ECSPI1_MOSI__ECSPI1_MOSI	0x100b1
-				MX6SL_PAD_ECSPI1_SCLK__ECSPI1_SCLK	0x100b1
-			>;
-		};
-
-		pinctrl_fec: fecgrp {
-			fsl,pins = <
-				MX6SL_PAD_FEC_MDC__FEC_MDC		0x1b0b0
-				MX6SL_PAD_FEC_MDIO__FEC_MDIO		0x1b0b0
-				MX6SL_PAD_FEC_CRS_DV__FEC_RX_DV		0x1b0b0
-				MX6SL_PAD_FEC_RXD0__FEC_RX_DATA0	0x1b0b0
-				MX6SL_PAD_FEC_RXD1__FEC_RX_DATA1	0x1b0b0
-				MX6SL_PAD_FEC_TX_EN__FEC_TX_EN		0x1b0b0
-				MX6SL_PAD_FEC_TXD0__FEC_TX_DATA0	0x1b0b0
-				MX6SL_PAD_FEC_TXD1__FEC_TX_DATA1	0x1b0b0
-				MX6SL_PAD_FEC_REF_CLK__FEC_REF_OUT	0x4001b0a8
-			>;
-		};
-
-		pinctrl_i2c1: i2c1grp {
-			fsl,pins = <
-				MX6SL_PAD_I2C1_SCL__I2C1_SCL	0x4001b8b1
-				MX6SL_PAD_I2C1_SDA__I2C1_SDA	0x4001b8b1
-			>;
-		};
-
-
-		pinctrl_i2c2: i2c2grp {
-			fsl,pins = <
-				MX6SL_PAD_I2C2_SCL__I2C2_SCL	0x4001b8b1
-				MX6SL_PAD_I2C2_SDA__I2C2_SDA	0x4001b8b1
-			>;
-		};
-
 		pinctrl_led: ledgrp {
 			fsl,pins = <
 				MX6SL_PAD_HSIC_STROBE__GPIO3_IO20 0x17059
 			>;
 		};
-
-		pinctrl_kpp: kppgrp {
-			fsl,pins = <
-				MX6SL_PAD_KEY_ROW0__KEY_ROW0    0x1b010
-				MX6SL_PAD_KEY_ROW1__KEY_ROW1    0x1b010
-				MX6SL_PAD_KEY_ROW2__KEY_ROW2    0x1b0b0
-				MX6SL_PAD_KEY_COL0__KEY_COL0    0x110b0
-				MX6SL_PAD_KEY_COL1__KEY_COL1    0x110b0
-				MX6SL_PAD_KEY_COL2__KEY_COL2    0x110b0
-			>;
-		};
-
-		pinctrl_uart1: uart1grp {
-			fsl,pins = <
-				MX6SL_PAD_UART1_RXD__UART1_RX_DATA	0x1b0b1
-				MX6SL_PAD_UART1_TXD__UART1_TX_DATA	0x1b0b1
-			>;
-		};
-
-		pinctrl_usbotg1: usbotg1grp {
-			fsl,pins = <
-				MX6SL_PAD_EPDC_PWRCOM__USB_OTG1_ID	0x17059
-			>;
-		};
-
-		pinctrl_usdhc1: usdhc1grp {
-			fsl,pins = <
-				MX6SL_PAD_SD1_CMD__SD1_CMD		0x17059
-				MX6SL_PAD_SD1_CLK__SD1_CLK		0x10059
-				MX6SL_PAD_SD1_DAT0__SD1_DATA0		0x17059
-				MX6SL_PAD_SD1_DAT1__SD1_DATA1		0x17059
-				MX6SL_PAD_SD1_DAT2__SD1_DATA2		0x17059
-				MX6SL_PAD_SD1_DAT3__SD1_DATA3		0x17059
-				MX6SL_PAD_SD1_DAT4__SD1_DATA4		0x17059
-				MX6SL_PAD_SD1_DAT5__SD1_DATA5		0x17059
-				MX6SL_PAD_SD1_DAT6__SD1_DATA6		0x17059
-				MX6SL_PAD_SD1_DAT7__SD1_DATA7		0x17059
-			>;
-		};
-
-		pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
-			fsl,pins = <
-				MX6SL_PAD_SD1_CMD__SD1_CMD		0x170b9
-				MX6SL_PAD_SD1_CLK__SD1_CLK		0x100b9
-				MX6SL_PAD_SD1_DAT0__SD1_DATA0		0x170b9
-				MX6SL_PAD_SD1_DAT1__SD1_DATA1		0x170b9
-				MX6SL_PAD_SD1_DAT2__SD1_DATA2		0x170b9
-				MX6SL_PAD_SD1_DAT3__SD1_DATA3		0x170b9
-				MX6SL_PAD_SD1_DAT4__SD1_DATA4		0x170b9
-				MX6SL_PAD_SD1_DAT5__SD1_DATA5		0x170b9
-				MX6SL_PAD_SD1_DAT6__SD1_DATA6		0x170b9
-				MX6SL_PAD_SD1_DAT7__SD1_DATA7		0x170b9
-			>;
-		};
-
-		pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
-			fsl,pins = <
-				MX6SL_PAD_SD1_CMD__SD1_CMD		0x170f9
-				MX6SL_PAD_SD1_CLK__SD1_CLK		0x100f9
-				MX6SL_PAD_SD1_DAT0__SD1_DATA0		0x170f9
-				MX6SL_PAD_SD1_DAT1__SD1_DATA1		0x170f9
-				MX6SL_PAD_SD1_DAT2__SD1_DATA2		0x170f9
-				MX6SL_PAD_SD1_DAT3__SD1_DATA3		0x170f9
-				MX6SL_PAD_SD1_DAT4__SD1_DATA4		0x170f9
-				MX6SL_PAD_SD1_DAT5__SD1_DATA5		0x170f9
-				MX6SL_PAD_SD1_DAT6__SD1_DATA6		0x170f9
-				MX6SL_PAD_SD1_DAT7__SD1_DATA7		0x170f9
-			>;
-		};
-
-		pinctrl_usdhc2: usdhc2grp {
-			fsl,pins = <
-				MX6SL_PAD_SD2_CMD__SD2_CMD		0x17059
-				MX6SL_PAD_SD2_CLK__SD2_CLK		0x10059
-				MX6SL_PAD_SD2_DAT0__SD2_DATA0		0x17059
-				MX6SL_PAD_SD2_DAT1__SD2_DATA1		0x17059
-				MX6SL_PAD_SD2_DAT2__SD2_DATA2		0x17059
-				MX6SL_PAD_SD2_DAT3__SD2_DATA3		0x17059
-			>;
-		};
-
-		pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
-			fsl,pins = <
-				MX6SL_PAD_SD2_CMD__SD2_CMD		0x170b9
-				MX6SL_PAD_SD2_CLK__SD2_CLK		0x100b9
-				MX6SL_PAD_SD2_DAT0__SD2_DATA0		0x170b9
-				MX6SL_PAD_SD2_DAT1__SD2_DATA1		0x170b9
-				MX6SL_PAD_SD2_DAT2__SD2_DATA2		0x170b9
-				MX6SL_PAD_SD2_DAT3__SD2_DATA3		0x170b9
-			>;
-		};
-
-		pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
-			fsl,pins = <
-				MX6SL_PAD_SD2_CMD__SD2_CMD		0x170f9
-				MX6SL_PAD_SD2_CLK__SD2_CLK		0x100f9
-				MX6SL_PAD_SD2_DAT0__SD2_DATA0		0x170f9
-				MX6SL_PAD_SD2_DAT1__SD2_DATA1		0x170f9
-				MX6SL_PAD_SD2_DAT2__SD2_DATA2		0x170f9
-				MX6SL_PAD_SD2_DAT3__SD2_DATA3		0x170f9
-			>;
-		};
-
-		pinctrl_usdhc3: usdhc3grp {
-			fsl,pins = <
-				MX6SL_PAD_SD3_CMD__SD3_CMD		0x17059
-				MX6SL_PAD_SD3_CLK__SD3_CLK		0x10059
-				MX6SL_PAD_SD3_DAT0__SD3_DATA0		0x17059
-				MX6SL_PAD_SD3_DAT1__SD3_DATA1		0x17059
-				MX6SL_PAD_SD3_DAT2__SD3_DATA2		0x17059
-				MX6SL_PAD_SD3_DAT3__SD3_DATA3		0x17059
-			>;
-		};
-
-		pinctrl_usdhc3_100mhz: usdhc3grp100mhz {
-			fsl,pins = <
-				MX6SL_PAD_SD3_CMD__SD3_CMD		0x170b9
-				MX6SL_PAD_SD3_CLK__SD3_CLK		0x100b9
-				MX6SL_PAD_SD3_DAT0__SD3_DATA0		0x170b9
-				MX6SL_PAD_SD3_DAT1__SD3_DATA1		0x170b9
-				MX6SL_PAD_SD3_DAT2__SD3_DATA2		0x170b9
-				MX6SL_PAD_SD3_DAT3__SD3_DATA3		0x170b9
-			>;
-		};
-
-		pinctrl_usdhc3_200mhz: usdhc3grp200mhz {
-			fsl,pins = <
-				MX6SL_PAD_SD3_CMD__SD3_CMD		0x170f9
-				MX6SL_PAD_SD3_CLK__SD3_CLK		0x100f9
-				MX6SL_PAD_SD3_DAT0__SD3_DATA0		0x170f9
-				MX6SL_PAD_SD3_DAT1__SD3_DATA1		0x170f9
-				MX6SL_PAD_SD3_DAT2__SD3_DATA2		0x170f9
-				MX6SL_PAD_SD3_DAT3__SD3_DATA3		0x170f9
-			>;
-		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 3cb4941..2d176f0 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -797,3 +797,188 @@
 		};
 	};
 };
+
+
+&iomuxc {
+	imx6sl {
+		/delete-unreferenced/ pinctrl_audmux3: audmux3grp {
+			fsl,pins = <
+				MX6SL_PAD_AUD_RXD__AUD3_RXD	  0x4130b0
+				MX6SL_PAD_AUD_TXC__AUD3_TXC	  0x4130b0
+				MX6SL_PAD_AUD_TXD__AUD3_TXD	  0x4110b0
+				MX6SL_PAD_AUD_TXFS__AUD3_TXFS	  0x4130b0
+			>;
+		};
+
+		/delete-unreferenced/ pinctrl_ecspi1: ecspi1grp {
+			fsl,pins = <
+				MX6SL_PAD_ECSPI1_MISO__ECSPI1_MISO	0x100b1
+				MX6SL_PAD_ECSPI1_MOSI__ECSPI1_MOSI	0x100b1
+				MX6SL_PAD_ECSPI1_SCLK__ECSPI1_SCLK	0x100b1
+			>;
+		};
+
+		/delete-unreferenced/ pinctrl_fec: fecgrp {
+			fsl,pins = <
+				MX6SL_PAD_FEC_MDC__FEC_MDC		0x1b0b0
+				MX6SL_PAD_FEC_MDIO__FEC_MDIO		0x1b0b0
+				MX6SL_PAD_FEC_CRS_DV__FEC_RX_DV		0x1b0b0
+				MX6SL_PAD_FEC_RXD0__FEC_RX_DATA0	0x1b0b0
+				MX6SL_PAD_FEC_RXD1__FEC_RX_DATA1	0x1b0b0
+				MX6SL_PAD_FEC_TX_EN__FEC_TX_EN		0x1b0b0
+				MX6SL_PAD_FEC_TXD0__FEC_TX_DATA0	0x1b0b0
+				MX6SL_PAD_FEC_TXD1__FEC_TX_DATA1	0x1b0b0
+				MX6SL_PAD_FEC_REF_CLK__FEC_REF_OUT	0x4001b0a8
+			>;
+		};
+
+		/delete-unreferenced/ pinctrl_i2c1: i2c1grp {
+			fsl,pins = <
+				MX6SL_PAD_I2C1_SCL__I2C1_SCL	0x4001b8b1
+				MX6SL_PAD_I2C1_SDA__I2C1_SDA	0x4001b8b1
+			>;
+		};
+
+		/delete-unreferenced/ pinctrl_i2c2: i2c2grp {
+			fsl,pins = <
+				MX6SL_PAD_I2C2_SCL__I2C2_SCL	0x4001b8b1
+				MX6SL_PAD_I2C2_SDA__I2C2_SDA	0x4001b8b1
+			>;
+		};
+
+		/delete-unreferenced/ pinctrl_kpp: kppgrp {
+			fsl,pins = <
+				MX6SL_PAD_KEY_ROW0__KEY_ROW0    0x1b010
+				MX6SL_PAD_KEY_ROW1__KEY_ROW1    0x1b010
+				MX6SL_PAD_KEY_ROW2__KEY_ROW2    0x1b0b0
+				MX6SL_PAD_KEY_COL0__KEY_COL0    0x110b0
+				MX6SL_PAD_KEY_COL1__KEY_COL1    0x110b0
+				MX6SL_PAD_KEY_COL2__KEY_COL2    0x110b0
+			>;
+		};
+
+		/delete-unreferenced/ pinctrl_uart1: uart1grp {
+			fsl,pins = <
+				MX6SL_PAD_UART1_RXD__UART1_RX_DATA	0x1b0b1
+				MX6SL_PAD_UART1_TXD__UART1_TX_DATA	0x1b0b1
+			>;
+		};
+
+		/delete-unreferenced/ pinctrl_usbotg1: usbotg1grp {
+			fsl,pins = <
+				MX6SL_PAD_EPDC_PWRCOM__USB_OTG1_ID	0x17059
+			>;
+		};
+
+		/delete-unreferenced/ pinctrl_usdhc1: usdhc1grp {
+			fsl,pins = <
+				MX6SL_PAD_SD1_CMD__SD1_CMD		0x17059
+				MX6SL_PAD_SD1_CLK__SD1_CLK		0x10059
+				MX6SL_PAD_SD1_DAT0__SD1_DATA0		0x17059
+				MX6SL_PAD_SD1_DAT1__SD1_DATA1		0x17059
+				MX6SL_PAD_SD1_DAT2__SD1_DATA2		0x17059
+				MX6SL_PAD_SD1_DAT3__SD1_DATA3		0x17059
+				MX6SL_PAD_SD1_DAT4__SD1_DATA4		0x17059
+				MX6SL_PAD_SD1_DAT5__SD1_DATA5		0x17059
+				MX6SL_PAD_SD1_DAT6__SD1_DATA6		0x17059
+				MX6SL_PAD_SD1_DAT7__SD1_DATA7		0x17059
+			>;
+		};
+
+		/delete-unreferenced/ pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+			fsl,pins = <
+				MX6SL_PAD_SD1_CMD__SD1_CMD		0x170b9
+				MX6SL_PAD_SD1_CLK__SD1_CLK		0x100b9
+				MX6SL_PAD_SD1_DAT0__SD1_DATA0		0x170b9
+				MX6SL_PAD_SD1_DAT1__SD1_DATA1		0x170b9
+				MX6SL_PAD_SD1_DAT2__SD1_DATA2		0x170b9
+				MX6SL_PAD_SD1_DAT3__SD1_DATA3		0x170b9
+				MX6SL_PAD_SD1_DAT4__SD1_DATA4		0x170b9
+				MX6SL_PAD_SD1_DAT5__SD1_DATA5		0x170b9
+				MX6SL_PAD_SD1_DAT6__SD1_DATA6		0x170b9
+				MX6SL_PAD_SD1_DAT7__SD1_DATA7		0x170b9
+			>;
+		};
+
+		/delete-unreferenced/ pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+			fsl,pins = <
+				MX6SL_PAD_SD1_CMD__SD1_CMD		0x170f9
+				MX6SL_PAD_SD1_CLK__SD1_CLK		0x100f9
+				MX6SL_PAD_SD1_DAT0__SD1_DATA0		0x170f9
+				MX6SL_PAD_SD1_DAT1__SD1_DATA1		0x170f9
+				MX6SL_PAD_SD1_DAT2__SD1_DATA2		0x170f9
+				MX6SL_PAD_SD1_DAT3__SD1_DATA3		0x170f9
+				MX6SL_PAD_SD1_DAT4__SD1_DATA4		0x170f9
+				MX6SL_PAD_SD1_DAT5__SD1_DATA5		0x170f9
+				MX6SL_PAD_SD1_DAT6__SD1_DATA6		0x170f9
+				MX6SL_PAD_SD1_DAT7__SD1_DATA7		0x170f9
+			>;
+		};
+
+		/delete-unreferenced/ pinctrl_usdhc2: usdhc2grp {
+			fsl,pins = <
+				MX6SL_PAD_SD2_CMD__SD2_CMD		0x17059
+				MX6SL_PAD_SD2_CLK__SD2_CLK		0x10059
+				MX6SL_PAD_SD2_DAT0__SD2_DATA0		0x17059
+				MX6SL_PAD_SD2_DAT1__SD2_DATA1		0x17059
+				MX6SL_PAD_SD2_DAT2__SD2_DATA2		0x17059
+				MX6SL_PAD_SD2_DAT3__SD2_DATA3		0x17059
+			>;
+		};
+
+		/delete-unreferenced/ pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
+			fsl,pins = <
+				MX6SL_PAD_SD2_CMD__SD2_CMD		0x170b9
+				MX6SL_PAD_SD2_CLK__SD2_CLK		0x100b9
+				MX6SL_PAD_SD2_DAT0__SD2_DATA0		0x170b9
+				MX6SL_PAD_SD2_DAT1__SD2_DATA1		0x170b9
+				MX6SL_PAD_SD2_DAT2__SD2_DATA2		0x170b9
+				MX6SL_PAD_SD2_DAT3__SD2_DATA3		0x170b9
+			>;
+		};
+
+		/delete-unreferenced/ pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
+			fsl,pins = <
+				MX6SL_PAD_SD2_CMD__SD2_CMD		0x170f9
+				MX6SL_PAD_SD2_CLK__SD2_CLK		0x100f9
+				MX6SL_PAD_SD2_DAT0__SD2_DATA0		0x170f9
+				MX6SL_PAD_SD2_DAT1__SD2_DATA1		0x170f9
+				MX6SL_PAD_SD2_DAT2__SD2_DATA2		0x170f9
+				MX6SL_PAD_SD2_DAT3__SD2_DATA3		0x170f9
+			>;
+		};
+
+		/delete-unreferenced/ pinctrl_usdhc3: usdhc3grp {
+			fsl,pins = <
+				MX6SL_PAD_SD3_CMD__SD3_CMD		0x17059
+				MX6SL_PAD_SD3_CLK__SD3_CLK		0x10059
+				MX6SL_PAD_SD3_DAT0__SD3_DATA0		0x17059
+				MX6SL_PAD_SD3_DAT1__SD3_DATA1		0x17059
+				MX6SL_PAD_SD3_DAT2__SD3_DATA2		0x17059
+				MX6SL_PAD_SD3_DAT3__SD3_DATA3		0x17059
+			>;
+		};
+
+		/delete-unreferenced/ pinctrl_usdhc3_100mhz: usdhc3grp100mhz {
+			fsl,pins = <
+				MX6SL_PAD_SD3_CMD__SD3_CMD		0x170b9
+				MX6SL_PAD_SD3_CLK__SD3_CLK		0x100b9
+				MX6SL_PAD_SD3_DAT0__SD3_DATA0		0x170b9
+				MX6SL_PAD_SD3_DAT1__SD3_DATA1		0x170b9
+				MX6SL_PAD_SD3_DAT2__SD3_DATA2		0x170b9
+				MX6SL_PAD_SD3_DAT3__SD3_DATA3		0x170b9
+			>;
+		};
+
+		/delete-unreferenced/ pinctrl_usdhc3_200mhz: usdhc3grp200mhz {
+			fsl,pins = <
+				MX6SL_PAD_SD3_CMD__SD3_CMD		0x170f9
+				MX6SL_PAD_SD3_CLK__SD3_CLK		0x100f9
+				MX6SL_PAD_SD3_DAT0__SD3_DATA0		0x170f9
+				MX6SL_PAD_SD3_DAT1__SD3_DATA1		0x170f9
+				MX6SL_PAD_SD3_DAT2__SD3_DATA2		0x170f9
+				MX6SL_PAD_SD3_DAT3__SD3_DATA3		0x170f9
+			>;
+		};
+	};
+};
-- 
1.8.5.3
