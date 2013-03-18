From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:07:10 +0900
Subject: [PATCH 134/142] ARM: shmobile: r8a7740: Remove SDHI and MMCIF
 function GPIOs
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-135-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Those GPIOs have been deprecated by the pinctrl API. They are unused and
unneeded, remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/include/mach/r8a7740.h |   35 -------------------------
 1 file changed, 35 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7740.h b/arch/arm/mach-shmobile/include/mach/r8a7740.h
index 0c417da..c258361 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7740.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7740.h
@@ -307,26 +307,6 @@ enum {
 	GPIO_FN_SIM_D_PORT22, /* SIM_D  Port 22/199 */
 	GPIO_FN_SIM_D_PORT199,
 
-	/* SDHI0 */
-	GPIO_FN_SDHI0_D0,	GPIO_FN_SDHI0_D1,	GPIO_FN_SDHI0_D2,
-	GPIO_FN_SDHI0_D3,	GPIO_FN_SDHI0_CD,	GPIO_FN_SDHI0_WP,
-	GPIO_FN_SDHI0_CMD,	GPIO_FN_SDHI0_CLK,
-
-	/* SDHI1 */
-	GPIO_FN_SDHI1_D0,	GPIO_FN_SDHI1_D1,	GPIO_FN_SDHI1_D2,
-	GPIO_FN_SDHI1_D3,	GPIO_FN_SDHI1_CD,	GPIO_FN_SDHI1_WP,
-	GPIO_FN_SDHI1_CMD,	GPIO_FN_SDHI1_CLK,
-
-	/* SDHI2 */
-	GPIO_FN_SDHI2_D0,	GPIO_FN_SDHI2_D1,	GPIO_FN_SDHI2_D2,
-	GPIO_FN_SDHI2_D3,	GPIO_FN_SDHI2_CLK,	GPIO_FN_SDHI2_CMD,
-
-	GPIO_FN_SDHI2_CD_PORT24, /* MSEL5CR_19_0 */
-	GPIO_FN_SDHI2_WP_PORT25,
-
-	GPIO_FN_SDHI2_WP_PORT177, /* MSEL5CR_19_1 */
-	GPIO_FN_SDHI2_CD_PORT202,
-
 	/* MSIOF2 */
 	GPIO_FN_MSIOF2_TXD,	GPIO_FN_MSIOF2_RXD,	GPIO_FN_MSIOF2_TSCK,
 	GPIO_FN_MSIOF2_SS2,	GPIO_FN_MSIOF2_TSYNC,	GPIO_FN_MSIOF2_SS1,
@@ -378,21 +358,6 @@ enum {
 	GPIO_FN_MEMC_DREQ1,
 	GPIO_FN_MEMC_A0,
 
-	/* MMC */
-	GPIO_FN_MMC0_D0_PORT68,		GPIO_FN_MMC0_D1_PORT69,
-	GPIO_FN_MMC0_D2_PORT70,		GPIO_FN_MMC0_D3_PORT71,
-	GPIO_FN_MMC0_D4_PORT72,		GPIO_FN_MMC0_D5_PORT73,
-	GPIO_FN_MMC0_D6_PORT74,		GPIO_FN_MMC0_D7_PORT75,
-	GPIO_FN_MMC0_CLK_PORT66,
-	GPIO_FN_MMC0_CMD_PORT67,	/* MSEL4CR_15_0 */
-
-	GPIO_FN_MMC1_D0_PORT149,	GPIO_FN_MMC1_D1_PORT148,
-	GPIO_FN_MMC1_D2_PORT147,	GPIO_FN_MMC1_D3_PORT146,
-	GPIO_FN_MMC1_D4_PORT145,	GPIO_FN_MMC1_D5_PORT144,
-	GPIO_FN_MMC1_D6_PORT143,	GPIO_FN_MMC1_D7_PORT142,
-	GPIO_FN_MMC1_CLK_PORT103,
-	GPIO_FN_MMC1_CMD_PORT104,	/* MSEL4CR_15_1 */
-
 	/* MSIOF0 */
 	GPIO_FN_MSIOF0_SS1,	GPIO_FN_MSIOF0_SS2,
 	GPIO_FN_MSIOF0_RXD,	GPIO_FN_MSIOF0_TXD,
-- 
1.7.10.4
