From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Dec 2015 23:26:02 +0100
Subject: [PATCH 07/23] staging: mt29f_spinand: kill unused ecclayout field
In-Reply-To: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449527178-5930-8-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The spinand_info struct embeds a pointer to an ecclayout definition, but
this field is never used in the mt29f driver.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/staging/mt29f_spinand/mt29f_spinand.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/mt29f_spinand/mt29f_spinand.h b/drivers/staging/mt29f_spinand/mt29f_spinand.h
index ae62975..457dc7f 100644
--- a/drivers/staging/mt29f_spinand/mt29f_spinand.h
+++ b/drivers/staging/mt29f_spinand/mt29f_spinand.h
@@ -78,7 +78,6 @@
 #define BL_ALL_UNLOCKED    0
 
 struct spinand_info {
-	struct nand_ecclayout *ecclayout;
 	struct spi_device *spi;
 	void *priv;
 };
-- 
2.1.4
