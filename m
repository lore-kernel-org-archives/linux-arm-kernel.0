From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed,  1 Jul 2015 14:27:19 +0200
Subject: [PATCH] gpio: msm: Remove empty msm_gpio_{request,free}()
Message-ID: <1435753639-13627-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpio_chip.request() and gpio_chip.free() are optional, and can just be
left unimplemented.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Untested due to lack of hardware.
---
 drivers/gpio/gpio-msm-v2.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpio/gpio-msm-v2.c b/drivers/gpio/gpio-msm-v2.c
index 52ff18229fdc874a..d9ea0c8e5f0aa82d 100644
--- a/drivers/gpio/gpio-msm-v2.c
+++ b/drivers/gpio/gpio-msm-v2.c
@@ -169,16 +169,6 @@ static int msm_gpio_direction_output(struct gpio_chip *chip,
 	return 0;
 }
 
-static int msm_gpio_request(struct gpio_chip *chip, unsigned offset)
-{
-	return 0;
-}
-
-static void msm_gpio_free(struct gpio_chip *chip, unsigned offset)
-{
-	return;
-}
-
 static int msm_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
 {
 	struct msm_gpio_dev *g_dev = to_msm_gpio_dev(chip);
@@ -404,8 +394,6 @@ static int msm_gpio_probe(struct platform_device *pdev)
 	msm_gpio.gpio_chip.get = msm_gpio_get;
 	msm_gpio.gpio_chip.set = msm_gpio_set;
 	msm_gpio.gpio_chip.to_irq = msm_gpio_to_irq;
-	msm_gpio.gpio_chip.request = msm_gpio_request;
-	msm_gpio.gpio_chip.free = msm_gpio_free;
 
 	ret = gpiochip_add(&msm_gpio.gpio_chip);
 	if (ret < 0) {
-- 
1.9.1
