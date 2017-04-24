From: icenowy@aosc.io (Icenowy Zheng)
Date: Tue, 25 Apr 2017 00:01:00 +0800
Subject: [PATCH v4 07/10] mfd: axp20x: add axp20x-regulator cell for AXP803
In-Reply-To: <20170424160103.9447-1-icenowy@aosc.io>
References: <20170424160103.9447-1-icenowy@aosc.io>
Message-ID: <20170424160103.9447-8-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As axp20x-regulator now supports AXP803, add a cell for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
Changes in v4:
- Added a trailing comma for new cell, for easier further cell addition.
Changes in v3:
- Make the new cell one-liner.

 drivers/mfd/axp20x.c                 | 3 ++-
 drivers/regulator/axp20x-regulator.c | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 1dc6235778eb..917b6ddc4f15 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -848,7 +848,8 @@ static struct mfd_cell axp803_cells[] = {
 		.name			= "axp20x-pek",
 		.num_resources		= ARRAY_SIZE(axp803_pek_resources),
 		.resources		= axp803_pek_resources,
-	}
+	},
+	{	.name			= "axp20x-regulator" },
 };
 
 static struct mfd_cell axp806_cells[] = {
diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 9356ec8a9a1f..e2608fe770b9 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -311,13 +311,13 @@ static const struct regulator_desc axp803_regulators[] = {
 		 AXP803_FLDO1_V_OUT, 0x0f, AXP22X_PWR_OUT_CTRL3, BIT(2)),
 	AXP_DESC(AXP803, FLDO2, "fldo2", "fldoin", 700, 1450, 50,
 		 AXP803_FLDO2_V_OUT, 0x0f, AXP22X_PWR_OUT_CTRL3, BIT(3)),
-	AXP_DESC_IO(AXP803, LDO_IO0, "ldo_io0", "ips", 700, 3300, 100,
+	AXP_DESC_IO(AXP803, LDO_IO0, "ldo-io0", "ips", 700, 3300, 100,
 		    AXP22X_LDO_IO0_V_OUT, 0x1f, AXP20X_GPIO0_CTRL, 0x07,
 		    AXP22X_IO_ENABLED, AXP22X_IO_DISABLED),
-	AXP_DESC_IO(AXP803, LDO_IO1, "ldo_io1", "ips", 700, 3300, 100,
+	AXP_DESC_IO(AXP803, LDO_IO1, "ldo-io1", "ips", 700, 3300, 100,
 		    AXP22X_LDO_IO1_V_OUT, 0x1f, AXP20X_GPIO1_CTRL, 0x07,
 		    AXP22X_IO_ENABLED, AXP22X_IO_DISABLED),
-	AXP_DESC_FIXED(AXP803, RTC_LDO, "rtc_ldo", "ips", 3000),
+	AXP_DESC_FIXED(AXP803, RTC_LDO, "rtc-ldo", "ips", 3000),
 };
 
 static const struct regulator_linear_range axp806_dcdca_ranges[] = {
-- 
2.12.2
