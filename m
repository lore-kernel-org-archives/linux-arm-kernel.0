From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Dec 2015 23:26:04 +0100
Subject: [PATCH 09/23] mtd: nand: vf610: remove useless mtd->ecclayout
 assignment
In-Reply-To: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449527178-5930-10-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NAND core layer is already taking care of ecclayout propagation. Remove
this useless assignment.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/vf610_nfc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mtd/nand/vf610_nfc.c b/drivers/mtd/nand/vf610_nfc.c
index 1c86c6b..0413e24 100644
--- a/drivers/mtd/nand/vf610_nfc.c
+++ b/drivers/mtd/nand/vf610_nfc.c
@@ -794,8 +794,6 @@ static int vf610_nfc_probe(struct platform_device *pdev)
 			goto error;
 		}
 
-		/* propagate ecc.layout to mtd_info */
-		mtd->ecclayout = chip->ecc.layout;
 		chip->ecc.read_page = vf610_nfc_read_page;
 		chip->ecc.write_page = vf610_nfc_write_page;
 
-- 
2.1.4
