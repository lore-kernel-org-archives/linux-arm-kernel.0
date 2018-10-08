From: oskari@lemmela.net (Oskari Lemmela)
Date: Mon,  8 Oct 2018 21:19:08 +0300
Subject: [PATCH v3 7/7] mfd: axp20x: Add supported cells for AXP803
In-Reply-To: <20181008181908.9456-1-oskari@lemmela.net>
References: <20181008181908.9456-1-oskari@lemmela.net>
Message-ID: <20181008181908.9456-8-oskari@lemmela.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AXP803 is compatible with AXP813.
Adding cells for GPIO, ADC, AC and battery power supplies.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
---
 drivers/mfd/axp20x.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 1508d9113126..4befe474b165 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -731,8 +731,23 @@ static const struct mfd_cell axp803_cells[] = {
 		.name			= "axp221-pek",
 		.num_resources		= ARRAY_SIZE(axp803_pek_resources),
 		.resources		= axp803_pek_resources,
+	}, {
+		.name			= "axp20x-regulator",
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
-- 
2.17.1
