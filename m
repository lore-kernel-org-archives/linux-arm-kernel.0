From: fabio.porcedda@gmail.com (Fabio Porcedda)
Date: Mon, 19 Nov 2012 15:10:42 +0100
Subject: [PATCH v5 7/8] watchdog: orion_wdt: move the min_timeout
 initialization
In-Reply-To: <1353334243-16703-1-git-send-email-fabio.porcedda@gmail.com>
References: <1353334243-16703-1-git-send-email-fabio.porcedda@gmail.com>
Message-ID: <1353334243-16703-8-git-send-email-fabio.porcedda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the min_timeout initialization inside the orion_wdt definition.

Only compile tested.

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
---
 drivers/watchdog/orion_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 446a3e9..3b4e228 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -140,6 +140,7 @@ static const struct watchdog_ops orion_wdt_ops = {
 static struct watchdog_device orion_wdt = {
 	.info = &orion_wdt_info,
 	.ops = &orion_wdt_ops,
+	.min_timeout = 1,
 };
 
 static int __devinit orion_wdt_probe(struct platform_device *pdev)
@@ -162,7 +163,6 @@ static int __devinit orion_wdt_probe(struct platform_device *pdev)
 
 	wdt_max_duration = WDT_MAX_CYCLE_COUNT / wdt_tclk;
 
-	orion_wdt.min_timeout = 1;
 	orion_wdt.timeout = wdt_max_duration;
 	orion_wdt.max_timeout = wdt_max_duration;
 	watchdog_init_timeout(&orion_wdt, heartbeat, pdev->dev.of_node);
-- 
1.8.0
