From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu,  4 Feb 2016 11:06:37 +0100
Subject: [PATCH v2 14/51] mtd: add mtd_set_ecclayout() helper function
In-Reply-To: <1454580434-32078-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1454580434-32078-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1454580434-32078-15-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an mtd_set_ecclayout() helper function to avoid direct accesses to the
mtd->ecclayout field. This will ease future reworks of ECC layout
definition.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 include/linux/mtd/mtd.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index b141f26..6250dd8 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -286,6 +286,12 @@ int mtd_ooblayout_set_databytes(struct mtd_info *mtd, const u8 *databuf,
 int mtd_ooblayout_count_freebytes(struct mtd_info *mtd);
 int mtd_ooblayout_count_eccbytes(struct mtd_info *mtd);
 
+static inline void mtd_set_ecclayout(struct mtd_info *mtd,
+				     struct nand_ecclayout *ecclayout)
+{
+	mtd->ecclayout = ecclayout;
+}
+
 static inline void mtd_set_of_node(struct mtd_info *mtd,
 				   struct device_node *np)
 {
-- 
2.1.4
