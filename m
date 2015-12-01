From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue,  1 Dec 2015 12:03:07 +0100
Subject: [PATCH v2 10/25] mtd: nand: add nand_to_mtd() helper
In-Reply-To: <1448967802-25796-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1448967802-25796-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1448967802-25796-11-git-send-email-boris.brezillon@free-electrons.com>
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
