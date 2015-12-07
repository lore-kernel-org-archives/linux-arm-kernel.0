From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Dec 2015 23:26:03 +0100
Subject: [PATCH 08/23] mtd: nand: lpc32xx_mlc: fix ecc.size
In-Reply-To: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449527178-5930-9-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the ECC layout description the actual ecc.size is 512 bytes
and not mtd->writesize.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/lpc32xx_mlc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/lpc32xx_mlc.c b/drivers/mtd/nand/lpc32xx_mlc.c
index 57c4b71..0ee81a0 100644
--- a/drivers/mtd/nand/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/lpc32xx_mlc.c
@@ -751,7 +751,7 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 	}
 
 	nand_chip->ecc.mode = NAND_ECC_HW;
-	nand_chip->ecc.size = mtd->writesize;
+	nand_chip->ecc.size = 512;
 	nand_chip->ecc.layout = &lpc32xx_nand_oob;
 	host->mlcsubpages = mtd->writesize / 512;
 
-- 
2.1.4
