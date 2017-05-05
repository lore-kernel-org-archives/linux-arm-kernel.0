From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Fri,  5 May 2017 13:30:14 +0530
Subject: [PATCH v1] pwm : pwm-vt8500 - Undo preparation of a clock source.
Message-ID: <1493971214-3763-1-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Undo preparation of a clock source, if vt8500_pwm_probe is not
successful.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/pwm/pwm-vt8500.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-vt8500.c b/drivers/pwm/pwm-vt8500.c
index 8141a49..3a78dd0 100644
--- a/drivers/pwm/pwm-vt8500.c
+++ b/drivers/pwm/pwm-vt8500.c
@@ -241,6 +241,7 @@ static int vt8500_pwm_probe(struct platform_device *pdev)
 	ret = pwmchip_add(&chip->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to add PWM chip\n");
+		clk_unprepare(chip->clk);
 		return ret;
 	}
 
-- 
1.9.1
