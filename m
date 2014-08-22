From: dianders@chromium.org (Doug Anderson)
Date: Thu, 21 Aug 2014 17:54:55 -0700
Subject: [PATCH] regulator: RK808: Fix uninitialized value
Message-ID: <1408668895-1108-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RK808 regulator driver was putting its config on the stack but not
initting it.  That means that you got a semi-random config.  Fix this.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 drivers/regulator/rk808-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index 94753fd..4d5041c 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -334,7 +334,7 @@ static int rk808_regulator_probe(struct platform_device *pdev)
 {
 	struct rk808 *rk808 = dev_get_drvdata(pdev->dev.parent);
 	struct rk808_board *pdata;
-	struct regulator_config config;
+	struct regulator_config config = {};
 	struct regulator_dev *rk808_rdev;
 	struct regulator_init_data *reg_data;
 	int i = 0;
-- 
2.1.0.rc2.206.gedb03e5
