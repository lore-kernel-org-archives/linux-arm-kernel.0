From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 5 Jan 2018 22:34:33 +0100
Subject: [PATCH] mtd/nand/sunxi: Delete an error message for a failed memory
 allocation in sunxi_nand_chip_init()
Message-ID: <9a6e9845-23f0-0eb8-3c5b-d877e9874a1d@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 5 Jan 2018 22:27:09 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/mtd/nand/sunxi_nand.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index 82244be3e766..ebfa130a9285 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -2019,10 +2019,8 @@ static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
 			    sizeof(*chip) +
 			    (nsels * sizeof(struct sunxi_nand_chip_sel)),
 			    GFP_KERNEL);
-	if (!chip) {
-		dev_err(dev, "could not allocate chip\n");
+	if (!chip)
 		return -ENOMEM;
-	}
 
 	chip->nsels = nsels;
 	chip->selected = -1;
-- 
2.15.1
