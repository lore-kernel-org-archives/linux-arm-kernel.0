From: johan@kernel.org (Johan Hovold)
Date: Thu,  9 Oct 2014 21:06:27 +0200
Subject: [PATCH 05/12] rtc: omap: remove redundant debug message
In-Reply-To: <1412881594-25678-1-git-send-email-johan@kernel.org>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
Message-ID: <1412881594-25678-6-git-send-email-johan@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove redundant debug message.

The corresponding error has already been logged by rtc core.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/rtc/rtc-omap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index d1b5562a148b..e50ffd7063f5 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -485,11 +485,9 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
 
 	rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
 			&omap_rtc_ops, THIS_MODULE);
-	if (IS_ERR(rtc)) {
-		pr_debug("%s: can't register RTC device, err %ld\n",
-			pdev->name, PTR_ERR(rtc));
+	if (IS_ERR(rtc))
 		goto fail0;
-	}
+
 	platform_set_drvdata(pdev, rtc);
 
 	return 0;
-- 
2.0.4
