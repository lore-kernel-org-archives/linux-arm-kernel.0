From: fabio.porcedda@gmail.com (Fabio Porcedda)
Date: Fri,  5 Oct 2012 12:16:08 +0200
Subject: [RFC PATCH v3 3/4] watchdog: orion_wdt: litte cleanup
In-Reply-To: <1349432169-13006-1-git-send-email-fabio.porcedda@gmail.com>
References: <1349432169-13006-1-git-send-email-fabio.porcedda@gmail.com>
Message-ID: <1349432169-13006-4-git-send-email-fabio.porcedda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- Move the min_timeout initialization inside the orion_wdt definition.
- Change orion_wdt_of_match_table from __devinitdata to __devinitconst.

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 drivers/watchdog/orion_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 3417f1b..9e09598 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -139,6 +139,7 @@ static const struct watchdog_ops orion_wdt_ops = {
 static struct watchdog_device orion_wdt = {
 	.info = &orion_wdt_info,
 	.ops = &orion_wdt_ops,
+	.min_timeout = 1,
 };
 
 static int __devinit orion_wdt_probe(struct platform_device *pdev)
@@ -161,7 +162,6 @@ static int __devinit orion_wdt_probe(struct platform_device *pdev)
 
 	wdt_max_duration = WDT_MAX_CYCLE_COUNT / wdt_tclk;
 
-	orion_wdt.min_timeout = 1;
 	orion_wdt.max_timeout = wdt_max_duration;
 	orion_wdt.timeout = wdt_max_duration;
 	watchdog_init_timeout(&orion_wdt, heartbeat, pdev->dev.of_node);
@@ -190,7 +190,7 @@ static void orion_wdt_shutdown(struct platform_device *pdev)
 	orion_wdt_stop(&orion_wdt);
 }
 
-static const struct of_device_id orion_wdt_of_match_table[] __devinitdata = {
+static const struct of_device_id orion_wdt_of_match_table[] __devinitconst = {
 	{ .compatible = "marvell,orion-wdt", },
 	{},
 };
-- 
1.7.11.3
