From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu,  7 Nov 2013 12:17:18 -0300
Subject: [PATCH v4 14/31] mtd: nand: pxa3xx: Add a nice comment to
 pxa3xx_set_datasize()
In-Reply-To: <1383837455-30721-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1383837455-30721-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1383837455-30721-15-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a comment clarifying the use of pxa3xx_set_datasize() which is only
applicable on data read/write commands (i.e. commands with a data cycle,
such as READID, READ0, STATUS, etc.)

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/mtd/nand/pxa3xx_nand.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index dd8a7cf..dd7df0e 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -304,6 +304,11 @@ static void pxa3xx_nand_set_timing(struct pxa3xx_nand_host *host,
 	nand_writel(info, NDTR1CS0, ndtr1);
 }
 
+/*
+ * Set the data and OOB size, depending on the selected
+ * spare and ECC configuration.
+ * Only applicable to READ0, READOOB and PAGEPROG commands.
+ */
 static void pxa3xx_set_datasize(struct pxa3xx_nand_info *info)
 {
 	int oob_enable = info->reg_ndcr & NDCR_SPARE_EN;
-- 
1.8.1.5
