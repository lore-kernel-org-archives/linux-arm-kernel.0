From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Thu,  5 Jul 2018 12:27:29 +0200
Subject: [PATCH 4/8] mtd: rawnand: Remove forward declaration of device_node
In-Reply-To: <20180705102733.29673-1-boris.brezillon@bootlin.com>
References: <20180705102733.29673-1-boris.brezillon@bootlin.com>
Message-ID: <20180705102733.29673-5-boris.brezillon@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

struct device_node is defined in linux/of.h. Let's include this file
instead of having a forward declaration of this struct.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 include/linux/mtd/rawnand.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 32145b302585..83ab6779144e 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -21,10 +21,10 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/flashchip.h>
 #include <linux/mtd/bbm.h>
+#include <linux/of.h>
 #include <linux/types.h>
 
 struct nand_flash_dev;
-struct device_node;
 
 /* Scan and identify a NAND device */
 int nand_scan_with_ids(struct mtd_info *mtd, int max_chips,
-- 
2.14.1
