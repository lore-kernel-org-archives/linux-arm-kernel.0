From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Thu, 16 Jul 2015 23:46:54 +0530
Subject: [PATCH 1/5] regulator: 88pm800: Fix indentation of assignments of
 data structures
In-Reply-To: <1437070618-21330-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1437070618-21330-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1437070618-21330-2-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes code more clean from readability point of view,
make all assignments of LDO, BUCk and regulator_ops structure
at the same indentation.

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 drivers/regulator/88pm800.c | 68 ++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/regulator/88pm800.c b/drivers/regulator/88pm800.c
index 832932b..11f7ab2 100644
--- a/drivers/regulator/88pm800.c
+++ b/drivers/regulator/88pm800.c
@@ -95,11 +95,11 @@ struct pm800_regulators {
 #define PM800_BUCK(vreg, ereg, ebit, amax, volt_ranges, n_volt)		\
 {									\
 	.desc	= {							\
-		.name	= #vreg,					\
-		.ops	= &pm800_volt_range_ops,			\
-		.type	= REGULATOR_VOLTAGE,				\
-		.id	= PM800_ID_##vreg,				\
-		.owner	= THIS_MODULE,					\
+		.name			= #vreg,			\
+		.ops			= &pm800_volt_range_ops,	\
+		.type			= REGULATOR_VOLTAGE,		\
+		.id			= PM800_ID_##vreg,		\
+		.owner			= THIS_MODULE,			\
 		.n_voltages		= n_volt,			\
 		.linear_ranges		= volt_ranges,			\
 		.n_linear_ranges	= ARRAY_SIZE(volt_ranges),	\
@@ -108,7 +108,7 @@ struct pm800_regulators {
 		.enable_reg		= PM800_##ereg,			\
 		.enable_mask		= 1 << (ebit),			\
 	},								\
-	.max_ua		= (amax),					\
+	.max_ua	= (amax),						\
 }
 
 /*
@@ -123,19 +123,19 @@ struct pm800_regulators {
 #define PM800_LDO(vreg, ereg, ebit, amax, ldo_volt_table)		\
 {									\
 	.desc	= {							\
-		.name	= #vreg,					\
-		.ops	= &pm800_volt_table_ops,			\
-		.type	= REGULATOR_VOLTAGE,				\
-		.id	= PM800_ID_##vreg,				\
-		.owner	= THIS_MODULE,					\
-		.n_voltages = ARRAY_SIZE(ldo_volt_table),		\
-		.vsel_reg	= PM800_##vreg##_VOUT,			\
-		.vsel_mask	= 0x1f,					\
-		.enable_reg	= PM800_##ereg,				\
-		.enable_mask	= 1 << (ebit),				\
-		.volt_table	= ldo_volt_table,			\
+		.name			= #vreg,			\
+		.ops			= &pm800_volt_table_ops,	\
+		.type			= REGULATOR_VOLTAGE,		\
+		.id			= PM800_ID_##vreg,		\
+		.owner			= THIS_MODULE,			\
+		.n_voltages		= ARRAY_SIZE(ldo_volt_table),	\
+		.vsel_reg		= PM800_##vreg##_VOUT,		\
+		.vsel_mask		= 0x1f,				\
+		.enable_reg		= PM800_##ereg,			\
+		.enable_mask		= 1 << (ebit),			\
+		.volt_table		= ldo_volt_table,		\
 	},								\
-	.max_ua		= (amax),					\
+	.max_ua	= (amax),						\
 }
 
 /* Ranges are sorted in ascending order. */
@@ -178,25 +178,25 @@ static int pm800_get_current_limit(struct regulator_dev *rdev)
 }
 
 static struct regulator_ops pm800_volt_range_ops = {
-	.list_voltage = regulator_list_voltage_linear_range,
-	.map_voltage = regulator_map_voltage_linear_range,
-	.set_voltage_sel = regulator_set_voltage_sel_regmap,
-	.get_voltage_sel = regulator_get_voltage_sel_regmap,
-	.enable = regulator_enable_regmap,
-	.disable = regulator_disable_regmap,
-	.is_enabled = regulator_is_enabled_regmap,
-	.get_current_limit = pm800_get_current_limit,
+	.list_voltage		= regulator_list_voltage_linear_range,
+	.map_voltage		= regulator_map_voltage_linear_range,
+	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.is_enabled		= regulator_is_enabled_regmap,
+	.get_current_limit	= pm800_get_current_limit,
 };
 
 static struct regulator_ops pm800_volt_table_ops = {
-	.list_voltage = regulator_list_voltage_table,
-	.map_voltage = regulator_map_voltage_iterate,
-	.set_voltage_sel = regulator_set_voltage_sel_regmap,
-	.get_voltage_sel = regulator_get_voltage_sel_regmap,
-	.enable = regulator_enable_regmap,
-	.disable = regulator_disable_regmap,
-	.is_enabled = regulator_is_enabled_regmap,
-	.get_current_limit = pm800_get_current_limit,
+	.list_voltage		= regulator_list_voltage_table,
+	.map_voltage		= regulator_map_voltage_iterate,
+	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.is_enabled		= regulator_is_enabled_regmap,
+	.get_current_limit	= pm800_get_current_limit,
 };
 
 /* The array is indexed by id(PM800_ID_XXX) */
-- 
1.9.1
