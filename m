From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed,  9 Apr 2014 20:26:09 +0200
Subject: [PATCH] pwm: atmel: set pwm_chip can_sleep flag
Message-ID: <1397067969-19905-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

atmel_pwm_config() calls clk_get_rate() which might sleep, so we need to set
pwm_chip can_sleep flag.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/pwm/pwm-atmel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 0e589594b1cb..180e34e46617 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -369,6 +369,7 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 
 	atmel_pwm->chip.base = -1;
 	atmel_pwm->chip.npwm = 4;
+	atmel_pwm->chip.can_sleep = true;
 	atmel_pwm->config = data->config;
 
 	ret = pwmchip_add(&atmel_pwm->chip);
-- 
1.8.3.2
