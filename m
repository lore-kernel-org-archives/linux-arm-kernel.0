From: notasas@gmail.com (Grazvydas Ignotas)
Date: Fri,  3 Jun 2011 23:24:03 +0300
Subject: [PATCH] omap: pandora: fix NAND support
Message-ID: <1307132643-17432-1-git-send-email-notasas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit d5ce2b65 "omap3630: nand: fix device size to work in polled mode"
changed values for .devsize in nand platform data, now we have to pass
NAND_BUSWIDTH_16 instead of '1' to select 16bit NAND.

Update pandora's platform data accordingly, also specify appropriate
transfer type.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 arch/arm/mach-omap2/board-omap3pandora.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 1d10736..a3d655c 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -86,7 +86,8 @@ static struct mtd_partition omap3pandora_nand_partitions[] = {
 
 static struct omap_nand_platform_data pandora_nand_data = {
 	.cs		= 0,
-	.devsize	= 1,	/* '0' for 8-bit, '1' for 16-bit device */
+	.devsize	= NAND_BUSWIDTH_16,
+	.xfer_type	= NAND_OMAP_PREFETCH_DMA,
 	.parts		= omap3pandora_nand_partitions,
 	.nr_parts	= ARRAY_SIZE(omap3pandora_nand_partitions),
 };
-- 
1.7.0.4
