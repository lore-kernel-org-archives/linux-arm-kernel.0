From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Apr 2013 14:09:33 +0900
Subject: [PATCH 25/28] ARM: shmobile: r8a73a4: Remove IRQC function GPIOs
In-Reply-To: <1364879376-10020-1-git-send-email-horms+renesas@verge.net.au>
References: <1364879376-10020-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364879376-10020-26-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove IRQ pin function GPIOs that have been deprecated by the pinctrl
API.

Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/r8a73a4.h |   58 -------------------------
 1 file changed, 58 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a73a4.h b/arch/arm/mach-shmobile/include/mach/r8a73a4.h
index 703387a..9162e86 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a73a4.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a73a4.h
@@ -89,99 +89,83 @@ enum {
 	GPIO_FN_LCDD0 = 330,
 	GPIO_FN_PDM2_CLK_0,
 	GPIO_FN_DU0_DR0,
-	GPIO_FN_IRQ0,
 
 	/* Port1 */
 	GPIO_FN_LCDD1,
 	GPIO_FN_PDM2_DATA_1,
 	GPIO_FN_DU0_DR19,
-	GPIO_FN_IRQ1,
 
 	/* Port2 */
 	GPIO_FN_LCDD2,
 	GPIO_FN_PDM3_CLK_2,
 	GPIO_FN_DU0_DR2,
-	GPIO_FN_IRQ2,
 
 	/* Port3 */
 	GPIO_FN_LCDD3,
 	GPIO_FN_PDM3_DATA_3,
 	GPIO_FN_DU0_DR3,
-	GPIO_FN_IRQ3,
 
 	/* Port4 */
 	GPIO_FN_LCDD4,
 	GPIO_FN_PDM4_CLK_4,
 	GPIO_FN_DU0_DR4,
-	GPIO_FN_IRQ4,
 
 	/* Port5 */
 	GPIO_FN_LCDD5,
 	GPIO_FN_PDM4_DATA_5,
 	GPIO_FN_DU0_DR5,
-	GPIO_FN_IRQ5,
 
 	/* Port6 */
 	GPIO_FN_LCDD6,
 	GPIO_FN_PDM0_OUTCLK_6,
 	GPIO_FN_DU0_DR6,
-	GPIO_FN_IRQ6,
 
 	/* Port7 */
 	GPIO_FN_LCDD7,
 	GPIO_FN_PDM0_OUTDATA_7,
 	GPIO_FN_DU0_DR7,
-	GPIO_FN_IRQ7,
 
 	/* Port8 */
 	GPIO_FN_LCDD8,
 	GPIO_FN_PDM1_OUTCLK_8,
 	GPIO_FN_DU0_DG0,
-	GPIO_FN_IRQ8,
 
 	/* Port9 */
 	GPIO_FN_LCDD9,
 	GPIO_FN_PDM1_OUTDATA_9,
 	GPIO_FN_DU0_DG1,
-	GPIO_FN_IRQ9,
 
 	/* Port10 */
 	GPIO_FN_LCDD10,
 	GPIO_FN_FSICCK,
 	GPIO_FN_DU0_DG2,
-	GPIO_FN_IRQ10,
 
 	/* Port11 */
 	GPIO_FN_LCDD11,
 	GPIO_FN_FSICISLD,
 	GPIO_FN_DU0_DG3,
-	GPIO_FN_IRQ11,
 
 	/* Port12 */
 	GPIO_FN_LCDD12,
 	GPIO_FN_FSICOMC,
 	GPIO_FN_DU0_DG4,
-	GPIO_FN_IRQ12,
 
 	/* Port13 */
 	GPIO_FN_LCDD13,
 	GPIO_FN_FSICOLR,
 	GPIO_FN_FSICILR,
 	GPIO_FN_DU0_DG5,
-	GPIO_FN_IRQ13,
 
 	/* Port14 */
 	GPIO_FN_LCDD14,
 	GPIO_FN_FSICOBT,
 	GPIO_FN_FSICIBT,
 	GPIO_FN_DU0_DG6,
-	GPIO_FN_IRQ14,
 
 	/* Port15 */
 	GPIO_FN_LCDD15,
 	GPIO_FN_FSICOSLD,
 	GPIO_FN_DU0_DG7,
-	GPIO_FN_IRQ15,
 
 	/* Port16 */
 	GPIO_FN_LCDD16,
@@ -294,7 +278,6 @@ enum {
 	GPIO_FN_HSI_RX_WAKE,
 	GPIO_FN_MSIOF3_SYNC,
 	GPIO_FN_GenIO4,
-	GPIO_FN_IRQ40,
 
 	/* Port67 */
 	GPIO_FN_HSI_RX_READY,
@@ -344,8 +327,6 @@ enum {
 	GPIO_FN_TXP2,
 	GPIO_FN_COEX_0,
 	GPIO_FN_COEX_1,
-	GPIO_FN_IRQ19,
-	GPIO_FN_IRQ18,
 
 	/* Port96 - Port101 */
 	GPIO_FN_KEYIN0,
@@ -357,11 +338,9 @@ enum {
 
 	/* Port102 */
 	GPIO_FN_KEYIN6,
-	GPIO_FN_IRQ41,
 
 	/* Port103 */
 	GPIO_FN_KEYIN7,
-	GPIO_FN_IRQ42,
 
 	/* Port104 - Port108 */
 	GPIO_FN_KEYOUT0,
@@ -372,40 +351,33 @@ enum {
 
 	/* Port109 */
 	GPIO_FN_KEYOUT5,
-	GPIO_FN_IRQ43,
 
 	/* Port110 */
 	GPIO_FN_KEYOUT6,
-	GPIO_FN_IRQ44,
 
 	/* Port111 */
 	GPIO_FN_KEYOUT7,
 	GPIO_FN_RFANAEN,
-	GPIO_FN_IRQ45,
 
 	/* Port112 */
 	GPIO_FN_KEYIN8,
 	GPIO_FN_KEYOUT8,
 	GPIO_FN_SF_IRQ_04,
-	GPIO_FN_IRQ46,
 
 	/* Port113 */
 	GPIO_FN_KEYIN9,
 	GPIO_FN_KEYOUT9,
 	GPIO_FN_SF_IRQ_05,
-	GPIO_FN_IRQ47,
 
 	/* Port114 */
 	GPIO_FN_KEYIN10,
 	GPIO_FN_KEYOUT10,
 	GPIO_FN_SF_IRQ_06,
-	GPIO_FN_IRQ48,
 
 	/* Port115 */
 	GPIO_FN_KEYIN11,
 	GPIO_FN_KEYOUT11,
 	GPIO_FN_SF_IRQ_07,
-	GPIO_FN_IRQ49,
 
 	/* Port116 */
 	GPIO_FN_CSCIF0_TX,
@@ -484,10 +456,6 @@ enum {
 	GPIO_FN_STP_ISD_1,
 
 	/* Port160 - Port178 */
-	GPIO_FN_IRQ20,
-	GPIO_FN_IRQ21,
-	GPIO_FN_IRQ22,
-	GPIO_FN_IRQ23,
 	GPIO_FN_MMCD0_0,
 	GPIO_FN_MMCD0_1,
 	GPIO_FN_MMCD0_2,
@@ -499,10 +467,6 @@ enum {
 	GPIO_FN_MMCCMD0,
 	GPIO_FN_MMCCLK0,
 	GPIO_FN_MMCRST,
-	GPIO_FN_IRQ24,
-	GPIO_FN_IRQ25,
-	GPIO_FN_IRQ26,
-	GPIO_FN_IRQ27,
 
 	/* Port192 - Port200 FN1 */
 	GPIO_FN_A10,
@@ -527,15 +491,6 @@ enum {
 	GPIO_FN_MMCCMD1,
 
 	/* Port192 - Port200 IRQ */
-	GPIO_FN_IRQ31,
-	GPIO_FN_IRQ32,
-	GPIO_FN_IRQ33,
-	GPIO_FN_IRQ34,
-	GPIO_FN_IRQ35,
-	GPIO_FN_IRQ36,
-	GPIO_FN_IRQ37,
-	GPIO_FN_IRQ38,
-	GPIO_FN_IRQ39,
 
 	/* Port201 */
 	GPIO_FN_A1,
@@ -792,7 +747,6 @@ enum {
 	/* Port290 */
 	GPIO_FN_SDHID1_1,
 	GPIO_FN_STMDATA1_2,
-	GPIO_FN_IRQ51,
 
 	/* Port291 - Port294 FN1 */
 	GPIO_FN_SDHID1_2,
@@ -814,7 +768,6 @@ enum {
 	/* Port296 */
 	GPIO_FN_SDHID2_1,
 	GPIO_FN_MSIOF6_SS2,
-	GPIO_FN_IRQ52,
 
 	/* Port297 - Port300 FN1 */
 	GPIO_FN_SDHID2_2,
@@ -838,7 +791,6 @@ enum {
 
 	/* Port301 */
 	GPIO_FN_SDHICD0,
-	GPIO_FN_IRQ50,
 
 	/* Port302 - Port306 FN1 */
 	GPIO_FN_SDHID0_0,
@@ -862,16 +814,6 @@ enum {
 	GPIO_FN_STMCLK_1,
 
 	/* Port320 - Port329 */
-	GPIO_FN_IRQ16,
-	GPIO_FN_IRQ17,
-	GPIO_FN_IRQ28,
-	GPIO_FN_IRQ29,
-	GPIO_FN_IRQ30,
-	GPIO_FN_IRQ53,
-	GPIO_FN_IRQ54,
-	GPIO_FN_IRQ55,
-	GPIO_FN_IRQ56,
-	GPIO_FN_IRQ57,
 };
 
 void r8a73a4_add_standard_devices(void);
-- 
1.7.10.4
