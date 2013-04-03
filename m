From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  3 Apr 2013 11:08:22 +0900
Subject: [PATCH 07/11] ARM: shmobile: mackerel: SDHI resources do not have to
 be numbered
In-Reply-To: <1364954906-16014-1-git-send-email-horms+renesas@verge.net.au>
References: <1364954906-16014-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364954906-16014-8-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

The SDHI driver doesn't care about platform resource order, explicit
resource numbering is redundant.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-mackerel.c |   33 +++++++++++--------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 1a9c753..c4f80d4 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -982,21 +982,18 @@ static struct sh_mobile_sdhi_info sdhi0_info = {
 };
 
 static struct resource sdhi0_resources[] = {
-	[0] = {
+	{
 		.name	= "SDHI0",
 		.start	= 0xe6850000,
 		.end	= 0xe68500ff,
 		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
+	}, {
 		.start	= evt2irq(0x0e00) /* SDHI0_SDHI0I0 */,
 		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
+	}, {
 		.start	= evt2irq(0x0e20) /* SDHI0_SDHI0I1 */,
 		.flags	= IORESOURCE_IRQ,
-	},
-	[3] = {
+	}, {
 		.start	= evt2irq(0x0e40) /* SDHI0_SDHI0I2 */,
 		.flags	= IORESOURCE_IRQ,
 	},
@@ -1025,23 +1022,20 @@ static struct sh_mobile_sdhi_info sdhi1_info = {
 };
 
 static struct resource sdhi1_resources[] = {
-	[0] = {
+	{
 		.name	= "SDHI1",
 		.start	= 0xe6860000,
 		.end	= 0xe68600ff,
 		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
+	}, {
 		.name	= SH_MOBILE_SDHI_IRQ_CARD_DETECT,
 		.start	= evt2irq(0x0e80), /* SDHI1_SDHI1I0 */
 		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
+	}, {
 		.name	= SH_MOBILE_SDHI_IRQ_SDCARD,
 		.start	= evt2irq(0x0ea0), /* SDHI1_SDHI1I1 */
 		.flags	= IORESOURCE_IRQ,
-	},
-	[3] = {
+	}, {
 		.name	= SH_MOBILE_SDHI_IRQ_SDIO,
 		.start	= evt2irq(0x0ec0), /* SDHI1_SDHI1I2 */
 		.flags	= IORESOURCE_IRQ,
@@ -1079,23 +1073,20 @@ static struct sh_mobile_sdhi_info sdhi2_info = {
 };
 
 static struct resource sdhi2_resources[] = {
-	[0] = {
+	{
 		.name	= "SDHI2",
 		.start	= 0xe6870000,
 		.end	= 0xe68700ff,
 		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
+	}, {
 		.name	= SH_MOBILE_SDHI_IRQ_CARD_DETECT,
 		.start	= evt2irq(0x1200), /* SDHI2_SDHI2I0 */
 		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
+	}, {
 		.name	= SH_MOBILE_SDHI_IRQ_SDCARD,
 		.start	= evt2irq(0x1220), /* SDHI2_SDHI2I1 */
 		.flags	= IORESOURCE_IRQ,
-	},
-	[3] = {
+	}, {
 		.name	= SH_MOBILE_SDHI_IRQ_SDIO,
 		.start	= evt2irq(0x1240), /* SDHI2_SDHI2I2 */
 		.flags	= IORESOURCE_IRQ,
-- 
1.7.10.4
