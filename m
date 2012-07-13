From: y@pengutronix.de (y at pengutronix.de)
Date: Fri, 13 Jul 2012 14:32:08 +0200
Subject: [PATCH 05/11] gpio/gpio-omap.c: add a const qualifier
In-Reply-To: <1342182734-321-1-git-send-email-y>
References: <1342182734-321-1-git-send-email-y>
Message-ID: <1342182734-321-7-git-send-email-y>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

This prepares of_device_id.data becoming const. Without this change
the following warning would occur:

	drivers/gpio/gpio-omap.c: In function 'omap_gpio_probe':
	drivers/gpio/gpio-omap.c:1060: warning: assignment discards qualifiers from pointer target type

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Linus Walleij <linus.walleij@stericsson.com>
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
