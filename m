From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  3 Apr 2013 11:05:02 +0900
Subject: [PATCH 24/28] ARM: shmobile: r8a73a4: Remove SCIF function GPIOs
In-Reply-To: <1364954706-14727-1-git-send-email-horms+renesas@verge.net.au>
References: <1364954706-14727-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364954706-14727-25-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove SCIF function GPIOs that have been deprecated by the pinctrl API.

Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/r8a73a4.h |   45 -------------------------
 1 file changed, 45 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a73a4.h b/arch/arm/mach-shmobile/include/mach/r8a73a4.h
index 2d4af4a..703387a 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a73a4.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a73a4.h
@@ -200,55 +200,45 @@ enum {
 
 	/* Port19 */
 	GPIO_FN_LCDD19,
-	GPIO_FN_SCIFB3_RTS_19,
 	GPIO_FN_DU0_DB3,
 
 	/* Port20 */
 	GPIO_FN_LCDD20,
-	GPIO_FN_SCIFB3_CTS_20,
 	GPIO_FN_DU0_DB4,
 
 	/* Port21 */
 	GPIO_FN_LCDD21,
-	GPIO_FN_SCIFB3_TXD_21,
 	GPIO_FN_DU0_DB5,
 
 	/* Port22 */
 	GPIO_FN_LCDD22,
-	GPIO_FN_SCIFB3_RXD_22,
 	GPIO_FN_DU0_DB6,
 
 	/* Port23 */
 	GPIO_FN_LCDD23,
-	GPIO_FN_SCIFB3_SCK_23,
 	GPIO_FN_DU0_DB7,
 
 	/* Port24 */
 	GPIO_FN_LCDHSYN,
 	GPIO_FN_LCDCS,
-	GPIO_FN_SCIFB1_RTS_24,
 	GPIO_FN_DU0_EXHSYNC_N_CSYNC_N_HSYNC_N,
 
 	/* Port25 */
 	GPIO_FN_LCDVSYN,
-	GPIO_FN_SCIFB1_CTS_25,
 	GPIO_FN_DU0_EXVSYNC_N_VSYNC_N_CSYNC_N,
 
 	/* Port26 */
 	GPIO_FN_LCDDCK,
 	GPIO_FN_LCDWR,
-	GPIO_FN_SCIFB1_TXD_26,
 	GPIO_FN_DU0_DOTCLKIN,
 
 	/* Port27 */
 	GPIO_FN_LCDDISP,
 	GPIO_FN_LCDRS,
-	GPIO_FN_SCIFB1_RXD_27,
 	GPIO_FN_DU0_DOTCLKOUT,
 
 	/* Port28 */
 	GPIO_FN_LCDRD_N,
-	GPIO_FN_SCIFB1_SCK_28,
 	GPIO_FN_DU0_DOTCLKOUTB,
 
 	/* Port29 */
@@ -262,48 +252,36 @@ enum {
 	GPIO_FN_DU0_ODDF_N_CLAMP,
 
 	/* Port32 */
-	GPIO_FN_SCIFA0_RTS,
 	GPIO_FN_SIM0_DET,
 	GPIO_FN_CSCIF0_RTS,
 
 	/* Port33 */
-	GPIO_FN_SCIFA0_CTS,
 	GPIO_FN_SIM1_DET,
 	GPIO_FN_CSCIF0_CTS,
 
 	/* Port34 */
-	GPIO_FN_SCIFA0_SCK,
 	GPIO_FN_SIM0_PWRON,
 	GPIO_FN_CSCIF0_SCK,
 
 	/* Port35 */
-	GPIO_FN_SCIFA1_RTS,
 	GPIO_FN_CSCIF1_RTS,
 
 	/* Port36 */
-	GPIO_FN_SCIFA1_CTS,
 	GPIO_FN_CSCIF1_CTS,
 
 	/* Port37 */
-	GPIO_FN_SCIFA1_SCK,
 	GPIO_FN_CSCIF1_SCK,
 
 	/* Port38 */
-	GPIO_FN_SCIFB0_RTS,
 	GPIO_FN_TPU0TO1,
-	GPIO_FN_SCIFB3_RTS_38,
 	GPIO_FN_CHSCIF0_HRTS,
 
 	/* Port39 */
-	GPIO_FN_SCIFB0_CTS,
 	GPIO_FN_TPU0TO2,
-	GPIO_FN_SCIFB3_CTS_39,
 	GPIO_FN_CHSCIF0_HCTS,
 
 	/* Port40 */
-	GPIO_FN_SCIFB0_SCK,
 	GPIO_FN_TPU0TO3,
-	GPIO_FN_SCIFB3_SCK_40,
 	GPIO_FN_CHSCIF0_HSCK,
 
 	/* Port64 */
@@ -314,52 +292,44 @@ enum {
 
 	/* Port66 */
 	GPIO_FN_HSI_RX_WAKE,
-	GPIO_FN_SCIFB2_CTS_66,
 	GPIO_FN_MSIOF3_SYNC,
 	GPIO_FN_GenIO4,
 	GPIO_FN_IRQ40,
 
 	/* Port67 */
 	GPIO_FN_HSI_RX_READY,
-	GPIO_FN_SCIFB1_TXD_67,
 	GPIO_FN_GIO_OUT3_67,
 	GPIO_FN_CHSCIF1_HTX,
 
 	/* Port68 */
 	GPIO_FN_HSI_RX_FLAG,
-	GPIO_FN_SCIFB2_TXD_68,
 	GPIO_FN_MSIOF3_TXD,
 	GPIO_FN_GIO_OUT4_68,
 
 	/* Port69 */
 	GPIO_FN_HSI_RX_DATA,
-	GPIO_FN_SCIFB2_RXD_69,
 	GPIO_FN_MSIOF3_RXD,
 	GPIO_FN_GIO_OUT5_69,
 
 	/* Port70 */
 	GPIO_FN_HSI_TX_FLAG,
-	GPIO_FN_SCIFB1_RTS_70,
 	GPIO_FN_GIO_OUT1_70,
 	GPIO_FN_HSIC_TSTCLK0,
 	GPIO_FN_CHSCIF1_HRTS,
 
 	/* Port71 */
 	GPIO_FN_HSI_TX_DATA,
-	GPIO_FN_SCIFB1_CTS_71,
 	GPIO_FN_GIO_OUT2_71,
 	GPIO_FN_HSIC_TSTCLK1,
 	GPIO_FN_CHSCIF1_HCTS,
 
 	/* Port72 */
 	GPIO_FN_HSI_TX_WAKE,
-	GPIO_FN_SCIFB1_RXD_72,
 	GPIO_FN_GenIO8,
 	GPIO_FN_CHSCIF1_HRX,
 
 	/* Port73 */
 	GPIO_FN_HSI_TX_READY,
-	GPIO_FN_SCIFB2_RTS_73,
 	GPIO_FN_MSIOF3_SCK,
 	GPIO_FN_GIO_OUT0_73,
 
@@ -438,36 +408,28 @@ enum {
 	GPIO_FN_IRQ49,
 
 	/* Port116 */
-	GPIO_FN_SCIFA0_TXD,
 	GPIO_FN_CSCIF0_TX,
 
 	/* Port117 */
-	GPIO_FN_SCIFA0_RXD,
 	GPIO_FN_CSCIF0_RX,
 
 	/* Port118 */
-	GPIO_FN_SCIFA1_TXD,
 	GPIO_FN_CSCIF1_TX,
 
 	/* Port119 */
-	GPIO_FN_SCIFA1_RXD,
 	GPIO_FN_CSCIF1_RX,
 
 	/* Port120 */
 	GPIO_FN_SF_PORT_1_120,
-	GPIO_FN_SCIFB3_RXD_120,
 	GPIO_FN_DU0_CDE,
 
 	/* Port121 */
 	GPIO_FN_SF_PORT_0_121,
-	GPIO_FN_SCIFB3_TXD_121,
 
 	/* Port122 */
-	GPIO_FN_SCIFB0_TXD,
 	GPIO_FN_CHSCIF0_HTX,
 
 	/* Port123 */
-	GPIO_FN_SCIFB0_RXD,
 	GPIO_FN_CHSCIF0_HRX,
 
 	/* Port124 */
@@ -761,11 +723,9 @@ enum {
 	GPIO_FN_MSIOF0_TXD,
 
 	/* Port261 */
-	GPIO_FN_SCIFB1_SCK_261,
 	GPIO_FN_CHSCIF1_HSCK,
 
 	/* Port262 */
-	GPIO_FN_SCIFB2_SCK_262,
 
 	/* Port263 - Port266 FN1 */
 	GPIO_FN_MSIOF1_SS2,
@@ -849,7 +809,6 @@ enum {
 	/* Port295 */
 	GPIO_FN_SDHID2_0,
 	GPIO_FN_MSIOF4_TXD,
-	GPIO_FN_SCIFB2_TXD_295,
 	GPIO_FN_MSIOF6_TXD,
 
 	/* Port296 */
@@ -870,10 +829,6 @@ enum {
 	GPIO_FN_MSIOF4_SS1,
 
 	/* Port297 - Port300 FN3 */
-	GPIO_FN_SCIFB2_RXD_297,
-	GPIO_FN_SCIFB2_CTS_298,
-	GPIO_FN_SCIFB2_SCK_299,
-	GPIO_FN_SCIFB2_RTS_300,
 
 	/* Port297 - Port300 FN4 */
 	GPIO_FN_MSIOF6_RXD,
-- 
1.7.10.4
