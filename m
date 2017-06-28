From: andrea.adami@gmail.com (Andrea Adami)
Date: Wed, 28 Jun 2017 22:30:31 +0200
Subject: [PATCH v4 4/9] mtd: nand: sharpsl.c: take in account partition parser
 types
In-Reply-To: <1498681836-3765-1-git-send-email-andrea.adami@gmail.com>
References: <1498681836-3765-1-git-send-email-andrea.adami@gmail.com>
Message-ID: <1498681836-3765-5-git-send-email-andrea.adami@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
---
 drivers/mtd/nand/sharpsl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/sharpsl.c b/drivers/mtd/nand/sharpsl.c
index 064ca17..87c6fc2 100644
--- a/drivers/mtd/nand/sharpsl.c
+++ b/drivers/mtd/nand/sharpsl.c
@@ -183,7 +183,7 @@ static int sharpsl_nand_probe(struct platform_device *pdev)
 	/* Register the partitions */
 	mtd->name = "sharpsl-nand";
 
-	err = mtd_device_parse_register(mtd, NULL, NULL,
+	err = mtd_device_parse_register(mtd, data->types, NULL,
 					data->partitions, data->nr_partitions);
 	if (err)
 		goto err_add;
-- 
2.7.4
