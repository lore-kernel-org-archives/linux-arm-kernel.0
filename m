From: henryc.chen@mediatek.com (Henry Chen)
Date: Mon, 3 Aug 2015 22:15:51 +0800
Subject: [PATCH] regulator: mt6311: Modify the maximum voltage of buck.
Message-ID: <1438611351-4245-1-git-send-email-henryc.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The maximum voltage of buck should be 1.39375V.
1.39375V = 0.6V + 0.00625V * 127, 127 is the max_sel of linear range.

Reported-by: Axel Lin <axel.lin@ingics.com>
signed-off-by: Henry Chen <henryc.chen@mediatek.com>
---
 drivers/regulator/mt6311-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/mt6311-regulator.c b/drivers/regulator/mt6311-regulator.c
index 096e620..b140da0 100644
--- a/drivers/regulator/mt6311-regulator.c
+++ b/drivers/regulator/mt6311-regulator.c
@@ -34,7 +34,7 @@ static const struct regmap_config mt6311_regmap_config = {
 
 /* Default limits measured in millivolts and milliamps */
 #define MT6311_MIN_UV		600000
-#define MT6311_MAX_UV		1400000
+#define MT6311_MAX_UV		1393750
 #define MT6311_STEP_UV		6250
 
 static const struct regulator_linear_range buck_volt_range[] = {
-- 
1.8.1.1.dirty
