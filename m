From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Mar 2016 17:21:30 +0100
Subject: [PATCH 11/16] mtd: nand: sunxi: fix NFC_CTL setting
In-Reply-To: <1457367695-26420-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1457367513-26069-1-git-send-email-boris.brezillon@free-electrons.com>
 <1457367695-26420-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1457367695-26420-2-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NFC_PAGE_SHIFT() already takes the real page_shift value and subtract 10
to it.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/sunxi_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index c1ab33a..22d4d55 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -411,7 +411,7 @@ static void sunxi_nfc_select_chip(struct mtd_info *mtd, int chip)
 		sel = &sunxi_nand->sels[chip];
 
 		ctl |= NFC_CE_SEL(sel->cs) | NFC_EN |
-		       NFC_PAGE_SHIFT(nand->page_shift - 10);
+		       NFC_PAGE_SHIFT(nand->page_shift);
 		if (sel->rb.type == RB_NONE) {
 			nand->dev_ready = NULL;
 		} else {
-- 
2.1.4
