From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sat,  2 May 2015 00:44:37 +0900
Subject: [PATCH 3/3] rtc: mxc: Constify platform_device_id
In-Reply-To: <1430495077-31179-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1430495077-31179-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1430495077-31179-3-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/rtc/rtc-mxc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-mxc.c b/drivers/rtc/rtc-mxc.c
index 09d422b9f7f7..5fc292c2dfdf 100644
--- a/drivers/rtc/rtc-mxc.c
+++ b/drivers/rtc/rtc-mxc.c
@@ -84,7 +84,7 @@ struct rtc_plat_data {
 	enum imx_rtc_type devtype;
 };
 
-static struct platform_device_id imx_rtc_devtype[] = {
+static const struct platform_device_id imx_rtc_devtype[] = {
 	{
 		.name = "imx1-rtc",
 		.driver_data = IMX1_RTC,
-- 
2.1.4
