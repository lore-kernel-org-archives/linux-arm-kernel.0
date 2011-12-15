From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 15 Dec 2011 20:16:07 +0100
Subject: [PATCH 5/6] ARM: at91/gpio: remove the static specification of
 gpio_chip.base
In-Reply-To: <1323976568-20244-1-git-send-email-nicolas.ferre@atmel.com>
References: <1323976568-20244-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <62da3cffc145e2ada7ecbf4939a6029eb482d116.1323975517.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This value is determined at runtime using device tree or platform data
information.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/gpio.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-at91/gpio.c b/arch/arm/mach-at91/gpio.c
index c390f71..8ed0bc9 100644
--- a/arch/arm/mach-at91/gpio.c
+++ b/arch/arm/mach-at91/gpio.c
@@ -49,7 +49,7 @@ static int at91_gpiolib_direction_input(struct gpio_chip *chip,
 					unsigned offset);
 static int at91_gpiolib_to_irq(struct gpio_chip *chip, unsigned offset);
 
-#define AT91_GPIO_CHIP(name, base_gpio, nr_gpio)			\
+#define AT91_GPIO_CHIP(name, nr_gpio)					\
 	{								\
 		.chip = {						\
 			.label		  = name,			\
@@ -58,18 +58,17 @@ static int at91_gpiolib_to_irq(struct gpio_chip *chip, unsigned offset);
 			.get		  = at91_gpiolib_get,		\
 			.set		  = at91_gpiolib_set,		\
 			.dbg_show	  = at91_gpiolib_dbg_show,	\
-			.base		  = base_gpio,			\
 			.to_irq		  = at91_gpiolib_to_irq,	\
 			.ngpio		  = nr_gpio,			\
 		},							\
 	}
 
 static struct at91_gpio_chip gpio_chip[] = {
-	AT91_GPIO_CHIP("pioA", 0x00, 32),
-	AT91_GPIO_CHIP("pioB", 0x20, 32),
-	AT91_GPIO_CHIP("pioC", 0x40, 32),
-	AT91_GPIO_CHIP("pioD", 0x60, 32),
-	AT91_GPIO_CHIP("pioE", 0x80, 32),
+	AT91_GPIO_CHIP("pioA", 32),
+	AT91_GPIO_CHIP("pioB", 32),
+	AT91_GPIO_CHIP("pioC", 32),
+	AT91_GPIO_CHIP("pioD", 32),
+	AT91_GPIO_CHIP("pioE", 32),
 };
 
 static int gpio_banks;
-- 
1.7.5.4
