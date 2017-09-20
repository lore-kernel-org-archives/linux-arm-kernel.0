From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 20 Sep 2017 23:18:12 +0800
Subject: [RFC PATCH 5/7] mfd: axp20x: add cells for AXP803 ADC/AC Power/Battery
In-Reply-To: <20170920151814.22461-1-icenowy@aosc.io>
References: <20170920151814.22461-1-icenowy@aosc.io>
Message-ID: <20170920151814.22461-6-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we have now support for AXP803 ADC/Battery, and the AC Power part of
AXP803 is the same as AXP22x, add MFD cells for these drivers.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/mfd/axp20x.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 336de66ca408..91be5fe1c5de 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -850,7 +850,18 @@ static struct mfd_cell axp803_cells[] = {
 		.num_resources		= ARRAY_SIZE(axp803_pek_resources),
 		.resources		= axp803_pek_resources,
 	},
+	{	.name			= "axp803-adc" },
 	{	.name			= "axp20x-regulator" },
+	{
+		.name		= "axp20x-ac-power-supply",
+		.of_compatible	= "x-powers,axp221-ac-power-supply",
+		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
+		.resources	= axp20x_ac_power_supply_resources,
+	},
+	{
+		.name		= "axp20x-battery-power-supply",
+		.of_compatible	= "x-powers,axp803-battery-power-supply",
+	},
 };
 
 static struct mfd_cell axp806_cells[] = {
-- 
2.13.5
