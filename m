From: jhovold@gmail.com (Johan Hovold)
Date: Thu, 23 May 2013 10:38:51 +0200
Subject: [PATCH v3 1/5] rtc-at91rm9200: add match-table compile guard
In-Reply-To: <1369298335-24597-1-git-send-email-jhovold@gmail.com>
References: <1364983415-20298-1-git-send-email-jhovold@gmail.com>
 <1369298335-24597-1-git-send-email-jhovold@gmail.com>
Message-ID: <1369298335-24597-2-git-send-email-jhovold@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing match-table compile guard.

Signed-off-by: Johan Hovold <jhovold@gmail.com>
---
 drivers/rtc/rtc-at91rm9200.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
index 0eab77b..eeeb73f 100644
--- a/drivers/rtc/rtc-at91rm9200.c
+++ b/drivers/rtc/rtc-at91rm9200.c
@@ -383,11 +383,13 @@ static int at91_rtc_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(at91_rtc_pm_ops, at91_rtc_suspend, at91_rtc_resume);
 
+#ifdef CONFIG_OF
 static const struct of_device_id at91_rtc_dt_ids[] = {
 	{ .compatible = "atmel,at91rm9200-rtc" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, at91_rtc_dt_ids);
+#endif
 
 static struct platform_driver at91_rtc_driver = {
 	.remove		= __exit_p(at91_rtc_remove),
-- 
1.8.2.1
