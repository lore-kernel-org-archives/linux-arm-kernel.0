From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sat,  2 May 2015 00:38:39 +0900
Subject: [PATCH 2/4] video: fbdev: imxfb: Constify platform_device_id
In-Reply-To: <1430494721-30793-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1430494721-30793-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1430494721-30793-2-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/video/fbdev/imxfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index 84d1d29e532c..cee88603efc9 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -170,7 +170,7 @@ struct imxfb_info {
 	struct regulator	*lcd_pwr;
 };
 
-static struct platform_device_id imxfb_devtype[] = {
+static const struct platform_device_id imxfb_devtype[] = {
 	{
 		.name = "imx1-fb",
 		.driver_data = IMX1_FB,
-- 
2.1.4
