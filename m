From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 23 Jul 2012 11:13:22 +0200
Subject: [PATCH 17/25] watchdog/mpc8xxx: add a const qualifier
In-Reply-To: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1343034810-3386-18-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

This prepares *of_device_id.data becoming const. Without this change
the following warning would occur:

	drivers/watchdog/mpc8xxx_wdt.c: In function 'mpc8xxx_wdt_probe':
	drivers/watchdog/mpc8xxx_wdt.c:203:11: warning: assignment discards 'const' qualifier from pointer target type [enabled by default]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[ukl: split Arnd's patch by driver and add changelog]
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/watchdog/mpc8xxx_wdt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index 40f7bf1..e6a038a 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -193,7 +193,7 @@ static int __devinit mpc8xxx_wdt_probe(struct platform_device *ofdev)
 	int ret;
 	const struct of_device_id *match;
 	struct device_node *np = ofdev->dev.of_node;
-	struct mpc8xxx_wdt_type *wdt_type;
+	const struct mpc8xxx_wdt_type *wdt_type;
 	u32 freq = fsl_get_sys_freq();
 	bool enabled;
 
-- 
1.7.10.4
