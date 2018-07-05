From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  5 Jul 2018 11:11:04 +0800
Subject: [PATCH v2 3/5] mfd: axp20x: Support AXP806 in I2C mode
In-Reply-To: <20180705031106.344-1-wens@csie.org>
References: <20180705031106.344-1-wens@csie.org>
Message-ID: <20180705031106.344-4-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Pine64 H64 board uses an AXP806 PMIC in I2C and self-working mode.
The H64 SoC does not have the usual RSB controller.

This patch adds AXP806 to the list of devices supported in I2C mode.
In theory, all RSB-based PMICs can also be used in I2C mode.

Reviewed-by: Icenowy Zheng <icenowy@aosc.io>
Tested-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mfd/axp20x-i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/axp20x-i2c.c b/drivers/mfd/axp20x-i2c.c
index d35a5fe6c950..a7b7c5423ea5 100644
--- a/drivers/mfd/axp20x-i2c.c
+++ b/drivers/mfd/axp20x-i2c.c
@@ -65,6 +65,7 @@ static const struct of_device_id axp20x_i2c_of_match[] = {
 	{ .compatible = "x-powers,axp202", .data = (void *)AXP202_ID },
 	{ .compatible = "x-powers,axp209", .data = (void *)AXP209_ID },
 	{ .compatible = "x-powers,axp221", .data = (void *)AXP221_ID },
+	{ .compatible = "x-powers,axp806", .data = (void *)AXP806_ID },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, axp20x_i2c_of_match);
@@ -74,6 +75,7 @@ static const struct i2c_device_id axp20x_i2c_id[] = {
 	{ "axp202", 0 },
 	{ "axp209", 0 },
 	{ "axp221", 0 },
+	{ "axp806", 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, axp20x_i2c_id);
-- 
2.18.0
