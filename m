From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  9 Apr 2014 09:18:55 +0200
Subject: [PATCH] pinctrl: nomadik: delete stray debug print
Message-ID: <1397027935-14926-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I left this in by mistake, get rid of it.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-nomadik.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-nomadik.c b/drivers/pinctrl/pinctrl-nomadik.c
index 208341fd57d2..8f6f16ef73f3 100644
--- a/drivers/pinctrl/pinctrl-nomadik.c
+++ b/drivers/pinctrl/pinctrl-nomadik.c
@@ -877,7 +877,6 @@ static void nmk_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	struct nmk_gpio_chip *nmk_chip = container_of(chip, struct nmk_gpio_chip, chip);
 	u32 status;
 
-	pr_err("PLONK IRQ %d\n", irq);
 	clk_enable(nmk_chip->clk);
 	status = readl(nmk_chip->addr + NMK_GPIO_IS);
 	clk_disable(nmk_chip->clk);
-- 
1.9.0
