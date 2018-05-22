From: claudiu.beznea@microchip.com (Claudiu Beznea)
Date: Tue, 22 May 2018 15:07:08 +0300
Subject: [PATCH v5 4/9] pwm: pxa: populate PWM mode in of_xlate function
In-Reply-To: <1526990833-30707-1-git-send-email-claudiu.beznea@microchip.com>
References: <1526990833-30707-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <1526990833-30707-5-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Populate PWM mode in of_xlate function to avoid pwm_apply_state() failure.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/pwm-pxa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index 4143a46684d2..4c88cb47d6ba 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -161,6 +161,7 @@ pxa_pwm_of_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
 		return pwm;
 
 	pwm->args.period = args->args[0];
+	pwm->args.mode = pwm_mode_get_valid(pc, pwm);
 
 	return pwm;
 }
-- 
2.7.4
