From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri,  3 Jun 2016 10:23:00 +0200
Subject: [PATCH 02/14] regulator: pwm: Drop unneeded pwm_enable() call
In-Reply-To: <1464942192-25967-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1464942192-25967-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1464942192-25967-3-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the PWM regulator driver implements the ->enable/disable() hooks
we can remove the pwm_enable() call from pwm_regulator_set_voltage().

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/regulator/pwm-regulator.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index fafa348..ab3cc02 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -159,11 +159,6 @@ static int pwm_regulator_set_voltage(struct regulator_dev *rdev,
 		return ret;
 	}
 
-	ret = pwm_enable(drvdata->pwm);
-	if (ret) {
-		dev_err(&rdev->dev, "Failed to enable PWM: %d\n", ret);
-		return ret;
-	}
 	drvdata->volt_uV = min_uV;
 
 	/* Delay required by PWM regulator to settle to the new voltage */
-- 
2.7.4
