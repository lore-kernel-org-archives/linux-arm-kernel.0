From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Fri, 24 Mar 2017 18:05:03 -0600
Subject: [PATCH 5/7] usb: dwc3: omap: change goto labels in this file to
 meaningful names
In-Reply-To: <cover.1490387086.git.shuahkh@osg.samsung.com>
References: <cover.1490387086.git.shuahkh@osg.samsung.com>
Message-ID: <e208886be14a70faad7a3355f564a6aaa3591c22.1490387086.git.shuahkh@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change goto labels in this file to meaningful names.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 drivers/usb/dwc3/dwc3-omap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 55b12a9..ca0075a 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -503,7 +503,7 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
 		dev_err(dev, "get_sync failed with err %d\n", ret);
-		goto err1;
+		goto runtime_disable;
 	}
 
 	dwc3_omap_map_offset(omap);
@@ -537,7 +537,7 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 
 put_sync:
 	pm_runtime_put_sync(dev);
-err1:
+runtime_disable:
 	pm_runtime_disable(dev);
 
 	return ret;
-- 
2.7.4
