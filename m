From: nizamhaider786@gmail.com (Nizam Haider)
Date: Sat, 14 Nov 2015 01:51:29 +0530
Subject: [PATCH] Rtc: rtc-gemini.c: Remove unnecessary platform_set_drvdata()
Message-ID: <1447446089-2346-1-git-send-email-nizamhaider786@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver core clears the driver data to NULL after device_release
or on probe failure

Signed-off-by: Nizam Haider <nijamh@cdac.in>
---
 drivers/rtc/rtc-gemini.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/rtc-gemini.c b/drivers/rtc/rtc-gemini.c
index e841846..f46b6d4 100644
--- a/drivers/rtc/rtc-gemini.c
+++ b/drivers/rtc/rtc-gemini.c
@@ -156,7 +156,6 @@ static int gemini_rtc_remove(struct platform_device *pdev)
 	struct gemini_rtc *rtc = platform_get_drvdata(pdev);
 
 	rtc_device_unregister(rtc->rtc_dev);
-	platform_set_drvdata(pdev, NULL);
 
 	return 0;
 }
-- 
1.8.1.4
