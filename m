From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:26:20 +0900
Subject: [PATCH 089/130] ARM: shmobile: r8a7740: Remove BSC function GPIOs
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-90-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Those GPIOs have been deprecated by the pinctrl API. They are unused and
unneeded, remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/r8a7740.h | 27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7740.h b/arch/arm/mach-shmobile/include/mach/r8a7740.h
index dea430e..61cff39 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7740.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7740.h
@@ -297,11 +297,7 @@ enum {
 	GPIO_FN_BBIF2_TSCK2_PORT89,
 	GPIO_FN_BBIF2_TSYNC2_PORT184,
 
-	/* BSC / FLCTL / PCMCIA */
-	GPIO_FN_CS0,	GPIO_FN_CS2,	GPIO_FN_CS4,
-	GPIO_FN_CS5B,	GPIO_FN_CS6A,
-	GPIO_FN_CS5A_PORT105, /* CS5A PORT 19/105 */
-	GPIO_FN_CS5A_PORT19,
+	/* FLCTL / PCMCIA */
 	GPIO_FN_IOIS16, /* ? */
 
 	GPIO_FN_A0,	GPIO_FN_A1,	GPIO_FN_A2,	GPIO_FN_A3,
@@ -314,26 +310,7 @@ enum {
 	GPIO_FN_A22,	GPIO_FN_A23,	GPIO_FN_A24,	GPIO_FN_A25,
 	GPIO_FN_A26,
 
-	GPIO_FN_D0_NAF0,	GPIO_FN_D1_NAF1,	/* share with FLCTL */
-	GPIO_FN_D2_NAF2,	GPIO_FN_D3_NAF3,	/* share with FLCTL */
-	GPIO_FN_D4_NAF4,	GPIO_FN_D5_NAF5,	/* share with FLCTL */
-	GPIO_FN_D6_NAF6,	GPIO_FN_D7_NAF7,	/* share with FLCTL */
-	GPIO_FN_D8_NAF8,	GPIO_FN_D9_NAF9,	/* share with FLCTL */
-	GPIO_FN_D10_NAF10,	GPIO_FN_D11_NAF11,	/* share with FLCTL */
-	GPIO_FN_D12_NAF12,	GPIO_FN_D13_NAF13,	/* share with FLCTL */
-	GPIO_FN_D14_NAF14,	GPIO_FN_D15_NAF15,	/* share with FLCTL */
-
-	GPIO_FN_D16,	GPIO_FN_D17,	GPIO_FN_D18,	GPIO_FN_D19,
-	GPIO_FN_D20,	GPIO_FN_D21,	GPIO_FN_D22,	GPIO_FN_D23,
-	GPIO_FN_D24,	GPIO_FN_D25,	GPIO_FN_D26,	GPIO_FN_D27,
-	GPIO_FN_D28,	GPIO_FN_D29,	GPIO_FN_D30,	GPIO_FN_D31,
-
-	GPIO_FN_WE0_FWE,	/* share with FLCTL */
-	GPIO_FN_WE1,
-	GPIO_FN_WE2_ICIORD,	/* share with PCMCIA */
-	GPIO_FN_WE3_ICIOWR,	/* share with PCMCIA */
-	GPIO_FN_CKO,	GPIO_FN_BS,	GPIO_FN_RDWR,
-	GPIO_FN_RD_FSC,		/* share with FLCTL */
+	GPIO_FN_CKO,
 	GPIO_FN_WAIT_PORT177,	/* WAIT Port 90/177 */
 	GPIO_FN_WAIT_PORT90,
 
-- 
1.8.2.1
