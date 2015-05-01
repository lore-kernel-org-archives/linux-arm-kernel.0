From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sat,  2 May 2015 00:38:38 +0900
Subject: [PATCH 1/4] video: backlight: da9052: Constify platform_device_id
Message-ID: <1430494721-30793-1-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/video/backlight/da9052_bl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/da9052_bl.c b/drivers/video/backlight/da9052_bl.c
index b1943e7735a1..fd2be417aa64 100644
--- a/drivers/video/backlight/da9052_bl.c
+++ b/drivers/video/backlight/da9052_bl.c
@@ -152,7 +152,7 @@ static int da9052_backlight_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_device_id da9052_wled_ids[] = {
+static const struct platform_device_id da9052_wled_ids[] = {
 	{
 		.name		= "da9052-wled1",
 		.driver_data	= DA9052_TYPE_WLED1,
-- 
2.1.4
