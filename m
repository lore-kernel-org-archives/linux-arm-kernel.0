From: eballetbo@gmail.com (Enric Balletbo i Serra)
Date: Sat, 23 Oct 2010 18:48:58 +0200
Subject: [PATCHv2 1/3] omap3: IGEP v2: Remove onenand_setup no-op function.
In-Reply-To: <1287852540-4951-1-git-send-email-eballetbo@gmail.com>
References: <1287852540-4951-1-git-send-email-eballetbo@gmail.com>
Message-ID: <1287852540-4951-2-git-send-email-eballetbo@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set onenand_setup to NULL instead of adding a no-op function.

Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
---
 arch/arm/mach-omap2/board-igep0020.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 5e035a5..20b199f 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -136,16 +136,9 @@ static struct mtd_partition igep2_onenand_partitions[] = {
 	},
 };
 
-static int igep2_onenand_setup(void __iomem *onenand_base, int freq)
-{
-       /* nothing is required to be setup for onenand as of now */
-       return 0;
-}
-
 static struct omap_onenand_platform_data igep2_onenand_data = {
 	.parts = igep2_onenand_partitions,
 	.nr_parts = ARRAY_SIZE(igep2_onenand_partitions),
-	.onenand_setup = igep2_onenand_setup,
 	.dma_channel	= -1,	/* disable DMA in OMAP OneNAND driver */
 };
 
-- 
1.7.1
