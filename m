From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Apr 2017 13:07:07 +0200
Subject: [PATCH] crypto: stm32 - fix building as a module
Message-ID: <20170427110907.2515229-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The names in the MODULE_DEVICE_TABLE and the actual array don't match:

drivers/crypto/stm32/stm32_crc32.c:309:21: error: 'sti_dt_ids' undeclared here (not in a function); did you mean 'stm32_dt_ids'?

This changes the reference that was evidently copied incorrectly from
another driver.

Fixes: b51dbe90912a ("crypto: stm32 - Support for STM32 CRC32 crypto module")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/crypto/stm32/stm32_crc32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/stm32/stm32_crc32.c b/drivers/crypto/stm32/stm32_crc32.c
index 765282262d44..ec83b1e6bfe8 100644
--- a/drivers/crypto/stm32/stm32_crc32.c
+++ b/drivers/crypto/stm32/stm32_crc32.c
@@ -306,7 +306,7 @@ static const struct of_device_id stm32_dt_ids[] = {
 	{ .compatible = "st,stm32f7-crc", },
 	{},
 };
-MODULE_DEVICE_TABLE(of, sti_dt_ids);
+MODULE_DEVICE_TABLE(of, stm32_dt_ids);
 
 static struct platform_driver stm32_crc_driver = {
 	.probe  = stm32_crc_probe,
-- 
2.9.0
