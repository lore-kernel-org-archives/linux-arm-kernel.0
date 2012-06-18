From: stigge@antcom.de (Roland Stigge)
Date: Mon, 18 Jun 2012 22:18:58 +0200
Subject: [PATCH RESEND] gpio: LPC32xx: Driver cleanup
Message-ID: <1340050738-22988-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since LPC32xx is now switched over to devicetree based GPIO, the unused
lpc32xx_gpio_init() can be removed.

Further, the driver title changed since it referred to the wrong file.

Signed-off-by: Roland Stigge <stigge@antcom.de>

---
Applies to v3.5-rc3

 drivers/gpio/gpio-lpc32xx.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

--- linux-2.6.orig/drivers/gpio/gpio-lpc32xx.c
+++ linux-2.6/drivers/gpio/gpio-lpc32xx.c
@@ -1,5 +1,5 @@
 /*
- * arch/arm/mach-lpc32xx/gpiolib.c
+ * GPIO driver for LPC32xx SoC
  *
  * Author: Kevin Wells <kevin.wells@nxp.com>
  *
@@ -457,13 +457,6 @@ static struct lpc32xx_gpio_chip lpc32xx_
 	},
 };
 
-/* Empty now, can be removed later when mach-lpc32xx is finally switched over
- * to DT support
- */
-void __init lpc32xx_gpio_init(void)
-{
-}
-
 static int lpc32xx_of_xlate(struct gpio_chip *gc,
 			    const struct of_phandle_args *gpiospec, u32 *flags)
 {
