From: josh.wu@atmel.com (Josh Wu)
Date: Wed,  5 Sep 2012 14:00:42 +0800
Subject: [PATCH] mtd: atmel_nand: fix the compile error which miss label
 "err_ecc_ioremap".
Message-ID: <1346824842-18875-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
 drivers/mtd/nand/atmel_nand.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 6a5a35b..9144557 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -1399,7 +1399,7 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 	if (pdev->dev.of_node) {
 		res = atmel_of_init_port(host, pdev->dev.of_node);
 		if (res)
-			goto err_nand_ioremap;
+			goto err_ecc_ioremap;
 	} else {
 		memcpy(&host->board, pdev->dev.platform_data,
 		       sizeof(struct atmel_nand_data));
@@ -1560,6 +1560,7 @@ err_no_card:
 	platform_set_drvdata(pdev, NULL);
 	if (host->dma_chan)
 		dma_release_channel(host->dma_chan);
+err_ecc_ioremap:
 	iounmap(host->io_base);
 err_nand_ioremap:
 	kfree(host);
-- 
1.7.9.5
