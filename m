From: broonie@kernel.org (Mark Brown)
Date: Mon, 23 May 2016 18:50:54 +0100
Subject: Applied "regulator: mt6397: Constify struct regulator_ops" to the
 regulator tree
In-Reply-To: <1463988616-18803-1-git-send-email-henryc.chen@mediatek.com>
Message-ID: <E1b4u0E-0006j4-3g@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   regulator: mt6397: Constify struct regulator_ops

has been applied to the regulator tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 7e3fc9960169ec5eab0ec6810fa24518ea3f3608 Mon Sep 17 00:00:00 2001
From: Henry Chen <henryc.chen@mediatek.com>
Date: Mon, 23 May 2016 15:30:16 +0800
Subject: [PATCH] regulator: mt6397: Constify struct regulator_ops

Consitify the structure of regulator operations.

Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/mt6397-regulator.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/mt6397-regulator.c b/drivers/regulator/mt6397-regulator.c
index 17a5b6c2d6a9..1c45abb94409 100644
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
2.8.1
