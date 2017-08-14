From: andrea.adami@gmail.com (Andrea Adami)
Date: Mon, 14 Aug 2017 22:48:35 +0200
Subject: [PATCH v5 4/9] mtd: nand: sharpsl: Register partitions using the
 parsers
In-Reply-To: <1502743720-28672-1-git-send-email-andrea.adami@gmail.com>
References: <1502743720-28672-1-git-send-email-andrea.adami@gmail.com>
Message-ID: <1502743720-28672-5-git-send-email-andrea.adami@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the introduction of sharpslpart partition parser we can now read the
offsets from NAND: we specify the list of the parsers as platform data, with
cmdlinepart and ofpart parsers first allowing to override the part. table
written in NAND. This is done in the board files using this driver.

Use now these parsers.

Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
---
 drivers/mtd/nand/sharpsl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/sharpsl.c b/drivers/mtd/nand/sharpsl.c
index 064ca17..9859546 100644
--- a/drivers/mtd/nand/sharpsl.c
+++ b/drivers/mtd/nand/sharpsl.c
@@ -183,7 +183,7 @@ static int sharpsl_nand_probe(struct platform_device *pdev)
 	/* Register the partitions */
 	mtd->name = "sharpsl-nand";
 
-	err = mtd_device_parse_register(mtd, NULL, NULL,
+	err = mtd_device_parse_register(mtd, data->part_parsers, NULL,
 					data->partitions, data->nr_partitions);
 	if (err)
 		goto err_add;
-- 
2.7.4
