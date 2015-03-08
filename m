From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Sun,  8 Mar 2015 17:25:59 +0100
Subject: [PATCH v2 1/2] ARM: dts: imx6: factor out pinmux for edm1 module
Message-ID: <1425831960-10259-1-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thw Wandboard is using the EDM1-CF-IMX6 module which is
defined under the edm standard.

http://www.edm-standard.org/

As this module is used on more boards this patch moves the default
pinmux settings into the special file imx6qdl-edm1.dtsi.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
- fixed the alphabetical order of the nodes
- moved MX6QDL_PAD_GPIO_16__ENET_REF_CLK to the board hogpins

 arch/arm/boot/dts/imx6qdl-edm1.dtsi            | 230 +++++++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi |   1 +
 arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi |   1 +
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi       |  99 +----------
 4 files changed, 234 insertions(+), 97 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6qdl-edm1.dtsi

diff --git a/arch/arm/boot/dts/imx6qdl-edm1.dtsi b/arch/arm/boot/dts/imx6qdl-edm1.dtsi
new file mode 100644
index 0000000..6fff536
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qdl-edm1.dtsi
@@ -0,0 +1,230 @@
+&iomuxc {
+	pinctrl-names = "default";
+
+	imx6qdl-edm1 {
+
+		pinctrl_audmux: audmuxgrp {
+			fsl,pins = <
+				MX6QDL_PAD_CSI0_DAT7__AUD3_RXD		0x130b0
+				MX6QDL_PAD_CSI0_DAT4__AUD3_TXC		0x130b0
+				MX6QDL_PAD_CSI0_DAT5__AUD3_TXD		0x110b0
+				MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS		0x130b0
+				MX6QDL_PAD_GPIO_0__CCM_CLKO1		0x130b0
+			>;
+		};
+
+		pinctrl_disp0_1: disp0grp-1 {
+			fsl,pins = <
+				MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK	0x10
+				MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15		0x10
+				MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02		0x10
+				MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03		0x10
+				MX6QDL_PAD_DI0_PIN4__IPU1_DI0_PIN04		0x10
+				MX6QDL_PAD_DISP0_DAT0__IPU1_DISP0_DATA00	0x10
+				MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01	0x10
+				MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02	0x10
+				MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03	0x10
+				MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04	0x10
+				MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05	0x10
+				MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06	0x10
+				MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07	0x10
+				MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08	0x10
+				MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09	0x10
+				MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10	0x10
+				MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11	0x10
+				MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12	0x10
+				MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13	0x10
+				MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14	0x10
+				MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15	0x10
+				MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16	0x10
+				MX6QDL_PAD_DISP0_DAT17__IPU1_DISP0_DATA17	0x10
+				MX6QDL_PAD_DISP0_DAT18__IPU1_DISP0_DATA18	0x10
+				MX6QDL_PAD_DISP0_DAT19__IPU1_DISP0_DATA19	0x10
+				MX6QDL_PAD_DISP0_DAT20__IPU1_DISP0_DATA20	0x10
+				MX6QDL_PAD_DISP0_DAT21__IPU1_DISP0_DATA21	0x10
+				MX6QDL_PAD_DISP0_DAT22__IPU1_DISP0_DATA22	0x10
+				MX6QDL_PAD_DISP0_DAT23__IPU1_DISP0_DATA23	0x10
+				MX6QDL_PAD_SD4_DAT2__GPIO2_IO10			0x10
+				MX6QDL_PAD_SD4_DAT3__GPIO2_IO11			0x10
+			>;
+		};
+
+		pinctrl_enet: enetgrp {
+			fsl,pins = <
+				MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b0b0
+				MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
+				MX6QDL_PAD_RGMII_TXC__RGMII_TXC		0x1b0b0
+				MX6QDL_PAD_RGMII_TD0__RGMII_TD0		0x1b0b0
+				MX6QDL_PAD_RGMII_TD1__RGMII_TD1		0x1b0b0
+				MX6QDL_PAD_RGMII_TD2__RGMII_TD2		0x1b0b0
+				MX6QDL_PAD_RGMII_TD3__RGMII_TD3		0x1b0b0
+				MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL	0x1b0b0
+				MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK	0x1b0b0
+				MX6QDL_PAD_RGMII_RXC__RGMII_RXC		0x1b0b0
+				MX6QDL_PAD_RGMII_RD0__RGMII_RD0		0x1b0b0
+				MX6QDL_PAD_RGMII_RD1__RGMII_RD1		0x1b0b0
+				MX6QDL_PAD_RGMII_RD2__RGMII_RD2		0x1b0b0
+				MX6QDL_PAD_RGMII_RD3__RGMII_RD3		0x1b0b0
+				MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x1b0b0
+				MX6QDL_PAD_ENET_TX_EN__GPIO1_IO28	0x180b0
+				MX6QDL_PAD_EIM_D29__GPIO3_IO29		0x000b1
+				MX6QDL_PAD_GPIO_6__ENET_IRQ		0x000b1
+			>;
+		};
+
+		pinctrl_flexcan1: flexcan1grp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_18__GPIO7_IO13		0x1b0b0
+				MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX	0x1b0b0
+				MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX	0x1b0b0
+			>;
+		};
+
+		pinctrl_flexcan2: flexcan2grp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_7__GPIO1_IO07		0x1b0b0
+				MX6QDL_PAD_KEY_COL4__FLEXCAN2_TX	0x1b0b0
+				MX6QDL_PAD_KEY_ROW4__FLEXCAN2_RX	0x1b0b0
+			>;
+		};
+
+		pinctrl_gpmi_nand: gpminandgrp {
+			fsl,pins = <
+				MX6QDL_PAD_NANDF_CLE__NAND_CLE		0x0b0b1
+				MX6QDL_PAD_NANDF_ALE__NAND_ALE		0x0b0b1
+				MX6QDL_PAD_NANDF_WP_B__NAND_WP_B	0x0b0b1
+				MX6QDL_PAD_NANDF_RB0__NAND_READY_B	0x0b000
+				MX6QDL_PAD_NANDF_CS0__NAND_CE0_B	0x0b0b1
+				MX6QDL_PAD_SD4_CMD__NAND_RE_B		0x0b0b1
+				MX6QDL_PAD_SD4_CLK__NAND_WE_B		0x0b0b1
+				MX6QDL_PAD_NANDF_D0__NAND_DATA00	0x0b0b1
+				MX6QDL_PAD_NANDF_D1__NAND_DATA01	0x0b0b1
+				MX6QDL_PAD_NANDF_D2__NAND_DATA02	0x0b0b1
+				MX6QDL_PAD_NANDF_D3__NAND_DATA03	0x0b0b1
+				MX6QDL_PAD_NANDF_D4__NAND_DATA04	0x0b0b1
+				MX6QDL_PAD_NANDF_D5__NAND_DATA05	0x0b0b1
+				MX6QDL_PAD_NANDF_D6__NAND_DATA06	0x0b0b1
+				MX6QDL_PAD_NANDF_D7__NAND_DATA07	0x0b0b1
+			>;
+		};
+
+		pinctrl_i2c1: i2c1grp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D21__I2C1_SCL		0x4001b8b1
+				MX6QDL_PAD_EIM_D28__I2C1_SDA		0x4001b8b1
+			>;
+		};
+
+
+		pinctrl_i2c2: i2c2grp {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_COL3__I2C2_SCL		0x4001b8b1
+				MX6QDL_PAD_KEY_ROW3__I2C2_SDA		0x4001b8b1
+			>;
+		};
+
+
+		pinctrl_i2c3: i2c3grp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_3__I2C3_SCL		0x4001b8b1
+				MX6QDL_PAD_GPIO_16__I2C3_SDA		0x4001b8b1
+			>;
+		};
+
+		pinctrl_pwm3: pwm3grp {
+			fsl,pins = <
+				MX6QDL_PAD_SD4_DAT1__PWM3_OUT		0x80000000
+			>;
+		};
+
+		pinctrl_spdif: spdifgrp {
+			fsl,pins = <
+				MX6QDL_PAD_ENET_RXD0__SPDIF_OUT		0x1b0b0
+			>;
+		};
+
+		pinctrl_uart1: uart1grp {
+			fsl,pins = <
+				MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA	0x1b0b1
+				MX6QDL_PAD_CSI0_DAT11__UART1_RX_DATA	0x1b0b1
+			>;
+		};
+
+		pinctrl_uart1_rtscts: uart1_rtsctsgrp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D19__UART1_CTS_B		0x1b0b1
+				MX6QDL_PAD_EIM_D20__UART1_RTS_B		0x1b0b1
+			>;
+		};
+
+		pinctrl_uart2: uart2grp {
+			fsl,pins = <
+				MX6QDL_PAD_SD4_DAT7__UART2_TX_DATA	0x1b0b1
+				MX6QDL_PAD_SD4_DAT4__UART2_RX_DATA	0x1b0b1
+			>;
+		};
+
+
+		pinctrl_uart2_rtscts: uart2_rtsctsgrp {
+			fsl,pins = <
+				MX6QDL_PAD_SD4_DAT5__UART2_RTS_B	0x1b0b1
+				MX6QDL_PAD_SD4_DAT6__UART2_CTS_B	0x1b0b1
+			>;
+		};
+
+		pinctrl_usbotg: usbotggrp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_9__GPIO1_IO09		0x17059
+				MX6QDL_PAD_GPIO_1__USB_OTG_ID		0x17059
+				MX6QDL_PAD_EIM_D22__GPIO3_IO22		0x000b0
+			>;
+		};
+
+		pinctrl_usbh1: usbh1grp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_17__GPIO7_IO12		0x17059
+				MX6QDL_PAD_EIM_D30__GPIO3_IO30		0x1b0b0
+			>;
+		};
+
+		pinctrl_usdhc1: usdhc1grp {
+			fsl,pins = <
+				MX6QDL_PAD_SD1_CMD__SD1_CMD		0x17059
+				MX6QDL_PAD_SD1_CLK__SD1_CLK		0x10059
+				MX6QDL_PAD_SD1_DAT0__SD1_DATA0		0x17059
+				MX6QDL_PAD_SD1_DAT1__SD1_DATA1		0x17059
+				MX6QDL_PAD_SD1_DAT2__SD1_DATA2		0x17059
+				MX6QDL_PAD_SD1_DAT3__SD1_DATA3		0x17059
+				MX6QDL_PAD_GPIO_2__GPIO1_IO02		0x80000000
+			>;
+		};
+
+		pinctrl_usdhc2: usdhc2grp {
+			fsl,pins = <
+				MX6QDL_PAD_SD2_CMD__SD2_CMD		0x17059
+				MX6QDL_PAD_SD2_CLK__SD2_CLK		0x10059
+				MX6QDL_PAD_SD2_DAT0__SD2_DATA0		0x17059
+				MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x17059
+				MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x17059
+				MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x17059
+			>;
+		};
+
+		pinctrl_usdhc3: usdhc3grp {
+			fsl,pins = <
+				MX6QDL_PAD_SD3_CMD__SD3_CMD		0x17059
+				MX6QDL_PAD_SD3_CLK__SD3_CLK		0x10059
+				MX6QDL_PAD_SD3_DAT0__SD3_DATA0		0x17059
+				MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x17059
+				MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x17059
+				MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x17059
+				MX6QDL_PAD_SD3_DAT4__SD3_DATA4		0x17059
+				MX6QDL_PAD_SD3_DAT5__SD3_DATA5		0x17059
+				MX6QDL_PAD_SD3_DAT6__SD3_DATA6		0x17059
+				MX6QDL_PAD_SD3_DAT7__SD3_DATA7		0x17059
+				MX6QDL_PAD_EIM_DA9__GPIO3_IO09		0x80000000
+			>;
+		};
+	};
+};
+
diff --git a/arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi
index ef7fa62..39d4239 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi
@@ -19,6 +19,7 @@
 			fsl,pins = <
 				MX6QDL_PAD_GPIO_0__CCM_CLKO1		0x130b0		/* GPIO_0_CLKO */
 				MX6QDL_PAD_GPIO_2__GPIO1_IO02		0x80000000	/* uSDHC1 CD */
+				MX6QDL_PAD_GPIO_16__ENET_REF_CLK	0x4001b0a8	/* GPIO16 -> AR8035 25MHz */
 				MX6QDL_PAD_EIM_DA9__GPIO3_IO09		0x80000000	/* uSDHC3 CD */
 				MX6QDL_PAD_EIM_EB1__GPIO2_IO29		0x0f0b0		/* WL_REF_ON */
 				MX6QDL_PAD_EIM_A25__GPIO5_IO02		0x0f0b0		/* WL_RST_N */
diff --git a/arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi
index 8d893a7..eac30a6 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi
@@ -19,6 +19,7 @@
 			fsl,pins = <
 				MX6QDL_PAD_GPIO_0__CCM_CLKO1		0x130b0		/* GPIO_0_CLKO */
 				MX6QDL_PAD_GPIO_2__GPIO1_IO02		0x80000000	/* uSDHC1 CD */
+				MX6QDL_PAD_GPIO_16__ENET_REF_CLK	0x4001b0a8	/* GPIO16 -> AR8035 25MHz */
 				MX6QDL_PAD_EIM_DA9__GPIO3_IO09		0x80000000	/* uSDHC3 CD */
 				MX6QDL_PAD_CSI0_DAT14__GPIO6_IO00	0x0f0b0		/* WIFI_ON (reset, active low) */
 				MX6QDL_PAD_ENET_RXD1__GPIO1_IO26	0x000b0		/* WL_REG_ON (unused) */
diff --git a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
index 5fb0916..4cc9251 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
@@ -9,6 +9,8 @@
  *
  */
 
+#include "imx6qdl-edm1.dtsi"
+
 / {
 	regulators {
 		compatible = "simple-bus";
@@ -94,64 +96,6 @@
 
 	imx6qdl-wandboard {
 
-		pinctrl_audmux: audmuxgrp {
-			fsl,pins = <
-				MX6QDL_PAD_CSI0_DAT7__AUD3_RXD		0x130b0
-				MX6QDL_PAD_CSI0_DAT4__AUD3_TXC		0x130b0
-				MX6QDL_PAD_CSI0_DAT5__AUD3_TXD		0x110b0
-				MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS		0x130b0
-			>;
-		};
-
-		pinctrl_enet: enetgrp {
-			fsl,pins = <
-				MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b0b0
-				MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
-				MX6QDL_PAD_RGMII_TXC__RGMII_TXC		0x1b0b0
-				MX6QDL_PAD_RGMII_TD0__RGMII_TD0		0x1b0b0
-				MX6QDL_PAD_RGMII_TD1__RGMII_TD1		0x1b0b0
-				MX6QDL_PAD_RGMII_TD2__RGMII_TD2		0x1b0b0
-				MX6QDL_PAD_RGMII_TD3__RGMII_TD3		0x1b0b0
-				MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL	0x1b0b0
-				MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK	0x1b0b0
-				MX6QDL_PAD_RGMII_RXC__RGMII_RXC		0x1b0b0
-				MX6QDL_PAD_RGMII_RD0__RGMII_RD0		0x1b0b0
-				MX6QDL_PAD_RGMII_RD1__RGMII_RD1		0x1b0b0
-				MX6QDL_PAD_RGMII_RD2__RGMII_RD2		0x1b0b0
-				MX6QDL_PAD_RGMII_RD3__RGMII_RD3		0x1b0b0
-				MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x1b0b0
-				MX6QDL_PAD_GPIO_16__ENET_REF_CLK	0x4001b0a8
-				MX6QDL_PAD_GPIO_6__ENET_IRQ		0x000b1
-			>;
-		};
-
-		pinctrl_i2c1: i2c1grp {
-			fsl,pins = <
-				MX6QDL_PAD_EIM_D21__I2C1_SCL 		0x4001b8b1
-				MX6QDL_PAD_EIM_D28__I2C1_SDA 		0x4001b8b1
-			>;
-		};
-
-		pinctrl_i2c2: i2c2grp {
-			fsl,pins = <
-				MX6QDL_PAD_KEY_COL3__I2C2_SCL		0x4001b8b1
-				MX6QDL_PAD_KEY_ROW3__I2C2_SDA		0x4001b8b1
-			>;
-		};
-
-		pinctrl_spdif: spdifgrp {
-			fsl,pins = <
-				MX6QDL_PAD_ENET_RXD0__SPDIF_OUT		0x1b0b0
-			>;
-		};
-
-		pinctrl_uart1: uart1grp {
-			fsl,pins = <
-				MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA	0x1b0b1
-				MX6QDL_PAD_CSI0_DAT11__UART1_RX_DATA	0x1b0b1
-			>;
-		};
-
 		pinctrl_uart3: uart3grp {
 			fsl,pins = <
 				MX6QDL_PAD_EIM_D24__UART3_TX_DATA	0x1b0b1
@@ -160,45 +104,6 @@
 				MX6QDL_PAD_EIM_EB3__UART3_RTS_B		0x1b0b1
 			>;
 		};
-
-		pinctrl_usbotg: usbotggrp {
-			fsl,pins = <
-				MX6QDL_PAD_GPIO_1__USB_OTG_ID		0x17059
-			>;
-		};
-
-		pinctrl_usdhc1: usdhc1grp {
-			fsl,pins = <
-				MX6QDL_PAD_SD1_CMD__SD1_CMD		0x17059
-				MX6QDL_PAD_SD1_CLK__SD1_CLK		0x10059
-				MX6QDL_PAD_SD1_DAT0__SD1_DATA0		0x17059
-				MX6QDL_PAD_SD1_DAT1__SD1_DATA1		0x17059
-				MX6QDL_PAD_SD1_DAT2__SD1_DATA2		0x17059
-				MX6QDL_PAD_SD1_DAT3__SD1_DATA3		0x17059
-			>;
-		};
-
-		pinctrl_usdhc2: usdhc2grp {
-			fsl,pins = <
-				MX6QDL_PAD_SD2_CMD__SD2_CMD		0x17059
-				MX6QDL_PAD_SD2_CLK__SD2_CLK		0x10059
-				MX6QDL_PAD_SD2_DAT0__SD2_DATA0		0x17059
-				MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x17059
-				MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x17059
-				MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x17059
-			>;
-		};
-
-		pinctrl_usdhc3: usdhc3grp {
-			fsl,pins = <
-				MX6QDL_PAD_SD3_CMD__SD3_CMD		0x17059
-				MX6QDL_PAD_SD3_CLK__SD3_CLK		0x10059
-				MX6QDL_PAD_SD3_DAT0__SD3_DATA0		0x17059
-				MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x17059
-				MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x17059
-				MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x17059
-			>;
-		};
 	};
 };
 
-- 
2.1.4
