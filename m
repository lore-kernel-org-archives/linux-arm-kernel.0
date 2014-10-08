From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed,  8 Oct 2014 15:47:08 +0200
Subject: [PATCH v2 4/4] regulator: gpio: Use gpio_is_valid
In-Reply-To: <1412776028-15655-1-git-send-email-mpa@pengutronix.de>
References: <1412776028-15655-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1412776028-15655-5-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use gpio_is_valid instead of an explicit comparison with 0.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/regulator/gpio-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index 5da0125fac6a..86546c1c32c4 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -322,7 +322,7 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 	cfg.driver_data = drvdata;
 	cfg.of_node = np;
 
-	if (config->enable_gpio >= 0) {
+	if (gpio_is_valid(config->enable_gpio)) {
 		cfg.ena_gpio = config->enable_gpio;
 		cfg.ena_gpio_initialized = true;
 	}
-- 
2.1.0
