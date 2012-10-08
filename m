From: afzal@ti.com (Afzal Mohammed)
Date: Mon, 8 Oct 2012 11:06:50 +0530
Subject: [PATCH v2 02/14] mtd: onenand: omap: cleanup gpmc dependency
In-Reply-To: <cover.1349672877.git.afzal@ti.com>
References: <cover.1349672877.git.afzal@ti.com>
Message-ID: <77643c064b9d0d639f75f793130bb40768b015e1.1349672877.git.afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

requesting, freeing gpmc cs is now handled fully
by gpmc, remove left out gpmc dependency as well
as unnecessary include of gpmc.h

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 drivers/mtd/onenand/omap2.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index 1961be9..d7ef2c9 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -38,7 +38,6 @@
 #include <linux/regulator/consumer.h>
 
 #include <asm/mach/flash.h>
-#include <plat/gpmc.h>
 #include <linux/platform_data/mtd-onenand-omap2.h>
 #include <asm/gpio.h>
 
@@ -803,7 +802,6 @@ static int __devexit omap2_onenand_remove(struct platform_device *pdev)
 	}
 	iounmap(c->onenand.base);
 	release_mem_region(c->phys_base, c->mem_size);
-	gpmc_cs_free(c->gpmc_cs);
 	kfree(c);
 
 	return 0;
-- 
1.7.12
