From: fabio.porcedda@gmail.com (Fabio Porcedda)
Date: Tue,  8 Jan 2013 11:04:15 +0100
Subject: [PATCH v7 6/6] watchdog: orion_wdt: move the min_timeout
 initialization
In-Reply-To: <1357639455-21935-1-git-send-email-fabio.porcedda@gmail.com>
References: <1357639455-21935-1-git-send-email-fabio.porcedda@gmail.com>
Message-ID: <1357639455-21935-7-git-send-email-fabio.porcedda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the min_timeout initialization inside the orion_wdt definition.

Only compile tested.

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Acked-by: Jason Cooper <jason@lakedaemon.net>
---
 drivers/watchdog/orion_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index b7018600..ed05360 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -140,6 +140,7 @@ static const struct watchdog_ops orion_wdt_ops = {
 static struct watchdog_device orion_wdt = {
 	.info = &orion_wdt_info,
 	.ops = &orion_wdt_ops,
+	.min_timeout = 1,
 };
 
 static int orion_wdt_probe(struct platform_device *pdev)
@@ -164,7 +165,6 @@ static int orion_wdt_probe(struct platform_device *pdev)
 
 	wdt_max_duration = WDT_MAX_CYCLE_COUNT / wdt_tclk;
 
-	orion_wdt.min_timeout = 1;
 	orion_wdt.timeout = wdt_max_duration;
 	orion_wdt.max_timeout = wdt_max_duration;
 	watchdog_init_timeout(&orion_wdt, heartbeat, pdev->dev.of_node);
-- 
1.8.0.3
