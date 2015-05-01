From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sat,  2 May 2015 00:59:45 +0900
Subject: [PATCH] ARM: plat-samsung: Constify platform_device_id
Message-ID: <1430495985-32265-1-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 arch/arm/plat-samsung/adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/plat-samsung/adc.c b/arch/arm/plat-samsung/adc.c
index e2be70df06c6..8a2e07c9b5fe 100644
--- a/arch/arm/plat-samsung/adc.c
+++ b/arch/arm/plat-samsung/adc.c
@@ -475,7 +475,7 @@ static int s3c_adc_resume(struct device *dev)
 #define s3c_adc_resume NULL
 #endif
 
-static struct platform_device_id s3c_adc_driver_ids[] = {
+static const struct platform_device_id s3c_adc_driver_ids[] = {
 	{
 		.name           = "s3c24xx-adc",
 		.driver_data    = TYPE_ADCV1,
-- 
2.1.4
