From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 10 Jul 2015 08:45:36 +0100
Subject: [PATCH 3/3] regulator: pwm-regulator: Fix ' comparison between signed
 and unsigned integer' warning
In-Reply-To: <1436514336-2075-1-git-send-email-lee.jones@linaro.org>
References: <1436514336-2075-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1436514336-2075-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drivers/regulator/pwm-regulator.c:
  In function ?pwm_regulator_init_table?:
drivers/regulator/pwm-regulator.c:171:14:
  warning: comparison between signed and unsigned integer expressions [-Wsign-compare]

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/pwm-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index 331b851..fc3166d 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -163,7 +163,7 @@ static int pwm_regulator_init_table(struct platform_device *pdev,
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct pwm_voltages *duty_cycle_table;
-	int length = 0;
+	unsigned int length = 0;
 	int ret;
 
 	of_find_property(np, "voltage-table", &length);
-- 
1.9.1
