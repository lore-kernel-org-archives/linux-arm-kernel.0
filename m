From: marex@denx.de (Marek Vasut)
Date: Mon,  2 Nov 2015 00:26:16 +0100
Subject: [PATCH] ARM: at91/dt: sama5d4: Add pinmux for 8-bit MMC0 bus
Message-ID: <1446420376-5419-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinmux for the 4 remaining signals used in 8-bit MMC 0
bus configuration.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Josh Wu <josh.wu@atmel.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/sama5d4.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 8d1de29..f9f6108 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -1651,6 +1651,14 @@
 							 AT91_PIOC 9 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* MCI0_DB3, conflict with NAND_D4 */
 							>;
 					};
+					pinctrl_mmc0_dat4_7: mmc0_dat4_7 {
+						atmel,pins =
+							<AT91_PIOC 10 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* MCI0_DB1, conflict with NAND_D5 */
+							 AT91_PIOC 11 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* MCI0_DB2, conflict with NAND_D6 */
+							 AT91_PIOC 12 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* MCI0_DB3, conflict with NAND_D7 */
+							 AT91_PIOC 13 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* MCI0_DB3, conflict with NAND_D8 */
+							>;
+					};
 				};
 
 				mmc1 {
-- 
2.1.4
