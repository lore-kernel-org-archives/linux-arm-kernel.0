From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 27 Nov 2015 14:43:28 +0800
Subject: [PATCH v5 7/9] regulator: axp20x: Support new AXP223 PMIC
In-Reply-To: <1448606610-32647-1-git-send-email-wens@csie.org>
References: <1448606610-32647-1-git-send-email-wens@csie.org>
Message-ID: <1448606610-32647-8-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AXP223 is a new PMIC commonly paired with Allwinner A23/A33 SoCs.
It is functionally identical to AXP221; only the regulator default
voltage/status and the external host interface are different.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/axp20x-regulator.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 35de22fdb7a0..55cce8125716 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -244,6 +244,7 @@ static int axp20x_set_dcdc_freq(struct platform_device *pdev, u32 dcdcfreq)
 		step = 75;
 		break;
 	case AXP221_ID:
+	case AXP223_ID:
 		min = 1800;
 		max = 4050;
 		def = 3000;
@@ -322,6 +323,7 @@ static int axp20x_set_dcdc_workmode(struct regulator_dev *rdev, int id, u32 work
 		break;
 
 	case AXP221_ID:
+	case AXP223_ID:
 		if (id < AXP22X_DCDC1 || id > AXP22X_DCDC5)
 			return -EINVAL;
 
@@ -360,6 +362,7 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 		nregulators = AXP20X_REG_ID_MAX;
 		break;
 	case AXP221_ID:
+	case AXP223_ID:
 		regulators = axp22x_regulators;
 		nregulators = AXP22X_REG_ID_MAX;
 		break;
-- 
2.6.2
