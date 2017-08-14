From: andrea.adami@gmail.com (Andrea Adami)
Date: Mon, 14 Aug 2017 22:48:33 +0200
Subject: [PATCH v5 2/9] mtd: nand: sharpsl: Add partition parsers platform data
In-Reply-To: <1502743720-28672-1-git-send-email-andrea.adami@gmail.com>
References: <1502743720-28672-1-git-send-email-andrea.adami@gmail.com>
Message-ID: <1502743720-28672-3-git-send-email-andrea.adami@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the introduction of sharpslpart partition parser we can now read the
offsets from NAND: we specify the list of the parsers as platform data, with
cmdlinepart and ofpart parsers first allowing to override the part. table
written in NAND. This is done in the board files using this driver.

Thus, we need to extend sharpsl_nand_platform_data to consider the partition
parsers.

Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
---
 include/linux/mtd/sharpsl.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mtd/sharpsl.h b/include/linux/mtd/sharpsl.h
index 65e91d0..6381a7d 100644
--- a/include/linux/mtd/sharpsl.h
+++ b/include/linux/mtd/sharpsl.h
@@ -17,4 +17,5 @@ struct sharpsl_nand_platform_data {
 	const struct mtd_ooblayout_ops *ecc_layout;
 	struct mtd_partition	*partitions;
 	unsigned int		nr_partitions;
+	const char *const	*part_parsers;
 };
-- 
2.7.4
