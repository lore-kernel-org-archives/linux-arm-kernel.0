From: balbi@ti.com (Felipe Balbi)
Date: Mon, 29 Jun 2015 12:51:49 -0500
Subject: [PATCH] watchdog: omap: fix build error
Message-ID: <1435600310-5511-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix reference to unexistent variable in omap_wdt_probe()
caused by commit 387ee4d26e5f (watchdog: omap_wdt:
early_enable module parameter)

Reported-by: Mark Brown <broonie@kernel.org>
Fixes: 387ee4d26e5f (watchdog: omap_wdt: early_enable module parameter)
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/watchdog/omap_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 21ca96ab2a90..de911c7e477c 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -285,7 +285,7 @@ static int omap_wdt_probe(struct platform_device *pdev)
 	pm_runtime_put_sync(wdev->dev);
 
 	if (early_enable)
-		omap_wdt_start(omap_wdt);
+		omap_wdt_start(&wdev->wdog);
 
 	return 0;
 }
-- 
2.4.4
