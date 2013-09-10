From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 10 Sep 2013 14:31:35 +0200
Subject: [PATCH 6/7] ARM: ixp4: delete irq_to_gpio
Message-ID: <1378816295-8205-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This dangerous function is not used in the kernel, so let's
just delete it.

Cc: Imre Kaloz <kaloz@openwrt.org>
Cc: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ixp4xx/common.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index 5327dec..8708ac8 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -117,17 +117,6 @@ static int ixp4xx_gpio_to_irq(struct gpio_chip *chip, unsigned gpio)
 	return -EINVAL;
 }
 
-int irq_to_gpio(unsigned int irq)
-{
-	int gpio = (irq < 32) ? irq2gpio[irq] : -EINVAL;
-
-	if (gpio == -1)
-		return -EINVAL;
-
-	return gpio;
-}
-EXPORT_SYMBOL(irq_to_gpio);
-
 static int ixp4xx_set_irq_type(struct irq_data *d, unsigned int type)
 {
 	int line = irq2gpio[d->irq];
-- 
1.8.3.1
