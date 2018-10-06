From: oskari@lemmela.net (Oskari Lemmela)
Date: Sun,  7 Oct 2018 00:18:35 +0300
Subject: [PATCH v2 5/6] mfd: axp20x: add support AXP803 AC and battery power
 supplies
In-Reply-To: <20181006211836.28253-1-oskari@lemmela.net>
References: <20181004193410.7265-1-oskari@lemmela.net>
 <20181006211836.28253-1-oskari@lemmela.net>
Message-ID: <20181006211836.28253-6-oskari@lemmela.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AXP803 is compatible with AXP813.
Adding needed cells for AC and battery power supplies.

AXP813 AC power supply cell added.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
---
 drivers/mfd/axp20x.c       | 22 +++++++++++++++++++++-
 include/linux/mfd/axp20x.h |  1 +
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 0be511dd93d0..215f0b009728 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -731,8 +731,23 @@ static const struct mfd_cell axp803_cells[] = {
 		.name			= "axp221-pek",
 		.num_resources		= ARRAY_SIZE(axp803_pek_resources),
 		.resources		= axp803_pek_resources,
+	}, {
+		.name			= "axp20x-regulator"
+	}, {
+		.name			= "axp20x-gpio",
+		.of_compatible		= "x-powers,axp813-gpio",
+	}, {
+		.name			= "axp813-adc",
+		.of_compatible		= "x-powers,axp813-adc",
+	}, {
+		.name		= "axp20x-battery-power-supply",
+		.of_compatible	= "x-powers,axp813-battery-power-supply",
+	}, {
+		.name           = "axp20x-ac-power-supply",
+		.of_compatible  = "x-powers,axp813-ac-power-supply",
+		.num_resources  = ARRAY_SIZE(axp20x_ac_power_supply_resources),
+		.resources      = axp20x_ac_power_supply_resources,
 	},
-	{	.name			= "axp20x-regulator" },
 };
 
 static const struct mfd_cell axp806_self_working_cells[] = {
@@ -778,6 +793,11 @@ static const struct mfd_cell axp813_cells[] = {
 	}, {
 		.name		= "axp20x-battery-power-supply",
 		.of_compatible	= "x-powers,axp813-battery-power-supply",
+	}, {
+		.name           = "axp20x-ac-power-supply",
+		.of_compatible  = "x-powers,axp813-ac-power-supply",
+		.num_resources  = ARRAY_SIZE(axp20x_ac_power_supply_resources),
+		.resources      = axp20x_ac_power_supply_resources,
 	},
 };
 
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index 517e60eecbcb..2302b620d238 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -266,6 +266,7 @@ enum axp20x_variants {
 #define AXP288_RT_BATT_V_H		0xa0
 #define AXP288_RT_BATT_V_L		0xa1
 
+#define AXP813_ACIN_PATH_CTRL		0x3a
 #define AXP813_ADC_RATE			0x85
 
 /* Fuel Gauge */
-- 
2.17.1
