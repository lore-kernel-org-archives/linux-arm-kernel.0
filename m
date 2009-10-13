From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 13 Oct 2009 17:55:35 -0400
Subject: [PATCH] ep93xx: remove dead code in ep93xx_gpio_ab_irq_handler()
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901DB8071@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unnecessary code in ep93xx_gpio_ab_irq_handler().

The desc calculation for gpio port B was left in when the following
commit was merged.

commit d8aa0251f12546e9bd1e9ee1d9782d6492819a04
Author: Dmitry Baryshkov <dbaryshkov@gmail.com>
Date:   Thu Oct 9 13:36:24 2008 +0100

    [ARM] 5298/1: Drop desc_handle_irq()

It's not needed so remove it.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <ryan@bluewatersys.com>

---

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index f95dc16..b4357c3 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -206,7 +206,6 @@ static void ep93xx_gpio_ab_irq_handler(unsigned int irq, struct irq_desc *desc)
 	for (i = 0; i < 8; i++) {
 		if (status & (1 << i)) {
 			int gpio_irq = gpio_to_irq(EP93XX_GPIO_LINE_B(0)) + i;
-			desc = irq_desc + gpio_irq;
 			generic_handle_irq(gpio_irq);
 		}
 	} 
