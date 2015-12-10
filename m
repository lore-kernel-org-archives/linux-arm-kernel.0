From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 10 Dec 2015 09:00:39 +0100
Subject: [PATCH v4 55/58] mtd: nand: add helpers to access ->priv
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449734442-18672-56-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add two helpers to access the field reserved for private controller data.
This makes it clearer what this field is reserved for and ease future
refactoring.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 include/linux/mtd/nand.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 2bee2e4..4aed4b2 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -739,6 +739,16 @@ static inline struct mtd_info *nand_to_mtd(struct nand_chip *chip)
 	return &chip->mtd;
 }
 
+static inline void *nand_get_controller_data(struct nand_chip *chip)
+{
+	return chip->priv;
+}
+
+static inline void nand_set_controller_data(struct nand_chip *chip, void *priv)
+{
+	chip->priv = priv;
+}
+
 /*
  * NAND Flash Manufacturer ID Codes
  */
-- 
2.1.4
