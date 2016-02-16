From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Feb 2016 16:40:36 +0100
Subject: [PATCH v2 3/5] gpio: ks8695: remove irq_to_gpio function
In-Reply-To: <1455637261-2920972-1-git-send-email-arnd@arndb.de>
References: <455637086-2794174-1-git-send-email-arnd@arndb.de>
 <1455637261-2920972-1-git-send-email-arnd@arndb.de>
Message-ID: <1455637261-2920972-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ks8695 gpio driver has its own copy of the irq_to_gpio()
function. This is completely unused in the mainline kernel
after we converted all remaining users several years ago,
so we can remove the definition as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpio/gpio-ks8695.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpio/gpio-ks8695.c b/drivers/gpio/gpio-ks8695.c
index 9f86ed9c753b..179723d02f55 100644
--- a/drivers/gpio/gpio-ks8695.c
+++ b/drivers/gpio/gpio-ks8695.c
@@ -205,18 +205,6 @@ static int ks8695_gpio_to_irq(struct gpio_chip *gc, unsigned int pin)
 	return gpio_irq[pin];
 }
 
-/*
- * Map IRQ number to GPIO line.
- */
-int irq_to_gpio(unsigned int irq)
-{
-	if ((irq < KS8695_IRQ_EXTERN0) || (irq > KS8695_IRQ_EXTERN3))
-		return -EINVAL;
-
-	return (irq - KS8695_IRQ_EXTERN0);
-}
-EXPORT_SYMBOL(irq_to_gpio);
-
 /* GPIOLIB interface */
 
 static struct gpio_chip ks8695_gpio_chip = {
-- 
2.7.0
