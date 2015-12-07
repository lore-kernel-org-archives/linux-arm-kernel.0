From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Dec 2015 23:26:08 +0100
Subject: [PATCH 13/23] mtd: add mtd_set_ecclayout() helper function
In-Reply-To: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449527178-5930-14-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an mtd_set_ecclayout() helper function to avoid direct accesses to the
mtd->ecclayout field. This will ease future refactor of ECC layout
definition.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 include/linux/mtd/mtd.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 25e3d0f..80e32fa 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -253,6 +253,12 @@ struct mtd_info {
 	int usecount;
 };
 
+static inline void mtd_set_ecclayout(struct mtd_info *mtd,
+				     struct nand_ecclayout *ecclayout)
+{
+	mtd->ecclayout = ecclayout;
+}
+
 static inline int mtd_eccpos(struct mtd_info *mtd, int eccbyte)
 {
 	if (!mtd->ecclayout)
-- 
2.1.4
