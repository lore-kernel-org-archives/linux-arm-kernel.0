From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Wed, 13 Apr 2016 14:06:55 +0200
Subject: [PATCH 2/9] mtd: nand: s3c2410: set ECC algorithm explicitly
In-Reply-To: <1460549222-24198-1-git-send-email-zajec5@gmail.com>
References: <1460549222-24198-1-git-send-email-zajec5@gmail.com>
Message-ID: <1460549222-24198-3-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is part of process deprecating NAND_ECC_SOFT_BCH (and switching to
enum nand_ecc_algo).

Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
---
 drivers/mtd/nand/s3c2410.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/s3c2410.c b/drivers/mtd/nand/s3c2410.c
index 86ffb73..6e72679 100644
--- a/drivers/mtd/nand/s3c2410.c
+++ b/drivers/mtd/nand/s3c2410.c
@@ -860,6 +860,7 @@ static void s3c2410_nand_init_chip(struct s3c2410_nand_info *info,
 	}
 #else
 	chip->ecc.mode	    = NAND_ECC_SOFT;
+	chip->ecc.algo	= NAND_ECC_HAMMING;
 #endif
 
 	if (set->disable_ecc)
-- 
1.8.4.5
