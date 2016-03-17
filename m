From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 17 Mar 2016 19:52:30 +0100
Subject: [PATCH v2 1/2] regulator: axp20x: Fix axp209 ldo4 ranges
Message-ID: <1458240751-30281-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The axp209 ldo4 regulator has a hole at (skips) 2600 mV and 2900 mV, fix
its range table to match.

Fixes: 13d57e64352a ("regulator: axp20x: Use linear voltage ranges for AXP20X LDO4")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
Changes in v2:
-Add Fixes, Acked-by Chen-Yu tags
---
 drivers/regulator/axp20x-regulator.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 3f82e87..5041373 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -157,7 +157,9 @@ static struct regulator_ops axp20x_ops_sw = {
 static const struct regulator_linear_range axp20x_ldo4_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1250000, 0x0, 0x0, 0),
 	REGULATOR_LINEAR_RANGE(1300000, 0x1, 0x8, 100000),
-	REGULATOR_LINEAR_RANGE(2500000, 0x9, 0xf, 100000),
+	REGULATOR_LINEAR_RANGE(2500000, 0x9, 0x9, 0),
+	REGULATOR_LINEAR_RANGE(2700000, 0xa, 0xb, 100000),
+	REGULATOR_LINEAR_RANGE(3000000, 0xc, 0xf, 100000),
 };
 
 static const struct regulator_desc axp20x_regulators[] = {
-- 
2.7.3
