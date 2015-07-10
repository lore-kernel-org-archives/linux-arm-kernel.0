From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 10 Jul 2015 08:45:35 +0100
Subject: [PATCH 2/3] regulator: pwm-regulator: Fix 'used uninitialized' warning
In-Reply-To: <1436514336-2075-1-git-send-email-lee.jones@linaro.org>
References: <1436514336-2075-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1436514336-2075-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drivers/regulator/pwm-regulator.c:
  In function 'pwm_regulator_init_table':
drivers/regulator/pwm-regulator.c:172:14:
  warning: 'length' is used uninitialized in this function [-Wuninitialized]
    if ((length < sizeof(*duty_cycle_table)) ||
              ^
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/pwm-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index a4c2ce9..331b851 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -163,7 +163,7 @@ static int pwm_regulator_init_table(struct platform_device *pdev,
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct pwm_voltages *duty_cycle_table;
-	int length;
+	int length = 0;
 	int ret;
 
 	of_find_property(np, "voltage-table", &length);
-- 
1.9.1
