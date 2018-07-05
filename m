From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Thu,  5 Jul 2018 12:27:28 +0200
Subject: [PATCH 3/8] mtd: rawnand: Remove forward declaration of mtd_info
In-Reply-To: <20180705102733.29673-1-boris.brezillon@bootlin.com>
References: <20180705102733.29673-1-boris.brezillon@bootlin.com>
Message-ID: <20180705102733.29673-4-boris.brezillon@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

struct mtd_info is defined in linux/mtd/mtd.h which is included
at the beginning of nand_base.c, there's thus no need for the
forward declaration of mtd_info.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 include/linux/mtd/rawnand.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 4d7a46c42900..32145b302585 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -23,7 +23,6 @@
 #include <linux/mtd/bbm.h>
 #include <linux/types.h>
 
-struct mtd_info;
 struct nand_flash_dev;
 struct device_node;
 
-- 
2.14.1
