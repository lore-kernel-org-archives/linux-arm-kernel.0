From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Tue, 25 Apr 2017 14:35:42 +0000
Subject: [PATCH -next] crypto: stm32 - Fix OF module alias information
Message-ID: <20170425143542.1069-1-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyongjun1@huawei.com>

The module alias information passed to MODULE_DEVICE_TABLE()
should use stm32_dt_ids instead of undefined sti_dt_ids.

Fixes: b51dbe90912a ("crypto: stm32 - Support for STM32 CRC32 crypto module")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/crypto/stm32/stm32_crc32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/stm32/stm32_crc32.c b/drivers/crypto/stm32/stm32_crc32.c
index 7652822..ec83b1e 100644
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
