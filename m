From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 12 Jul 2012 11:57:49 +0200
Subject: [PATCH 3/7] rtc/mc13xxx: use MODULE_DEVICE_TABLE instead of
 MODULE_ALIAS
In-Reply-To: <1342087073-3892-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1342087073-3892-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1342087073-3892-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows automatic driver loading for all supported device types.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: rtc-linux at googlegroups.com
---
 drivers/rtc/rtc-mc13xxx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-mc13xxx.c b/drivers/rtc/rtc-mc13xxx.c
index 546f685..0ce0602 100644
--- a/drivers/rtc/rtc-mc13xxx.c
+++ b/drivers/rtc/rtc-mc13xxx.c
@@ -405,8 +405,9 @@ static const struct platform_device_id mc13xxx_rtc_idtable[] = {
 	}, {
 		.name = "mc13892-rtc",
 	},
-	{ }
+	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(platform, mc13xxx_rtc_idtable);
 
 static struct platform_driver mc13xxx_rtc_driver = {
 	.id_table = mc13xxx_rtc_idtable,
@@ -432,4 +433,3 @@ module_exit(mc13xxx_rtc_exit);
 MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
 MODULE_DESCRIPTION("RTC driver for Freescale MC13XXX PMIC");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:" DRIVER_NAME);
-- 
1.7.10.4
