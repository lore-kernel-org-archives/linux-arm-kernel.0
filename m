From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sat,  2 May 2015 00:44:35 +0900
Subject: [PATCH 1/3] rtc: ab8500: Constify platform_device_id
Message-ID: <1430495077-31179-1-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/rtc/rtc-ab8500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ab8500.c b/drivers/rtc/rtc-ab8500.c
index 6856f0a3a3d5..133d2e2e1a25 100644
--- a/drivers/rtc/rtc-ab8500.c
+++ b/drivers/rtc/rtc-ab8500.c
@@ -442,7 +442,7 @@ static const struct rtc_class_ops ab8540_rtc_ops = {
 	.alarm_irq_enable	= ab8500_rtc_irq_enable,
 };
 
-static struct platform_device_id ab85xx_rtc_ids[] = {
+static const struct platform_device_id ab85xx_rtc_ids[] = {
 	{ "ab8500-rtc", (kernel_ulong_t)&ab8500_rtc_ops, },
 	{ "ab8540-rtc", (kernel_ulong_t)&ab8540_rtc_ops, },
 };
-- 
2.1.4
