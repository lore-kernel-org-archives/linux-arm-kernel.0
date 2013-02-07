From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 7 Feb 2013 19:43:42 +0100
Subject: [PATCH] pinctrl: exynos5440: remove erroneous __init
Message-ID: <1360262622-23616-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This removes the __init notation from some of the
the exynos 5440 pin controller set-up functions. These
functions are called from probe() and as such may be
discarded before probe() completes.

Cc: Thomas Abraham <thomas.abraham@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-exynos5440.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-exynos5440.c b/drivers/pinctrl/pinctrl-exynos5440.c
index de05b64..1427299 100644
--- a/drivers/pinctrl/pinctrl-exynos5440.c
+++ b/drivers/pinctrl/pinctrl-exynos5440.c
@@ -599,7 +599,7 @@ static int exynos5440_gpio_direction_output(struct gpio_chip *gc, unsigned offse
 }
 
 /* parse the pin numbers listed in the 'samsung,exynos5440-pins' property */
-static int __init exynos5440_pinctrl_parse_dt_pins(struct platform_device *pdev,
+static int exynos5440_pinctrl_parse_dt_pins(struct platform_device *pdev,
 			struct device_node *cfg_np, unsigned int **pin_list,
 			unsigned int *npins)
 {
@@ -630,7 +630,7 @@ static int __init exynos5440_pinctrl_parse_dt_pins(struct platform_device *pdev,
  * Parse the information about all the available pin groups and pin functions
  * from device node of the pin-controller.
  */
-static int __init exynos5440_pinctrl_parse_dt(struct platform_device *pdev,
+static int exynos5440_pinctrl_parse_dt(struct platform_device *pdev,
 				struct exynos5440_pinctrl_priv_data *priv)
 {
 	struct device *dev = &pdev->dev;
@@ -723,7 +723,7 @@ static int __init exynos5440_pinctrl_parse_dt(struct platform_device *pdev,
 }
 
 /* register the pinctrl interface with the pinctrl subsystem */
-static int __init exynos5440_pinctrl_register(struct platform_device *pdev,
+static int exynos5440_pinctrl_register(struct platform_device *pdev,
 				struct exynos5440_pinctrl_priv_data *priv)
 {
 	struct device *dev = &pdev->dev;
@@ -798,7 +798,7 @@ static int __init exynos5440_pinctrl_register(struct platform_device *pdev,
 }
 
 /* register the gpiolib interface with the gpiolib subsystem */
-static int __init exynos5440_gpiolib_register(struct platform_device *pdev,
+static int exynos5440_gpiolib_register(struct platform_device *pdev,
 				struct exynos5440_pinctrl_priv_data *priv)
 {
 	struct gpio_chip *gc;
@@ -831,7 +831,7 @@ static int __init exynos5440_gpiolib_register(struct platform_device *pdev,
 }
 
 /* unregister the gpiolib interface with the gpiolib subsystem */
-static int __init exynos5440_gpiolib_unregister(struct platform_device *pdev,
+static int exynos5440_gpiolib_unregister(struct platform_device *pdev,
 				struct exynos5440_pinctrl_priv_data *priv)
 {
 	int ret = gpiochip_remove(priv->gc);
-- 
1.7.11.3
