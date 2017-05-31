From: andrea.adami@gmail.com (Andrea Adami)
Date: Thu,  1 Jun 2017 00:40:53 +0200
Subject: [PATCH v3 4/9] mtd: nand: sharpsl.c: take in account partition parser
 types
In-Reply-To: <1496270458-6479-1-git-send-email-andrea.adami@gmail.com>
References: <1496270458-6479-1-git-send-email-andrea.adami@gmail.com>
Message-ID: <1496270458-6479-5-git-send-email-andrea.adami@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
---
 drivers/mtd/nand/sharpsl.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/sharpsl.c b/drivers/mtd/nand/sharpsl.c
index 064ca17..1a76779 100644
--- a/drivers/mtd/nand/sharpsl.c
+++ b/drivers/mtd/nand/sharpsl.c
@@ -183,8 +183,13 @@ static int sharpsl_nand_probe(struct platform_device *pdev)
 	/* Register the partitions */
 	mtd->name = "sharpsl-nand";
 
-	err = mtd_device_parse_register(mtd, NULL, NULL,
-					data->partitions, data->nr_partitions);
+	err = mtd_device_parse_register(&sharpsl->mtd,
+					data->types ? data->types : NULL,
+					NULL,
+					data->partitions ?
+					data->partitions : NULL,
+					data->nr_partitions ?
+					data->nr_partitions : 0);
 	if (err)
 		goto err_add;
 
-- 
2.7.4
