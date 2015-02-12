From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 12 Feb 2015 15:53:30 +0100
Subject: [PATCH v2 04/10] mtd: pxa3xx_nand: set NDCR_PG_PER_BLK if page per
 block is 128
In-Reply-To: <1423752816-26219-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1423752816-26219-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1423752816-26219-5-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/mtd/nand/pxa3xx_nand.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 55fce9527c2e..64628bff3fa5 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -1216,7 +1216,8 @@ static int pxa3xx_nand_config_flash(struct pxa3xx_nand_info *info,
 
 	ndcr |= (pdata->enable_arbiter) ? NDCR_ND_ARB_EN : 0;
 	ndcr |= (host->col_addr_cycles == 2) ? NDCR_RA_START : 0;
-	ndcr |= (f->page_per_block == 64) ? NDCR_PG_PER_BLK : 0;
+	ndcr |= (f->page_per_block == 64 || f->page_per_block == 128) ?
+		NDCR_PG_PER_BLK : 0;
 	ndcr |= (f->page_size == 2048) ? NDCR_PAGE_SZ : 0;
 	ndcr |= (f->flash_width == 16) ? NDCR_DWIDTH_M : 0;
 	ndcr |= (f->dfc_width == 16) ? NDCR_DWIDTH_C : 0;
-- 
2.3.0
