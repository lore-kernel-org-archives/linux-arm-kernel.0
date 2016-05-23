From: henryc.chen@mediatek.com (Henry Chen)
Date: Mon, 23 May 2016 15:30:16 +0800
Subject: [PATCH] regulator: mt6397: Constify struct regulator_ops
Message-ID: <1463988616-18803-1-git-send-email-henryc.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Consitify the structure of regulator operations.

Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
---
 drivers/regulator/mt6397-regulator.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/mt6397-regulator.c b/drivers/regulator/mt6397-regulator.c
index 17a5b6c..1c45abb 100644
--- a/drivers/regulator/mt6397-regulator.c
+++ b/drivers/regulator/mt6397-regulator.c
@@ -160,7 +160,7 @@ static int mt6397_get_status(struct regulator_dev *rdev)
 	return (regval & info->qi) ? REGULATOR_STATUS_ON : REGULATOR_STATUS_OFF;
 }
 
-static struct regulator_ops mt6397_volt_range_ops = {
+static const struct regulator_ops mt6397_volt_range_ops = {
 	.list_voltage = regulator_list_voltage_linear_range,
 	.map_voltage = regulator_map_voltage_linear_range,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
@@ -172,7 +172,7 @@ static struct regulator_ops mt6397_volt_range_ops = {
 	.get_status = mt6397_get_status,
 };
 
-static struct regulator_ops mt6397_volt_table_ops = {
+static const struct regulator_ops mt6397_volt_table_ops = {
 	.list_voltage = regulator_list_voltage_table,
 	.map_voltage = regulator_map_voltage_iterate,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
@@ -184,7 +184,7 @@ static struct regulator_ops mt6397_volt_table_ops = {
 	.get_status = mt6397_get_status,
 };
 
-static struct regulator_ops mt6397_volt_fixed_ops = {
+static const struct regulator_ops mt6397_volt_fixed_ops = {
 	.list_voltage = regulator_list_voltage_linear,
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
-- 
1.8.1.1.dirty
