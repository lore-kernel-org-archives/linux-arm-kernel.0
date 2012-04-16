From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 16 Apr 2012 11:20:54 +0200
Subject: [PATCH 10/12] leds-atmel-pwm.c: Make pwmled_probe() __devinit
In-Reply-To: <cover.1334567594.git.nicolas.ferre@atmel.com>
References: <cover.1334567594.git.nicolas.ferre@atmel.com>
Message-ID: <23f8dba8a3e1ae21a5953747b63dc0a21fcba868.1334567594.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 892a884 (leds: convert led platform drivers to module_platform_driver)
is omitting the section mismatch error: so change annotation of the probe
function to __devinit instead of __init.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 drivers/leds/leds-atmel-pwm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-atmel-pwm.c b/drivers/leds/leds-atmel-pwm.c
index 800243b..64ad702 100644
--- a/drivers/leds/leds-atmel-pwm.c
+++ b/drivers/leds/leds-atmel-pwm.c
@@ -35,7 +35,7 @@ static void pwmled_brightness(struct led_classdev *cdev, enum led_brightness b)
  * NOTE:  we reuse the platform_data structure of GPIO leds,
  * but repurpose its "gpio" number as a PWM channel number.
  */
-static int __init pwmled_probe(struct platform_device *pdev)
+static int __devinit pwmled_probe(struct platform_device *pdev)
 {
 	const struct gpio_led_platform_data	*pdata;
 	struct pwmled				*leds;
-- 
1.7.10
