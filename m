From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 12 Mar 2016 15:20:01 +0100
Subject: [PATCH] regulator: axp20x: Fix axp209 ldo4 ranges
Message-ID: <1457792401-28337-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The axp209 ldo4 regulator has a hole at (skips) 2600 mV and 2900 mV, fix
its range table to match.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/regulator/axp20x-regulator.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 4250b1b..500d162 100644
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
2.7.2
