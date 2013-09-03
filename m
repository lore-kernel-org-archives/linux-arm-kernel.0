From: josh.wu@atmel.com (Josh Wu)
Date: Tue, 3 Sep 2013 17:20:28 +0800
Subject: [PATCH 2/2] mtd: atmel_nand: add MODULE_DEVICE_TABLE for nfc driver
In-Reply-To: <1378200028-15415-1-git-send-email-josh.wu@atmel.com>
References: <1378200028-15415-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1378200028-15415-2-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch also add a const keyword for the of_device_id of nfc.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
 drivers/mtd/nand/atmel_nand.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 1ca0724..ea5b185 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -2243,10 +2243,11 @@ static int atmel_nand_nfc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id atmel_nand_nfc_match[] = {
+static const struct of_device_id atmel_nand_nfc_match[] = {
 	{ .compatible = "atmel,sama5d3-nfc" },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, atmel_nand_nfc_match);
 
 static struct platform_driver atmel_nand_nfc_driver = {
 	.driver = {
-- 
1.7.9.5
