From: axel.lin@ingics.com (Axel Lin)
Date: Mon, 05 Nov 2012 21:44:28 +0800
Subject: [PATCH] pinctrl: sirf: Staticize non-exported symbol
Message-ID: <1352123068.14769.6.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Staticize sirfsoc_gpio_irq_map() function.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/pinctrl/pinctrl-sirf.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-sirf.c b/drivers/pinctrl/pinctrl-sirf.c
index 9ecacf3..e3b2c53 100644
--- a/drivers/pinctrl/pinctrl-sirf.c
+++ b/drivers/pinctrl/pinctrl-sirf.c
@@ -1621,8 +1621,8 @@ static void sirfsoc_gpio_set_value(struct gpio_chip *chip, unsigned offset,
 	spin_unlock_irqrestore(&bank->lock, flags);
 }
 
-int sirfsoc_gpio_irq_map(struct irq_domain *d, unsigned int irq,
-	irq_hw_number_t hwirq)
+static int sirfsoc_gpio_irq_map(struct irq_domain *d, unsigned int irq,
+				irq_hw_number_t hwirq)
 {
 	struct sirfsoc_gpio_bank *bank = d->host_data;
 
-- 
1.7.9.5
