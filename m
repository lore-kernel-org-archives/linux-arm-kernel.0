From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 6 Nov 2012 16:17:01 +0100
Subject: [PATCH 4/5] gpiolib: call pin removal in chip removal function
Message-ID: <1352215021-30341-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This makes us call gpiochio_remove_pin_ranges() in the
gpiochip_remove() function, so we get rid of ranges when
freeing the chip.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 10fc9c3..fd7280f 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1125,6 +1125,7 @@ int gpiochip_remove(struct gpio_chip *chip)
 
 	spin_lock_irqsave(&gpio_lock, flags);
 
+	gpiochip_remove_pin_ranges(chip);
 	of_gpiochip_remove(chip);
 
 	for (id = chip->base; id < chip->base + chip->ngpio; id++) {
-- 
1.7.11.3
