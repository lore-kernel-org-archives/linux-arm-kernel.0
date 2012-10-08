From: afzal@ti.com (Afzal Mohammed)
Date: Mon, 8 Oct 2012 11:07:03 +0530
Subject: [PATCH v2 04/14] mtd: nand: omap: read nand using register address
In-Reply-To: <cover.1349672877.git.afzal@ti.com>
References: <cover.1349672877.git.afzal@ti.com>
Message-ID: <571607de9b49c4d44a03e793a9b36654e5ff4570.1349672877.git.afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that gpmc-nand registers are available in driver, use it
to read nand data.

"65b97cf  mtd: nand: omap2: handle nand on gpmc" modified all
other instances. After initial versions of that patch, a new
change added reading nand data using gpmc exposed function.
In the final version this change was not taken care.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 drivers/mtd/nand/omap2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 4c33135..abfc602 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -996,7 +996,7 @@ static int omap_wait(struct mtd_info *mtd, struct nand_chip *chip)
 		cond_resched();
 	}
 
-	status = gpmc_nand_read(info->gpmc_cs, GPMC_NAND_DATA);
+	status = readb(info->reg.gpmc_nand_data);
 	return status;
 }
 
-- 
1.7.12
