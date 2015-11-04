From: marex@denx.de (Marek Vasut)
Date: Wed,  4 Nov 2015 23:14:22 +0100
Subject: [PATCH 1/3] ARM: at91/dt: sama5d4: Fix mmc0 pinmux comments
Message-ID: <1446675264-5514-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Synchronise the comments in mmc0 pinmux node with HSMCI0 pinmux
description in the Atmel SAMA5D4 datasheet from 24-Aug-15 page
1119, section 37.6.1, Table 37-3 .

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Josh Wu <josh.wu@atmel.com>
Reported-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/sama5d4.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 8d1de29..48ca530 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -1640,15 +1640,15 @@
 					pinctrl_mmc0_clk_cmd_dat0: mmc0_clk_cmd_dat0 {
 						atmel,pins =
 							<AT91_PIOC 4 AT91_PERIPH_B AT91_PINCTRL_NONE	/* MCI0_CK, conflict with PCK1(ISI_MCK) */
-							 AT91_PIOC 5 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* MCI0_CDB, conflict with NAND_D0 */
-							 AT91_PIOC 6 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* MCI0_DB0, conflict with NAND_D1 */
+							 AT91_PIOC 5 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* MCI0_CDA, conflict with NAND_D0 */
+							 AT91_PIOC 6 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* MCI0_DA0, conflict with NAND_D1 */
 							>;
 					};
 					pinctrl_mmc0_dat1_3: mmc0_dat1_3 {
 						atmel,pins =
-							<AT91_PIOC 7 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* MCI0_DB1, conflict with NAND_D2 */
-							 AT91_PIOC 8 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* MCI0_DB2, conflict with NAND_D3 */
-							 AT91_PIOC 9 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* MCI0_DB3, conflict with NAND_D4 */
+							<AT91_PIOC 7 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* MCI0_DA1, conflict with NAND_D2 */
+							 AT91_PIOC 8 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* MCI0_DA2, conflict with NAND_D3 */
+							 AT91_PIOC 9 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* MCI0_DA3, conflict with NAND_D4 */
 							>;
 					};
 				};
-- 
2.1.4
