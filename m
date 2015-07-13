From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 13 Jul 2015 20:29:15 -0000
Subject: [patch 11/11] ARM/orion/gpio: Prepare gpio_irq_handler for irq
 argument removal
References: <20150713090726.316699641@linutronix.de>
Message-ID: <20150713090936.853458383@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The irq argument of most interrupt flow handlers is unused or merily
used instead of a local variable. The handlers which need the irq
argument can retrieve the irq number from the irq descriptor.

In this case the irq argument is shadowed by a local variable already,
so just rename it.

Search and update was done with coccinelle and the invaluable help of
Julia Lawall.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org

---
 arch/arm/plat-orion/gpio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: tip/arch/arm/plat-orion/gpio.c
===================================================================
--- tip.orig/arch/arm/plat-orion/gpio.c
+++ tip/arch/arm/plat-orion/gpio.c
@@ -407,7 +407,7 @@ static int gpio_irq_set_type(struct irq_
 	return 0;
 }
 
-static void gpio_irq_handler(unsigned irq, struct irq_desc *desc)
+static void gpio_irq_handler(unsigned __irq, struct irq_desc *desc)
 {
 	struct orion_gpio_chip *ochip = irq_desc_get_handler_data(desc);
 	u32 cause, type;
