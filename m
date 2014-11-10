From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 10 Nov 2014 12:32:31 +0000
Subject: [PATCH] mfd: tps65090: Fix bonkers indenting strategy
Message-ID: <1415622751-23396-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

First spotted pointless (incorrect) indent of 'if (ret)', then double
indentations of a struct attribute 'mask'.  Decided to go through the
whole file and make amendments instead and this is the result.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/tps65090.c | 62 +++++++++++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/mfd/tps65090.c b/drivers/mfd/tps65090.c
index 1c3e6e2..14b62e1 100644
--- a/drivers/mfd/tps65090.c
+++ b/drivers/mfd/tps65090.c
@@ -76,58 +76,58 @@ static struct mfd_cell tps65090s[] = {
 static const struct regmap_irq tps65090_irqs[] = {
 	/* INT1 IRQs*/
 	[TPS65090_IRQ_VAC_STATUS_CHANGE] = {
-			.mask = TPS65090_INT1_MASK_VAC_STATUS_CHANGE,
+		.mask = TPS65090_INT1_MASK_VAC_STATUS_CHANGE,
 	},
 	[TPS65090_IRQ_VSYS_STATUS_CHANGE] = {
-			.mask = TPS65090_INT1_MASK_VSYS_STATUS_CHANGE,
+		.mask = TPS65090_INT1_MASK_VSYS_STATUS_CHANGE,
 	},
 	[TPS65090_IRQ_BAT_STATUS_CHANGE] = {
-			.mask = TPS65090_INT1_MASK_BAT_STATUS_CHANGE,
+		.mask = TPS65090_INT1_MASK_BAT_STATUS_CHANGE,
 	},
 	[TPS65090_IRQ_CHARGING_STATUS_CHANGE] = {
-			.mask = TPS65090_INT1_MASK_CHARGING_STATUS_CHANGE,
+		.mask = TPS65090_INT1_MASK_CHARGING_STATUS_CHANGE,
 	},
 	[TPS65090_IRQ_CHARGING_COMPLETE] = {
-			.mask = TPS65090_INT1_MASK_CHARGING_COMPLETE,
+		.mask = TPS65090_INT1_MASK_CHARGING_COMPLETE,
 	},
 	[TPS65090_IRQ_OVERLOAD_DCDC1] = {
-			.mask = TPS65090_INT1_MASK_OVERLOAD_DCDC1,
+		.mask = TPS65090_INT1_MASK_OVERLOAD_DCDC1,
 	},
 	[TPS65090_IRQ_OVERLOAD_DCDC2] = {
-			.mask = TPS65090_INT1_MASK_OVERLOAD_DCDC2,
+		.mask = TPS65090_INT1_MASK_OVERLOAD_DCDC2,
 	},
 	/* INT2 IRQs*/
 	[TPS65090_IRQ_OVERLOAD_DCDC3] = {
-			.reg_offset = 1,
-			.mask = TPS65090_INT2_MASK_OVERLOAD_DCDC3,
+		.reg_offset = 1,
+		.mask = TPS65090_INT2_MASK_OVERLOAD_DCDC3,
 	},
 	[TPS65090_IRQ_OVERLOAD_FET1] = {
-			.reg_offset = 1,
-			.mask = TPS65090_INT2_MASK_OVERLOAD_FET1,
+		.reg_offset = 1,
+		.mask = TPS65090_INT2_MASK_OVERLOAD_FET1,
 	},
 	[TPS65090_IRQ_OVERLOAD_FET2] = {
-			.reg_offset = 1,
-			.mask = TPS65090_INT2_MASK_OVERLOAD_FET2,
+		.reg_offset = 1,
+		.mask = TPS65090_INT2_MASK_OVERLOAD_FET2,
 	},
 	[TPS65090_IRQ_OVERLOAD_FET3] = {
-			.reg_offset = 1,
-			.mask = TPS65090_INT2_MASK_OVERLOAD_FET3,
+		.reg_offset = 1,
+		.mask = TPS65090_INT2_MASK_OVERLOAD_FET3,
 	},
 	[TPS65090_IRQ_OVERLOAD_FET4] = {
-			.reg_offset = 1,
-			.mask = TPS65090_INT2_MASK_OVERLOAD_FET4,
+		.reg_offset = 1,
+		.mask = TPS65090_INT2_MASK_OVERLOAD_FET4,
 	},
 	[TPS65090_IRQ_OVERLOAD_FET5] = {
-			.reg_offset = 1,
-			.mask = TPS65090_INT2_MASK_OVERLOAD_FET5,
+		.reg_offset = 1,
+		.mask = TPS65090_INT2_MASK_OVERLOAD_FET5,
 	},
 	[TPS65090_IRQ_OVERLOAD_FET6] = {
-			.reg_offset = 1,
-			.mask = TPS65090_INT2_MASK_OVERLOAD_FET6,
+		.reg_offset = 1,
+		.mask = TPS65090_INT2_MASK_OVERLOAD_FET6,
 	},
 	[TPS65090_IRQ_OVERLOAD_FET7] = {
-			.reg_offset = 1,
-			.mask = TPS65090_INT2_MASK_OVERLOAD_FET7,
+		.reg_offset = 1,
+		.mask = TPS65090_INT2_MASK_OVERLOAD_FET7,
 	},
 };
 
@@ -176,7 +176,7 @@ MODULE_DEVICE_TABLE(of, tps65090_of_match);
 #endif
 
 static int tps65090_i2c_probe(struct i2c_client *client,
-					const struct i2c_device_id *id)
+			      const struct i2c_device_id *id)
 {
 	struct tps65090_platform_data *pdata = dev_get_platdata(&client->dev);
 	int irq_base = 0;
@@ -210,11 +210,11 @@ static int tps65090_i2c_probe(struct i2c_client *client,
 
 	if (client->irq) {
 		ret = regmap_add_irq_chip(tps65090->rmap, client->irq,
-			IRQF_ONESHOT | IRQF_TRIGGER_LOW, irq_base,
-			&tps65090_irq_chip, &tps65090->irq_data);
-			if (ret) {
-				dev_err(&client->dev,
-					"IRQ init failed with err: %d\n", ret);
+					  IRQF_ONESHOT | IRQF_TRIGGER_LOW, irq_base,
+					  &tps65090_irq_chip, &tps65090->irq_data);
+		if (ret) {
+			dev_err(&client->dev,
+				"IRQ init failed with err: %d\n", ret);
 			return ret;
 		}
 	} else {
@@ -223,8 +223,8 @@ static int tps65090_i2c_probe(struct i2c_client *client,
 	}
 
 	ret = mfd_add_devices(tps65090->dev, -1, tps65090s,
-		ARRAY_SIZE(tps65090s), NULL,
-		0, regmap_irq_get_domain(tps65090->irq_data));
+			      ARRAY_SIZE(tps65090s), NULL,
+			      0, regmap_irq_get_domain(tps65090->irq_data));
 	if (ret) {
 		dev_err(&client->dev, "add mfd devices failed with err: %d\n",
 			ret);
-- 
1.9.1
