From: gsi@denx.de (Gerhard Sittig)
Date: Sat, 30 Nov 2013 23:51:32 +0100
Subject: [PATCH v6 12/17] mtd: mpc5121_nfc: adjust for OF based clock lookup
In-Reply-To: <1385851897-23475-1-git-send-email-gsi@denx.de>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
Message-ID: <1385851897-23475-13-git-send-email-gsi@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

after device tree based clock lookup became available, the NAND
flash driver need no longer use the previous global "nfc_clk" name,
but should use the "ipg" clock name specific to the OF node

Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: linux-mtd at lists.infradead.org
Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/mtd/nand/mpc5121_nfc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/mpc5121_nfc.c b/drivers/mtd/nand/mpc5121_nfc.c
index 439bc3896418..779e60d12f89 100644
--- a/drivers/mtd/nand/mpc5121_nfc.c
+++ b/drivers/mtd/nand/mpc5121_nfc.c
@@ -731,7 +731,7 @@ static int mpc5121_nfc_probe(struct platform_device *op)
 	of_node_put(rootnode);
 
 	/* Enable NFC clock */
-	clk = devm_clk_get(dev, "nfc_clk");
+	clk = devm_clk_get(dev, "ipg");
 	if (IS_ERR(clk)) {
 		dev_err(dev, "Unable to acquire NFC clock!\n");
 		retval = PTR_ERR(clk);
-- 
1.7.10.4
