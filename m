From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Apr 2013 14:11:22 +0900
Subject: [PATCH 10/11] ARM: shmobile: mackerel: add interrupt names for SDHI0
In-Reply-To: <1364879483-11144-1-git-send-email-horms+renesas@verge.net.au>
References: <1364879483-11144-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364879483-11144-11-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

To unify with SDHI1 also use named IRQs for SDHI0. This also clarifies
which specific IRQs are used.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-mackerel.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index a47a1116..b976ad6 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -979,12 +979,11 @@ static struct resource sdhi0_resources[] = {
 		.end	= 0xe68500ff,
 		.flags	= IORESOURCE_MEM,
 	}, {
-		.start	= evt2irq(0x0e00) /* SDHI0_SDHI0I0 */,
-		.flags	= IORESOURCE_IRQ,
-	}, {
+		.name	= SH_MOBILE_SDHI_IRQ_SDCARD,
 		.start	= evt2irq(0x0e20) /* SDHI0_SDHI0I1 */,
 		.flags	= IORESOURCE_IRQ,
 	}, {
+		.name	= SH_MOBILE_SDHI_IRQ_SDIO,
 		.start	= evt2irq(0x0e40) /* SDHI0_SDHI0I2 */,
 		.flags	= IORESOURCE_IRQ,
 	},
@@ -1020,10 +1019,6 @@ static struct resource sdhi1_resources[] = {
 		.end	= 0xe68600ff,
 		.flags	= IORESOURCE_MEM,
 	}, {
-		.name	= SH_MOBILE_SDHI_IRQ_CARD_DETECT,
-		.start	= evt2irq(0x0e80), /* SDHI1_SDHI1I0 */
-		.flags	= IORESOURCE_IRQ,
-	}, {
 		.name	= SH_MOBILE_SDHI_IRQ_SDCARD,
 		.start	= evt2irq(0x0ea0), /* SDHI1_SDHI1I1 */
 		.flags	= IORESOURCE_IRQ,
-- 
1.7.10.4
