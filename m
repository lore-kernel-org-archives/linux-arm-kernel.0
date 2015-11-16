From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 16 Nov 2015 14:37:35 +0100
Subject: [PATCH 02/27] mtd: nand: add an mtd_to_nand() helper
In-Reply-To: <1447681080-31232-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1447681080-31232-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1447681080-31232-3-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some drivers are retrieving the nand_chip pointer using the container_of
macro on a struct wrapping both the nand_chip and the mtd_info struct while
the standard way of retrieving this pointer is through mtd->priv.
Provide an helper to do that.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 include/linux/mtd/nand.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 4f7c9b9..056d165 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -730,6 +730,11 @@ static inline struct device_node *nand_get_flash_node(struct nand_chip *chip)
 	return chip->flash_node;
 }
 
+static inline struct nand_chip *mtd_to_nand(struct mtd_info *mtd)
+{
+	return mtd->priv;
+}
+
 /*
  * NAND Flash Manufacturer ID Codes
  */
-- 
2.1.4
