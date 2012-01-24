From: k.lewandowsk@samsung.com (Karol Lewandowski)
Date: Tue, 24 Jan 2012 12:31:11 +0100
Subject: [PATCH] max8997: Avoid spaces in regulator names
Message-ID: <1327404672-5459-1-git-send-email-k.lewandowsk@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

max8997-pmic instantiated from device tree uses names, not numerical
ids to distinguish between outputs.

Replace spaces with underscores in said names to make it possible to
describe these outputs as regulators in DTS.

Signed-off-by: Karol Lewandowski <k.lewandowsk@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Thomas Abraham <thomas.abraham@linaro.org>
---
 drivers/regulator/max8997.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/max8997.c b/drivers/regulator/max8997.c
index 053d0b7..4b572eb 100644
--- a/drivers/regulator/max8997.c
+++ b/drivers/regulator/max8997.c
@@ -910,13 +910,13 @@ static struct regulator_desc regulators[] = {
 	},
 	regulator_desc_buck(7),
 	{
-		.name	= "EN32KHz AP",
+		.name	= "EN32KHz_AP",
 		.id	= MAX8997_EN32KHZ_AP,
 		.ops	= &max8997_fixedvolt_ops,
 		.type	= REGULATOR_VOLTAGE,
 		.owner	= THIS_MODULE,
 	}, {
-		.name	= "EN32KHz CP",
+		.name	= "EN32KHz_CP",
 		.id	= MAX8997_EN32KHZ_CP,
 		.ops	= &max8997_fixedvolt_ops,
 		.type	= REGULATOR_VOLTAGE,
@@ -940,7 +940,7 @@ static struct regulator_desc regulators[] = {
 		.type	= REGULATOR_VOLTAGE,
 		.owner	 = THIS_MODULE,
 	}, {
-		.name	= "CHARGER CV",
+		.name	= "CHARGER_CV",
 		.id	= MAX8997_CHARGER_CV,
 		.ops	= &max8997_fixedstate_ops,
 		.type	= REGULATOR_VOLTAGE,
@@ -952,7 +952,7 @@ static struct regulator_desc regulators[] = {
 		.type	= REGULATOR_CURRENT,
 		.owner	 = THIS_MODULE,
 	}, {
-		.name	= "CHARGER TOPOFF",
+		.name	= "CHARGER_TOPOFF",
 		.id	= MAX8997_CHARGER_TOPOFF,
 		.ops	= &max8997_charger_fixedstate_ops,
 		.type	= REGULATOR_CURRENT,
-- 
1.7.8.3
