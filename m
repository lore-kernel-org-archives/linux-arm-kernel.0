From: stigge@antcom.de (Roland Stigge)
Date: Thu, 25 Oct 2012 13:26:39 +0200
Subject: [PATCH 1/2] ARM: mach-imx: imx53.dtsi: pinctl update
Message-ID: <1351164400-27940-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch supplements pinctl support on i.MX53.

Signed-off-by: Roland Stigge <stigge@antcom.de>
---
 arch/arm/boot/dts/imx53.dtsi |   46 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

--- linux-2.6.orig/arch/arm/boot/dts/imx53.dtsi
+++ linux-2.6/arch/arm/boot/dts/imx53.dtsi
@@ -316,6 +316,24 @@
 					};
 				};
 
+				can1 {
+					pinctrl_can1_1: can1grp-1 {
+						fsl,pins = <
+							847 0x80000000  /* MX53_PAD_PATA_INTRQ__CAN1_TXCAN */
+							853 0x80000000  /* MX53_PAD_PATA_DIOR__CAN1_RXCAN */
+						>;
+					};
+				};
+
+				can2 {
+					pinctrl_can2_1: can2grp-1 {
+						fsl,pins = <
+							67  0x80000000  /* MX53_PAD_KEY_COL4__CAN2_TXCAN */
+							74  0x80000000  /* MX53_PAD_KEY_ROW4__CAN2_RXCAN */
+						>;
+					};
+				};
+
 				i2c1 {
 					pinctrl_i2c1_1: i2c1grp-1 {
 						fsl,pins = <
@@ -334,6 +352,15 @@
 					};
 				};
 
+				i2c3 {
+					pinctrl_i2c3_1: i2c3grp-1 {
+						fsl,pins = <
+							1102 0xc0000000	/* MX53_PAD_GPIO_6__I2C3_SDA */
+							1130 0xc0000000	/* MX53_PAD_GPIO_5__I2C3_SCL */
+						>;
+					};
+				};
+
 				uart1 {
 					pinctrl_uart1_1: uart1grp-1 {
 						fsl,pins = <
@@ -369,6 +396,25 @@
 						>;
 					};
 				};
+
+				uart4 {
+					pinctrl_uart4_1: uart4grp-1 {
+						fsl,pins = <
+							11 0x1c5	/* MX53_PAD_KEY_COL0__UART4_TXD_MUX */
+							18 0x1c5	/* MX53_PAD_KEY_ROW0__UART4_RXD_MUX */
+						>;
+					};
+				};
+
+				uart5 {
+					pinctrl_uart5_1: uart5grp-1 {
+						fsl,pins = <
+							24 0x1c5	/* MX53_PAD_KEY_COL1__UART5_TXD_MUX */
+							31 0x1c5	/* MX53_PAD_KEY_ROW1__UART5_RXD_MUX */
+						>;
+					};
+				};
+
 			};
 
 			uart1: serial at 53fbc000 {
