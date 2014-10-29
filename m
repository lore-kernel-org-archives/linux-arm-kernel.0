From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 29 Oct 2014 12:14:53 +0100
Subject: [PATCH v6 2/3] regulator: max77802: Remove suspend_enable
In-Reply-To: <1414581294-1315-1-git-send-email-k.kozlowski@samsung.com>
References: <1414581294-1315-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1414581294-1315-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Maxim 77802 PMIC regulators do not have special enable configuration
for suspend. The driver instead enabled them manually which is not a
best way to deal with suspend.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/regulator/max77802.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/regulator/max77802.c b/drivers/regulator/max77802.c
index 5839c4509e1f..b9958d927297 100644
--- a/drivers/regulator/max77802.c
+++ b/drivers/regulator/max77802.c
@@ -295,7 +295,6 @@ static struct regulator_ops max77802_ldo_ops_logic1 = {
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
-	.set_suspend_enable	= max77802_enable,
 	.set_suspend_disable	= max77802_set_suspend_disable,
 	.set_suspend_mode	= max77802_set_suspend_mode,
 };
@@ -328,7 +327,6 @@ static struct regulator_ops max77802_buck_16_dvs_ops = {
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
 	.set_ramp_delay		= max77802_set_ramp_delay_4bit,
-	.set_suspend_enable	= max77802_enable,
 	.set_suspend_disable	= max77802_set_suspend_disable,
 };
 
@@ -343,7 +341,6 @@ static struct regulator_ops max77802_buck_234_ops = {
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
 	.set_ramp_delay		= max77802_set_ramp_delay_2bit,
-	.set_suspend_enable	= max77802_enable,
 	.set_suspend_disable	= max77802_set_suspend_disable,
 	.set_suspend_mode	= max77802_set_suspend_mode,
 };
@@ -359,7 +356,6 @@ static struct regulator_ops max77802_buck_dvs_ops = {
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
 	.set_ramp_delay		= max77802_set_ramp_delay_2bit,
-	.set_suspend_enable	= max77802_enable,
 	.set_suspend_disable	= max77802_set_suspend_disable,
 };
 
-- 
1.9.1
