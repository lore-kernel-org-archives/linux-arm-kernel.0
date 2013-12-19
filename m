From: voice.shen@atmel.com (Bo Shen)
Date: Thu, 19 Dec 2013 11:42:22 +0800
Subject: [PATCH] pwm: atmel-pwm: clock can not unprepare after successfully
 register
Message-ID: <1387424542-5864-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the PWM controller is registered successfully, the clock can not
unprepare, so fix it.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 drivers/pwm/pwm-atmel.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 657e90a..bf4144a 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -362,6 +362,8 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, atmel_pwm);
 
+	return ret;
+
 unprepare_clk:
 	clk_unprepare(atmel_pwm->clk);
 	return ret;
-- 
1.7.9.5
