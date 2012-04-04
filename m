From: stigge@antcom.de (Roland Stigge)
Date: Wed,  4 Apr 2012 02:02:58 +0200
Subject: [PATCH] gpio: Fix range check in of_gpio_simple_xlate()
Message-ID: <1333497778-26925-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes a range check in of_gpio_simple_xlate() by replacing a
"> gc->ngpio" with ">= gc->ngpio" since range is from 0 to gc->ngpio - 1

Signed-off-by: Roland Stigge <stigge@antcom.de>

---

 Applies to v3.4-rc1

 drivers/of/gpio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.orig/drivers/of/gpio.c
+++ linux-2.6/drivers/of/gpio.c
@@ -140,7 +140,7 @@ int of_gpio_simple_xlate(struct gpio_chi
 	if (WARN_ON(gpiospec->args_count < gc->of_gpio_n_cells))
 		return -EINVAL;
 
-	if (gpiospec->args[0] > gc->ngpio)
+	if (gpiospec->args[0] >= gc->ngpio)
 		return -EINVAL;
 
 	if (flags)
