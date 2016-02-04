From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu,  4 Feb 2016 11:06:40 +0100
Subject: [PATCH v2 17/51] mtd: onenand: use mtd_set_ecclayout() where
 appropriate
In-Reply-To: <1454580434-32078-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1454580434-32078-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1454580434-32078-18-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the mtd_set_ecclayout() helper instead of directly assigning the
mtd->ecclayout field.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/onenand/onenand_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/onenand/onenand_base.c b/drivers/mtd/onenand/onenand_base.c
index 6906c95..1d8406d 100644
--- a/drivers/mtd/onenand/onenand_base.c
+++ b/drivers/mtd/onenand/onenand_base.c
@@ -3994,7 +3994,7 @@ int onenand_scan(struct mtd_info *mtd, int maxchips)
 	if (mtd->oobavail < 0)
 		mtd->oobavail = 0;
 
-	mtd->ecclayout = this->ecclayout;
+	mtd_set_ecclayout(mtd, this->ecclayout);
 	mtd->ecc_strength = 1;
 
 	/* Fill in remaining MTD driver data */
-- 
2.1.4
