From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed,  8 Oct 2014 15:47:07 +0200
Subject: [PATCH v2 3/4] regulator: fixed: Use gpio_is_valid
In-Reply-To: <1412776028-15655-1-git-send-email-mpa@pengutronix.de>
References: <1412776028-15655-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1412776028-15655-4-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use gpio_is_valid instead of an explicit comparison with 0.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/regulator/fixed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index 441a3e90e266..696f53cc1927 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -157,7 +157,7 @@ static int reg_fixed_voltage_probe(struct platform_device *pdev)
 
 	drvdata->desc.fixed_uV = config->microvolts;
 
-	if (config->gpio >= 0) {
+	if (gpio_is_valid(config->gpio)) {
 		cfg.ena_gpio = config->gpio;
 		cfg.ena_gpio_initialized = true;
 	}
-- 
2.1.0
