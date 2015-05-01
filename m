From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sat,  2 May 2015 00:44:36 +0900
Subject: [PATCH 2/3] rtc: hid-sensor-time: Constify platform_device_id
In-Reply-To: <1430495077-31179-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1430495077-31179-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1430495077-31179-2-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/rtc/rtc-hid-sensor-time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-hid-sensor-time.c b/drivers/rtc/rtc-hid-sensor-time.c
index af4f85a66b39..c398f74234c6 100644
--- a/drivers/rtc/rtc-hid-sensor-time.c
+++ b/drivers/rtc/rtc-hid-sensor-time.c
@@ -318,7 +318,7 @@ static int hid_time_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_device_id hid_time_ids[] = {
+static const struct platform_device_id hid_time_ids[] = {
 	{
 		/* Format: HID-SENSOR-usage_id_in_hex_lowercase */
 		.name = "HID-SENSOR-2000a0",
-- 
2.1.4
