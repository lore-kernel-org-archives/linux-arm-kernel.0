From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 16 Nov 2015 14:37:46 +0100
Subject: [PATCH 13/27] mtd: nand: add nand_to_mtd() helper
In-Reply-To: <1447681080-31232-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1447681080-31232-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1447681080-31232-14-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new helper to retrieve the MTD device attached to a NAND chip.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 include/linux/mtd/nand.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index c4e39ff..8ec071e 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -737,6 +737,11 @@ static inline struct nand_chip *mtd_to_nand(struct mtd_info *mtd)
 	return mtd->priv;
 }
 
+static inline struct mtd_info *nand_to_mtd(struct nand_chip *chip)
+{
+	return &chip->mtd;
+}
+
 /*
  * NAND Flash Manufacturer ID Codes
  */
-- 
2.1.4
