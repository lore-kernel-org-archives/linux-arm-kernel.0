From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 10 Jul 2015 08:45:34 +0100
Subject: [PATCH 1/3] regulator: pwm-regulator: Fix 'unused-variable' warning
Message-ID: <1436514336-2075-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drivers/regulator/pwm-regulator.c:
  In function 'pwm_regulator_init_continuous':
drivers/regulator/pwm-regulator.c:202:22:
  warning: unused variable 'np' [-Wunused-variable]
     struct device_node *np = pdev->dev.of_node;
              ^
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/pwm-regulator.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index 936e387..a4c2ce9 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -198,8 +198,6 @@ static int pwm_regulator_init_table(struct platform_device *pdev,
 static int pwm_regulator_init_continuous(struct platform_device *pdev,
 					 struct pwm_regulator_data *drvdata)
 {
-	struct device_node *np = pdev->dev.of_node;
-
 	pwm_regulator_desc.ops = &pwm_regulator_voltage_continuous_ops;
 	pwm_regulator_desc.continuous_voltage_range = true;
 
-- 
1.9.1
