From: afzal@ti.com (Afzal Mohammed)
Date: Fri, 5 Oct 2012 21:23:35 +0530
Subject: [PATCH 03/15] mtd: nand: omap: free region as per resource size
In-Reply-To: <cover.1349450454.git.afzal@ti.com>
References: <cover.1349450454.git.afzal@ti.com>
Message-ID: <011a0d90343de9204cfd977381b36cace032482b.1349450454.git.afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

memory as is now obtained via resource, upon freeing use
resource size. This also helps get rid of one macro.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 drivers/mtd/nand/omap2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 5b31386..4c33135 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1513,7 +1513,7 @@ static int omap_nand_remove(struct platform_device *pdev)
 	/* Release NAND device, its internal structures and partitions */
 	nand_release(&info->mtd);
 	iounmap(info->nand.IO_ADDR_R);
-	release_mem_region(info->phys_base, NAND_IO_SIZE);
+	release_mem_region(info->phys_base, info->mem_size);
 	kfree(info);
 	return 0;
 }
-- 
1.7.12
