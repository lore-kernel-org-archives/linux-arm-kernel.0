From: marcus.folkesson@gmail.com (Marcus Folkesson)
Date: Sat, 10 Feb 2018 21:36:23 +0100
Subject: [PATCH 4/4] watchdog: lpc18xx: remove assignment of unused ret-value
In-Reply-To: <20180210203623.17832-1-marcus.folkesson@gmail.com>
References: <20180210203623.17832-1-marcus.folkesson@gmail.com>
Message-ID: <20180210203623.17832-4-marcus.folkesson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/watchdog/lpc18xx_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/lpc18xx_wdt.c b/drivers/watchdog/lpc18xx_wdt.c
index b4221f43cd94..331cadb459ac 100644
--- a/drivers/watchdog/lpc18xx_wdt.c
+++ b/drivers/watchdog/lpc18xx_wdt.c
@@ -265,7 +265,7 @@ static int lpc18xx_wdt_probe(struct platform_device *pdev)
 	lpc18xx_wdt->wdt_dev.parent = dev;
 	watchdog_set_drvdata(&lpc18xx_wdt->wdt_dev, lpc18xx_wdt);
 
-	ret = watchdog_init_timeout(&lpc18xx_wdt->wdt_dev, heartbeat, dev);
+	watchdog_init_timeout(&lpc18xx_wdt->wdt_dev, heartbeat, dev);
 
 	__lpc18xx_wdt_set_timeout(lpc18xx_wdt);
 
-- 
2.15.1
