From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Tue, 25 Aug 2015 00:26:30 +0530
Subject: [PATCH-v2 1/5] mfd: 88pm800: Fix tabbing issue
In-Reply-To: <1440442594-3102-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1440442594-3102-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1440442594-3102-3-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Driver had coding style issues where spaces were used instead
of tabs. This patch fixes them all.

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 drivers/mfd/88pm800.c | 125 ++++++++++++++++++++++++--------------------------
 1 file changed, 61 insertions(+), 64 deletions(-)

diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
index f104a32..c4e097d 100644
--- a/drivers/mfd/88pm800.c
+++ b/drivers/mfd/88pm800.c
@@ -30,55 +30,55 @@
 #include <linux/of_device.h>
 
 /* Interrupt Registers */
-#define PM800_INT_STATUS1		(0x05)
+#define PM800_INT_STATUS1		0x05
 #define PM800_ONKEY_INT_STS1		(1 << 0)
 #define PM800_EXTON_INT_STS1		(1 << 1)
-#define PM800_CHG_INT_STS1			(1 << 2)
-#define PM800_BAT_INT_STS1			(1 << 3)
-#define PM800_RTC_INT_STS1			(1 << 4)
+#define PM800_CHG_INT_STS1		(1 << 2)
+#define PM800_BAT_INT_STS1		(1 << 3)
+#define PM800_RTC_INT_STS1		(1 << 4)
 #define PM800_CLASSD_OC_INT_STS1	(1 << 5)
 
-#define PM800_INT_STATUS2		(0x06)
+#define PM800_INT_STATUS2		0x06
 #define PM800_VBAT_INT_STS2		(1 << 0)
 #define PM800_VSYS_INT_STS2		(1 << 1)
 #define PM800_VCHG_INT_STS2		(1 << 2)
 #define PM800_TINT_INT_STS2		(1 << 3)
-#define PM800_GPADC0_INT_STS2	(1 << 4)
+#define PM800_GPADC0_INT_STS2		(1 << 4)
 #define PM800_TBAT_INT_STS2		(1 << 5)
-#define PM800_GPADC2_INT_STS2	(1 << 6)
-#define PM800_GPADC3_INT_STS2	(1 << 7)
+#define PM800_GPADC2_INT_STS2		(1 << 6)
+#define PM800_GPADC3_INT_STS2		(1 << 7)
 
-#define PM800_INT_STATUS3		(0x07)
+#define PM800_INT_STATUS3		0x07
 
-#define PM800_INT_STATUS4		(0x08)
+#define PM800_INT_STATUS4		0x08
 #define PM800_GPIO0_INT_STS4		(1 << 0)
 #define PM800_GPIO1_INT_STS4		(1 << 1)
 #define PM800_GPIO2_INT_STS4		(1 << 2)
 #define PM800_GPIO3_INT_STS4		(1 << 3)
 #define PM800_GPIO4_INT_STS4		(1 << 4)
 
-#define PM800_INT_ENA_1		(0x09)
+#define PM800_INT_ENA_1			0x09
 #define PM800_ONKEY_INT_ENA1		(1 << 0)
 #define PM800_EXTON_INT_ENA1		(1 << 1)
-#define PM800_CHG_INT_ENA1			(1 << 2)
-#define PM800_BAT_INT_ENA1			(1 << 3)
-#define PM800_RTC_INT_ENA1			(1 << 4)
+#define PM800_CHG_INT_ENA1		(1 << 2)
+#define PM800_BAT_INT_ENA1		(1 << 3)
+#define PM800_RTC_INT_ENA1		(1 << 4)
 #define PM800_CLASSD_OC_INT_ENA1	(1 << 5)
 
-#define PM800_INT_ENA_2		(0x0A)
+#define PM800_INT_ENA_2			0x0A
 #define PM800_VBAT_INT_ENA2		(1 << 0)
 #define PM800_VSYS_INT_ENA2		(1 << 1)
 #define PM800_VCHG_INT_ENA2		(1 << 2)
 #define PM800_TINT_INT_ENA2		(1 << 3)
 
-#define PM800_INT_ENA_3		(0x0B)
+#define PM800_INT_ENA_3			0x0B
 #define PM800_GPADC0_INT_ENA3		(1 << 0)
 #define PM800_GPADC1_INT_ENA3		(1 << 1)
 #define PM800_GPADC2_INT_ENA3		(1 << 2)
 #define PM800_GPADC3_INT_ENA3		(1 << 3)
 #define PM800_GPADC4_INT_ENA3		(1 << 4)
 
-#define PM800_INT_ENA_4		(0x0C)
+#define PM800_INT_ENA_4			0x0C
 #define PM800_GPIO0_INT_ENA4		(1 << 0)
 #define PM800_GPIO1_INT_ENA4		(1 << 1)
 #define PM800_GPIO2_INT_ENA4		(1 << 2)
@@ -86,7 +86,7 @@
 #define PM800_GPIO4_INT_ENA4		(1 << 4)
 
 /* number of INT_ENA & INT_STATUS regs */
-#define PM800_INT_REG_NUM			(4)
+#define PM800_INT_REG_NUM		4
 
 /* Interrupt Number in 88PM800 */
 enum {
@@ -114,7 +114,7 @@ enum {
 };
 
 /* PM800: generation identification number */
-#define PM800_CHIP_GEN_ID_NUM	0x3
+#define PM800_CHIP_GEN_ID_NUM		0x3
 
 static const struct i2c_device_id pm80x_id_table[] = {
 	{"88PM800", 0},
@@ -129,47 +129,47 @@ static const struct of_device_id pm80x_of_match_table[] = {
 
 static struct resource rtc_resources[] = {
 	{
-	 .name = "88pm80x-rtc",
-	 .start = PM800_IRQ_RTC,
-	 .end = PM800_IRQ_RTC,
-	 .flags = IORESOURCE_IRQ,
-	 },
+		.name = "88pm80x-rtc",
+		.start = PM800_IRQ_RTC,
+		.end = PM800_IRQ_RTC,
+		.flags = IORESOURCE_IRQ,
+	},
 };
 
 static struct mfd_cell rtc_devs[] = {
 	{
-	 .name = "88pm80x-rtc",
-	 .of_compatible = "marvell,88pm80x-rtc",
-	 .num_resources = ARRAY_SIZE(rtc_resources),
-	 .resources = &rtc_resources[0],
-	 .id = -1,
-	 },
+		.name = "88pm80x-rtc",
+		.of_compatible = "marvell,88pm80x-rtc",
+		.num_resources = ARRAY_SIZE(rtc_resources),
+		.resources = &rtc_resources[0],
+		.id = -1,
+	},
 };
 
 static struct resource onkey_resources[] = {
 	{
-	 .name = "88pm80x-onkey",
-	 .start = PM800_IRQ_ONKEY,
-	 .end = PM800_IRQ_ONKEY,
-	 .flags = IORESOURCE_IRQ,
-	 },
+		.name = "88pm80x-onkey",
+		.start = PM800_IRQ_ONKEY,
+		.end = PM800_IRQ_ONKEY,
+		.flags = IORESOURCE_IRQ,
+	},
 };
 
 static const struct mfd_cell onkey_devs[] = {
 	{
-	 .name = "88pm80x-onkey",
-	 .of_compatible = "marvell,88pm80x-onkey",
-	 .num_resources = 1,
-	 .resources = &onkey_resources[0],
-	 .id = -1,
-	 },
+		.name = "88pm80x-onkey",
+		.of_compatible = "marvell,88pm80x-onkey",
+		.num_resources = 1,
+		.resources = &onkey_resources[0],
+		.id = -1,
+	},
 };
 
 static const struct mfd_cell regulator_devs[] = {
 	{
-	 .name = "88pm80x-regulator",
-	 .of_compatible = "marvell,88pm80x-regulator",
-	 .id = -1,
+		.name = "88pm80x-regulator",
+		.of_compatible = "marvell,88pm80x-regulator",
+		.id = -1,
 	},
 };
 
@@ -323,8 +323,8 @@ out:
 static int device_onkey_init(struct pm80x_chip *chip)
 {
 	return mfd_add_devices(chip->dev, 0, &onkey_devs[0],
-			      ARRAY_SIZE(onkey_devs), &onkey_resources[0], 0,
-			      NULL);
+			ARRAY_SIZE(onkey_devs), &onkey_resources[0], 0,
+			NULL);
 }
 
 static int device_rtc_init(struct pm80x_chip *chip)
@@ -335,13 +335,13 @@ static int device_rtc_init(struct pm80x_chip *chip)
 	rtc_devs[0].pdata_size = pdata->rtc ? sizeof(struct pm80x_rtc_pdata) : 0;
 
 	return mfd_add_devices(chip->dev, 0, &rtc_devs[0],
-			      ARRAY_SIZE(rtc_devs), NULL, 0, NULL);
+			ARRAY_SIZE(rtc_devs), NULL, 0, NULL);
 }
 
 static int device_regulator_init(struct pm80x_chip *chip)
 {
 	return mfd_add_devices(chip->dev, 0, &regulator_devs[0],
-			      ARRAY_SIZE(regulator_devs), NULL, 0, NULL);
+			ARRAY_SIZE(regulator_devs), NULL, 0, NULL);
 }
 
 static int device_irq_init_800(struct pm80x_chip *chip)
@@ -358,11 +358,10 @@ static int device_irq_init_800(struct pm80x_chip *chip)
 
 	/*
 	 * irq_clr_on_wr defines the way of clearing interrupt by
-	 * read/write(0/1).  It's read-clear by default.
+	 * read/write(0/1). It's read-clear by default.
 	 */
-	mask =
-	    PM800_WAKEUP2_INV_INT | PM800_WAKEUP2_INT_CLEAR |
-	    PM800_WAKEUP2_INT_MASK;
+	mask = PM800_WAKEUP2_INV_INT | PM800_WAKEUP2_INT_CLEAR |
+		PM800_WAKEUP2_INT_MASK;
 
 	irq_clr_mode = pdata->irq_clr_method == PM800_IRQ_CLR_ON_WRITE ?
 		PM800_WAKEUP2_INT_WRITE_CLEAR : PM800_WAKEUP2_INT_READ_CLEAR;
@@ -371,9 +370,8 @@ static int device_irq_init_800(struct pm80x_chip *chip)
 	if (ret < 0)
 		goto out;
 
-	ret =
-	    regmap_add_irq_chip(chip->regmap, chip->irq, flags, -1,
-				chip->regmap_irq_chip, &chip->irq_data);
+	ret = regmap_add_irq_chip(chip->regmap, chip->irq, flags, -1,
+			chip->regmap_irq_chip, &chip->irq_data);
 
 out:
 	return ret;
@@ -409,18 +407,18 @@ static int pm800_pages_init(struct pm80x_chip *chip)
 
 	/* PM800 block power page */
 	subchip->power_page = i2c_new_dummy(client->adapter,
-					    subchip->power_page_addr);
+					subchip->power_page_addr);
 	if (subchip->power_page == NULL) {
 		ret = -ENODEV;
 		goto out;
 	}
 
 	subchip->regmap_power = devm_regmap_init_i2c(subchip->power_page,
-						     &pm80x_regmap_config);
+				&pm80x_regmap_config);
 	if (IS_ERR(subchip->regmap_power)) {
 		ret = PTR_ERR(subchip->regmap_power);
 		dev_err(chip->dev,
-			"Failed to allocate regmap_power: %d\n", ret);
+				"Failed to allocate regmap_power: %d\n", ret);
 		goto out;
 	}
 
@@ -428,18 +426,18 @@ static int pm800_pages_init(struct pm80x_chip *chip)
 
 	/* PM800 block GPADC */
 	subchip->gpadc_page = i2c_new_dummy(client->adapter,
-					    subchip->gpadc_page_addr);
+				subchip->gpadc_page_addr);
 	if (subchip->gpadc_page == NULL) {
 		ret = -ENODEV;
 		goto out;
 	}
 
 	subchip->regmap_gpadc = devm_regmap_init_i2c(subchip->gpadc_page,
-						     &pm80x_regmap_config);
+				&pm80x_regmap_config);
 	if (IS_ERR(subchip->regmap_gpadc)) {
 		ret = PTR_ERR(subchip->regmap_gpadc);
 		dev_err(chip->dev,
-			"Failed to allocate regmap_gpadc: %d\n", ret);
+				"Failed to allocate regmap_gpadc: %d\n", ret);
 		goto out;
 	}
 	i2c_set_clientdata(subchip->gpadc_page, chip);
@@ -620,8 +618,7 @@ static int pm800_probe(struct i2c_client *client,
 	chip = i2c_get_clientdata(client);
 
 	/* init subchip for PM800 */
-	subchip =
-	    devm_kzalloc(&client->dev, sizeof(struct pm80x_subchip),
+	subchip = devm_kzalloc(&client->dev, sizeof(struct pm80x_subchip),
 			 GFP_KERNEL);
 	if (!subchip) {
 		ret = -ENOMEM;
@@ -684,7 +681,7 @@ static struct i2c_driver pm800_driver = {
 		.owner = THIS_MODULE,
 		.pm = &pm80x_pm_ops,
 		.of_match_table	= pm80x_of_match_table,
-		},
+	},
 	.probe = pm800_probe,
 	.remove = pm800_remove,
 	.id_table = pm80x_id_table,
-- 
1.9.1
