From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 23 Jul 2012 11:13:12 +0200
Subject: [PATCH 07/25] gpio/gpio-omap.c: add a const qualifier
In-Reply-To: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1343034810-3386-8-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This prepares *of_device_id.data becoming const. Without this change
the following warning would occur:

	drivers/gpio/gpio-omap.c: In function 'omap_gpio_probe':
	drivers/gpio/gpio-omap.c:1060: warning: assignment discards qualifiers from pointer target type

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/gpio/gpio-omap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index c4ed172..019cb7b 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1050,7 +1050,7 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->of_node;
 	const struct of_device_id *match;
-	struct omap_gpio_platform_data *pdata;
+	const struct omap_gpio_platform_data *pdata;
 	struct resource *res;
 	struct gpio_bank *bank;
 	int ret = 0;
-- 
1.7.10.4
