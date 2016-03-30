From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Mar 2016 18:14:29 +0200
Subject: [PATCH v5 14/50] mtd: onenand: use mtd_set_ecclayout() where
 appropriate
In-Reply-To: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1459354505-32551-15-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the mtd_set_ecclayout() helper instead of directly assigning the
mtd->ecclayout field.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/onenand/onenand_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/onenand/onenand_base.c b/drivers/mtd/onenand/onenand_base.c
index 20fdf8c..d0fa505 100644
--- a/drivers/mtd/onenand/onenand_base.c
+++ b/drivers/mtd/onenand/onenand_base.c
@@ -3997,7 +3997,7 @@ int onenand_scan(struct mtd_info *mtd, int maxchips)
 
 	mtd->oobavail = ret;
 
-	mtd->ecclayout = this->ecclayout;
+	mtd_set_ecclayout(mtd, this->ecclayout);
 	mtd->ecc_strength = 1;
 
 	/* Fill in remaining MTD driver data */
-- 
2.5.0
