From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 15 Oct 2015 19:17:21 +0200
Subject: [PATCH 1/3] mtd: nand: add NAND_NEED_SCRAMBLING option flag
In-Reply-To: <1444929443-25537-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1444929443-25537-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1444929443-25537-2-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some MLC NANDs are sensible to repeated patterns and require data to be
scrambled in order to limit the number of bitflips.
Add a new flag to let the NAND controller know about this constraint.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 include/linux/mtd/nand.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 5a9d1d4..19b4c6f 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -160,6 +160,12 @@ typedef enum {
 /* Device supports subpage reads */
 #define NAND_SUBPAGE_READ	0x00001000
 
+/*
+ * Some MLC NANDs need data scrambling to limit bitflips caused by repeated
+ * patterns.
+ */
+#define NAND_NEED_SCRAMBLING	0x00002000
+
 /* Options valid for Samsung large page devices */
 #define NAND_SAMSUNG_LP_OPTIONS NAND_CACHEPRG
 
-- 
2.1.4
