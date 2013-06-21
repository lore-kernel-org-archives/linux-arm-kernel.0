From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 21 Jun 2013 15:36:11 +0200
Subject: [RFC PATCH] ARM i.MX53: Fix UART pad configuration
Message-ID: <1371821771-23450-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current default pad configuration for UART RX and TX pads sets a 360k
pull-down and writes 1 to a reserved bit (1 << 0). It doesn't seem right to
me that in idle state, the UART has to keep the signal high against a
pull-down resistor.

This patch instead sets a 100k pull-up, which incidentally corresponds to the
register reset value for all but one (MX53_PAD_KEY_ROW0__UART4_RXD_MUX) pad,
and removes the write to the reserved bit.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
Or is there a valid reason to set a pull-down on those pads and to write 1
to the reserved bit?
---
 arch/arm/boot/dts/imx53.dtsi | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 5d77f00..fee0c0e 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -523,15 +523,15 @@
 				uart1 {
 					pinctrl_uart1_1: uart1grp-1 {
 						fsl,pins = <
-							MX53_PAD_CSI0_DAT10__UART1_TXD_MUX 0x1c5
-							MX53_PAD_CSI0_DAT11__UART1_RXD_MUX 0x1c5
+							MX53_PAD_CSI0_DAT10__UART1_TXD_MUX 0x1e4
+							MX53_PAD_CSI0_DAT11__UART1_RXD_MUX 0x1e4
 						>;
 					};
 
 					pinctrl_uart1_2: uart1grp-2 {
 						fsl,pins = <
-							MX53_PAD_PATA_DIOW__UART1_TXD_MUX  0x1c5
-							MX53_PAD_PATA_DMACK__UART1_RXD_MUX 0x1c5
+							MX53_PAD_PATA_DIOW__UART1_TXD_MUX  0x1e4
+							MX53_PAD_PATA_DMACK__UART1_RXD_MUX 0x1e4
 						>;
 					};
 				};
@@ -539,8 +539,8 @@
 				uart2 {
 					pinctrl_uart2_1: uart2grp-1 {
 						fsl,pins = <
-							MX53_PAD_PATA_BUFFER_EN__UART2_RXD_MUX 0x1c5
-							MX53_PAD_PATA_DMARQ__UART2_TXD_MUX     0x1c5
+							MX53_PAD_PATA_BUFFER_EN__UART2_RXD_MUX 0x1e4
+							MX53_PAD_PATA_DMARQ__UART2_TXD_MUX     0x1e4
 						>;
 					};
 				};
@@ -548,17 +548,17 @@
 				uart3 {
 					pinctrl_uart3_1: uart3grp-1 {
 						fsl,pins = <
-							MX53_PAD_PATA_CS_0__UART3_TXD_MUX 0x1c5
-							MX53_PAD_PATA_CS_1__UART3_RXD_MUX 0x1c5
-							MX53_PAD_PATA_DA_1__UART3_CTS	  0x1c5
-							MX53_PAD_PATA_DA_2__UART3_RTS	  0x1c5
+							MX53_PAD_PATA_CS_0__UART3_TXD_MUX 0x1e4
+							MX53_PAD_PATA_CS_1__UART3_RXD_MUX 0x1e4
+							MX53_PAD_PATA_DA_1__UART3_CTS	  0x1e4
+							MX53_PAD_PATA_DA_2__UART3_RTS	  0x1e4
 						>;
 					};
 
 					pinctrl_uart3_2: uart3grp-2 {
 						fsl,pins = <
-							MX53_PAD_PATA_CS_0__UART3_TXD_MUX 0x1c5
-							MX53_PAD_PATA_CS_1__UART3_RXD_MUX 0x1c5
+							MX53_PAD_PATA_CS_0__UART3_TXD_MUX 0x1e4
+							MX53_PAD_PATA_CS_1__UART3_RXD_MUX 0x1e4
 						>;
 					};
 
@@ -567,8 +567,8 @@
 				uart4 {
 					pinctrl_uart4_1: uart4grp-1 {
 						fsl,pins = <
-							MX53_PAD_KEY_COL0__UART4_TXD_MUX 0x1c5
-							MX53_PAD_KEY_ROW0__UART4_RXD_MUX 0x1c5
+							MX53_PAD_KEY_COL0__UART4_TXD_MUX 0x1e4
+							MX53_PAD_KEY_ROW0__UART4_RXD_MUX 0x1e4
 						>;
 					};
 				};
@@ -576,8 +576,8 @@
 				uart5 {
 					pinctrl_uart5_1: uart5grp-1 {
 						fsl,pins = <
-							MX53_PAD_KEY_COL1__UART5_TXD_MUX 0x1c5
-							MX53_PAD_KEY_ROW1__UART5_RXD_MUX 0x1c5
+							MX53_PAD_KEY_COL1__UART5_TXD_MUX 0x1e4
+							MX53_PAD_KEY_ROW1__UART5_RXD_MUX 0x1e4
 						>;
 					};
 				};
-- 
1.8.3.1
