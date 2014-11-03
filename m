From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon,  3 Nov 2014 19:12:06 +0100
Subject: [PATCH v3 3/4] regulator: gpio: Use gpio_is_valid
In-Reply-To: <1415038327-32616-1-git-send-email-mpa@pengutronix.de>
References: <1415038327-32616-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1415038327-32616-4-git-send-email-mpa@pengutronix.de>
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
2.1.1
