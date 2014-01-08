From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Wed,  8 Jan 2014 15:21:57 +0100
Subject: [RFC PATCH 2/9] mtd: nand: define struct nand_timings
In-Reply-To: <1389190924-26226-1-git-send-email-b.brezillon@overkiz.com>
References: <1389190924-26226-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1389190924-26226-3-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define a struct containing the standard NAND timings as described in NAND
datasheets.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 include/linux/mtd/nand.h |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 9e6c8f9..3dda312 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -805,4 +805,48 @@ static inline bool nand_is_slc(struct nand_chip *chip)
 {
 	return chip->bits_per_cell == 1;
 }
+
+/**
+ * struct nand_timings - NAND chip timing definitions
+ *
+ * This struct defines the timing requirements of a NAND chip.
+ * These informations can be found in every NAND datasheets.
+ *
+ * All fields are optional and depend on the hardware driver requirements
+ */
+struct nand_timings {
+	u32 tCLS_min;
+	u32 tCLH_min;
+	u32 tCS_min;
+	u32 tCH_min;
+	u32 tWP_min;
+	u32 tALS_min;
+	u32 tALH_min;
+	u32 tDS_min;
+	u32 tDH_min;
+	u32 tWC_min;
+	u32 tWH_min;
+	u32 tR_max;
+	u32 tAR_min;
+	u32 tCLR_min;
+	u32 tRR_min;
+	u32 tRP_min;
+	u32 tWB_max;
+	u32 tRC_min;
+	u32 tREA_max;
+	u32 tRHZ_max;
+	u32 tCHZ_max;
+	u32 tRHOH_min;
+	u32 tRLOH_min;
+	u32 tCOH_min;
+	u32 tREH_min;
+	u32 tWHR_min;
+	u32 tRHW_min;
+	u32 tIR_min;
+	u32 tCR_min;
+	u32 tADL_min;
+	u32 tRST_max;
+	u32 tWW_min;
+};
+
 #endif /* __LINUX_MTD_NAND_H */
-- 
1.7.9.5
