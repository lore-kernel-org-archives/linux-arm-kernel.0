From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 5 Jan 2018 21:55:28 +0100
Subject: [PATCH] mtd/nand/atmel: Delete an error message for a failed memory
 allocation in two functions
Message-ID: <81cadb76-8c67-9289-1375-2d4a55a4adfa@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 5 Jan 2018 21:45:04 +0100

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/mtd/nand/atmel/nand-controller.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/atmel/nand-controller.c b/drivers/mtd/nand/atmel/nand-controller.c
index 90a71a56bc23..a41b999229c9 100644
--- a/drivers/mtd/nand/atmel/nand-controller.c
+++ b/drivers/mtd/nand/atmel/nand-controller.c
@@ -1612,10 +1612,8 @@ static int atmel_nand_register(struct atmel_nand *nand)
 		mtd->name = devm_kasprintf(nc->dev, GFP_KERNEL,
 					   "%s:nand.%d", dev_name(nc->dev),
 					   nand->cs[0].id);
-		if (!mtd->name) {
-			dev_err(nc->dev, "Failed to allocate mtd->name\n");
+		if (!mtd->name)
 			return -ENOMEM;
-		}
 	}
 
 	ret = nand_scan_tail(mtd);
@@ -1654,10 +1652,8 @@ static struct atmel_nand *atmel_nand_create(struct atmel_nand_controller *nc,
 	nand = devm_kzalloc(nc->dev,
 			    sizeof(*nand) + (numcs * sizeof(*nand->cs)),
 			    GFP_KERNEL);
-	if (!nand) {
-		dev_err(nc->dev, "Failed to allocate NAND object\n");
+	if (!nand)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	nand->numcs = numcs;
 
-- 
2.15.1
