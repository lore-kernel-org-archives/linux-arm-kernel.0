From: tony@atomide.com (Tony Lindgren)
Date: Tue, 5 Jan 2010 12:17:06 -0800
Subject: [PATCH] omap: Remove uninitialized warning for gpio.c
Message-ID: <mailman.119.1262722826.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Flags is not used on 15xx.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 0484681..792be9f 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1072,7 +1072,7 @@ static inline void _set_gpio_irqenable(struct gpio_bank *bank, int gpio, int ena
  */
 static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 {
-	unsigned long flags;
+	unsigned long uninitialized_var(flags);
 
 	switch (bank->method) {
 #ifdef CONFIG_ARCH_OMAP16XX

--Qxx1br4bt0+wmkIi--
