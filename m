From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:06:59 +0900
Subject: [PATCH 123/142] ARM: shmobile: sh7372: Remove SDHI and MMCIF function
 GPIOs
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-124-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Those GPIOs have been deprecated by the pinctrl API. They are unused and
unneeded, remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/include/mach/sh7372.h |   29 --------------------------
 1 file changed, 29 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/sh7372.h b/arch/arm/mach-shmobile/include/mach/sh7372.h
index b582fac..7ded4eb 100644
--- a/arch/arm/mach-shmobile/include/mach/sh7372.h
+++ b/arch/arm/mach-shmobile/include/mach/sh7372.h
@@ -294,21 +294,6 @@ enum {
 	GPIO_FN_D12_NAF12,	GPIO_FN_D13_NAF13,	GPIO_FN_D14_NAF14,
 	GPIO_FN_D15_NAF15,
 
-	/*
-	 * MMCIF(1)		(PORT 84, 85, 86, 87, 88, 89,
-	 *			      90, 91, 92, 99)
-	 */
-	GPIO_FN_MMCD0_0,	GPIO_FN_MMCD0_1,	GPIO_FN_MMCD0_2,
-	GPIO_FN_MMCD0_3,	GPIO_FN_MMCD0_4,	GPIO_FN_MMCD0_5,
-	GPIO_FN_MMCD0_6,	GPIO_FN_MMCD0_7,
-	GPIO_FN_MMCCMD0,	GPIO_FN_MMCCLK0,
-
-	/* MMCIF(2)		(PORT 54, 55, 56, 57, 58, 59, 60, 61, 66, 67) */
-	GPIO_FN_MMCD1_0,	GPIO_FN_MMCD1_1,	GPIO_FN_MMCD1_2,
-	GPIO_FN_MMCD1_3,	GPIO_FN_MMCD1_4,	GPIO_FN_MMCD1_5,
-	GPIO_FN_MMCD1_6,	GPIO_FN_MMCD1_7,
-	GPIO_FN_MMCCLK1,	GPIO_FN_MMCCMD1,
-
 	/* SPU2		(PORT 65) */
 	GPIO_FN_VINT_I,
 
@@ -416,20 +401,6 @@ enum {
 	/* HDMI		(PORT 169, 170) */
 	GPIO_FN_HDMI_HPD,	GPIO_FN_HDMI_CEC,
 
-	/* SDHI0	(PORT 171, 172, 173, 174, 175, 176, 177, 178) */
-	GPIO_FN_SDHICLK0,	GPIO_FN_SDHICD0,
-	GPIO_FN_SDHICMD0,	GPIO_FN_SDHIWP0,
-	GPIO_FN_SDHID0_0,	GPIO_FN_SDHID0_1,
-	GPIO_FN_SDHID0_2,	GPIO_FN_SDHID0_3,
-
-	/* SDHI1	(PORT 179, 180, 181, 182, 183, 184) */
-	GPIO_FN_SDHICLK1,	GPIO_FN_SDHICMD1,	GPIO_FN_SDHID1_0,
-	GPIO_FN_SDHID1_1,	GPIO_FN_SDHID1_2,	GPIO_FN_SDHID1_3,
-
-	/* SDHI2	(PORT 185, 186, 187, 188, 189, 190) */
-	GPIO_FN_SDHICLK2,	GPIO_FN_SDHICMD2,	GPIO_FN_SDHID2_0,
-	GPIO_FN_SDHID2_1,	GPIO_FN_SDHID2_2,	GPIO_FN_SDHID2_3,
-
 	/* SDENC	see MSEL4CR 19 */
 	GPIO_FN_SDENC_CPG,
 	GPIO_FN_SDENC_DV_CLKI,
-- 
1.7.10.4
