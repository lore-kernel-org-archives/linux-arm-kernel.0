From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Fri, 12 Sep 2014 10:17:42 +0200
Subject: [PATCH RESEND v9 4/5] rtc: max77686: Remove unneded info log
In-Reply-To: <1410509864-10019-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1410509864-10019-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1410509864-10019-5-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If devm_rtc_device_register() fails a dev_err() is already
reported so there is no need to do an additional dev_info().

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/rtc/rtc-max77686.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
index 55396bb..b177ba1 100644
--- a/drivers/rtc/rtc-max77686.c
+++ b/drivers/rtc/rtc-max77686.c
@@ -457,8 +457,6 @@ static int max77686_rtc_probe(struct platform_device *pdev)
 					&max77686_rtc_ops, THIS_MODULE);
 
 	if (IS_ERR(info->rtc_dev)) {
-		dev_info(&pdev->dev, "%s: fail\n", __func__);
-
 		ret = PTR_ERR(info->rtc_dev);
 		dev_err(&pdev->dev, "Failed to register RTC device: %d\n", ret);
 		if (ret == 0)
-- 
2.0.0.rc2
