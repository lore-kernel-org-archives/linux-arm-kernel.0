From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 18 Jan 2013 15:31:07 +0800
Subject: [PATCH v7 03/15] gpio: use pinctrl device name for add range
In-Reply-To: <1358494279-16503-1-git-send-email-haojian.zhuang@linaro.org>
References: <1358494279-16503-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1358494279-16503-4-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpiochip_add_pin_range() needs pinctrl device name as parameter.
Currently the parameter is pinctrl description name. So fix it.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 drivers/gpio/gpiolib-of.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index d542a14..25b1dbe 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -250,7 +250,7 @@ static void of_gpiochip_add_pin_range(struct gpio_chip *chip)
 		 * on the same GPIO chip.
 		 */
 		ret = gpiochip_add_pin_range(chip,
-					     pinctrl_dev_get_name(pctldev),
+					     pinctrl_dev_get_devname(pctldev),
 					     0, /* offset in gpiochip */
 					     pinspec.args[0],
 					     pinspec.args[1]);
-- 
1.7.10.4
