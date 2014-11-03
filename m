From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon,  3 Nov 2014 19:12:05 +0100
Subject: [PATCH v3 2/4] regulator: fixed: Use gpio_is_valid
In-Reply-To: <1415038327-32616-1-git-send-email-mpa@pengutronix.de>
References: <1415038327-32616-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1415038327-32616-3-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use gpio_is_valid instead of an explicit comparison with 0.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/regulator/fixed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index 17f6a7d331f8..709fba19e596 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -157,7 +157,7 @@ static int reg_fixed_voltage_probe(struct platform_device *pdev)
 
 	drvdata->desc.fixed_uV = config->microvolts;
 
-	if (config->gpio >= 0) {
+	if (gpio_is_valid(config->gpio)) {
 		cfg.ena_gpio = config->gpio;
 		if (pdev->dev.of_node)
 			cfg.ena_gpio_initialized = true;
-- 
2.1.1
