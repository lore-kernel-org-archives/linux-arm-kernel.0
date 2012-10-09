From: vipin.kumar@st.com (Vipin Kumar)
Date: Tue, 9 Oct 2012 16:14:43 +0530
Subject: [PATCH 01/11] fsmc/nand:FIX: Change the type for regs to void __iomem
 *
In-Reply-To: <cover.1349778820.git.vipin.kumar@st.com>
References: <cover.1349778820.git.vipin.kumar@st.com>
Message-ID: <c30a9228d4bff7dbedd5d011f84c79c324736452.1349778820.git.vipin.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Vipin Kumar <vipin.kumar@st.com>
---
 drivers/mtd/nand/fsmc_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/fsmc_nand.c b/drivers/mtd/nand/fsmc_nand.c
index 38d2624..e96d7d1 100644
--- a/drivers/mtd/nand/fsmc_nand.c
+++ b/drivers/mtd/nand/fsmc_nand.c
@@ -361,7 +361,7 @@ static void fsmc_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 	struct nand_chip *this = mtd->priv;
 	struct fsmc_nand_data *host = container_of(mtd,
 					struct fsmc_nand_data, mtd);
-	void *__iomem *regs = host->regs_va;
+	void __iomem *regs = host->regs_va;
 	unsigned int bank = host->bank;
 
 	if (ctrl & NAND_CTRL_CHANGE) {
-- 
1.7.11.4
