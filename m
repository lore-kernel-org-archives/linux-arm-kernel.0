From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon,  6 Oct 2014 22:17:15 +0200
Subject: [PATCH 5/5] regulator: Remove unnecessary ena_gpio initializations
In-Reply-To: <1412626635-7404-1-git-send-email-mpa@pengutronix.de>
References: <1412626635-7404-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1412626635-7404-6-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is not necessary to setup config.ena_gpio with -EINVAL or similar.
This patch removes these unnecessary initializations.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/regulator/pfuze100-regulator.c | 1 -
 drivers/regulator/s5m8767.c            | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
index c879dff597ee..d7455ee309bf 100644
--- a/drivers/regulator/pfuze100-regulator.c
+++ b/drivers/regulator/pfuze100-regulator.c
@@ -509,7 +509,6 @@ static int pfuze100_regulator_probe(struct i2c_client *client,
 		config.init_data = init_data;
 		config.driver_data = pfuze_chip;
 		config.of_node = match_of_node(i);
-		config.ena_gpio = -EINVAL;
 
 		pfuze_chip->regulators[i] =
 			devm_regulator_register(&client->dev, desc, &config);
diff --git a/drivers/regulator/s5m8767.c b/drivers/regulator/s5m8767.c
index d258e6613831..2c7817f12516 100644
--- a/drivers/regulator/s5m8767.c
+++ b/drivers/regulator/s5m8767.c
@@ -949,8 +949,6 @@ static int s5m8767_pmic_probe(struct platform_device *pdev)
 		config.driver_data = s5m8767;
 		config.regmap = iodev->regmap_pmic;
 		config.of_node = pdata->regulators[i].reg_node;
-		config.ena_gpio = -EINVAL;
-		config.ena_gpio_flags = 0;
 		if (gpio_is_valid(pdata->regulators[i].ext_control_gpio))
 			s5m8767_regulator_config_ext_control(s5m8767,
 					&pdata->regulators[i], &config);
-- 
2.1.0
