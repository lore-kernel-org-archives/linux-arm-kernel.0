From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 9 Sep 2015 15:32:30 +0200
Subject: [PATCH] pwm: atmel-hlcdc: add sama5d2 SoC support.
Message-ID: <1441805550-11553-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add sama5d2 hlcdc backlight PWM support. This chip doesn't have to deal with an
errata, so it's a simple addition of the mfd compatible string.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/pwm/pwm-atmel-hlcdc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index fa5feaba25a5..6974a0ef986e 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -222,6 +222,9 @@ static const struct of_device_id atmel_hlcdc_dt_ids[] = {
 		.data = &atmel_hlcdc_pwm_at91sam9x5_errata,
 	},
 	{
+		.compatible = "atmel,sama5d2-hlcdc",
+	},
+	{
 		.compatible = "atmel,sama5d3-hlcdc",
 		.data = &atmel_hlcdc_pwm_sama5d3_errata,
 	},
-- 
2.1.3
