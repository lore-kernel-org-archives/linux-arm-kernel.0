From: andrea.adami@gmail.com (Andrea Adami)
Date: Thu,  1 Jun 2017 00:40:54 +0200
Subject: [PATCH v3 5/9] mtd: nand: tmio_nand.c: take in account partition
 parser types
In-Reply-To: <1496270458-6479-1-git-send-email-andrea.adami@gmail.com>
References: <1496270458-6479-1-git-send-email-andrea.adami@gmail.com>
Message-ID: <1496270458-6479-6-git-send-email-andrea.adami@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
---
 drivers/mtd/nand/tmio_nand.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/tmio_nand.c b/drivers/mtd/nand/tmio_nand.c
index fc5e773..bea05bb 100644
--- a/drivers/mtd/nand/tmio_nand.c
+++ b/drivers/mtd/nand/tmio_nand.c
@@ -440,7 +440,9 @@ static int tmio_probe(struct platform_device *dev)
 		goto err_irq;
 
 	/* Register the partitions */
-	retval = mtd_device_parse_register(mtd, NULL, NULL,
+	retval = mtd_device_parse_register(mtd,
+					   data->types ? data->types : NULL,
+					   NULL,
 					   data ? data->partition : NULL,
 					   data ? data->num_partitions : 0);
 	if (!retval)
-- 
2.7.4
