From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 15 May 2011 19:53:45 -0300
Subject: [PATCH] regulator: mc13892: Fix voltage unit in test case.
Message-ID: <1305500025-3602-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Voltage values should be expressed in microvolts, not in milivolts.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Signed-off-by: Ranjani Vaidyanathan <ra5478@freescale.com>
---
 drivers/regulator/mc13892-regulator.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/mc13892-regulator.c b/drivers/regulator/mc13892-regulator.c
index 6f15168..e90ba05 100644
--- a/drivers/regulator/mc13892-regulator.c
+++ b/drivers/regulator/mc13892-regulator.c
@@ -453,9 +453,9 @@ static int mc13892_sw_regulator_set_voltage(struct regulator_dev *rdev,
 		goto err;
 
 	hi  = val & MC13892_SWITCHERS0_SWxHI;
-	if (value > 1375)
+	if (value > 1375000)
 		hi = 1;
-	if (value < 1100)
+	if (value < 1100000)
 		hi = 0;
 
 	if (hi) {
-- 
1.7.1
