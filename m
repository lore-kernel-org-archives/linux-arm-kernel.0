From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed,  8 Jun 2016 19:02:20 +0100
Subject: [PATCH] irqchip/brcmstb-l2: make of probe function static
Message-ID: <1465408940-16414-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The probe functions in this driver is not exported or declared
so make it static to fix the following warning:

drivers/irqchip/irq-brcmstb-l2.c:115:12: warning: symbol 'brcmstb_l2_intc_of_init' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Kevin Cernekee <cernekee@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/irqchip/irq-brcmstb-l2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index 65cd341..1d4a5b4 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -112,8 +112,8 @@ static void brcmstb_l2_intc_resume(struct irq_data *d)
 	irq_gc_unlock(gc);
 }
 
-int __init brcmstb_l2_intc_of_init(struct device_node *np,
-					struct device_node *parent)
+static int __init brcmstb_l2_intc_of_init(struct device_node *np,
+					  struct device_node *parent)
 {
 	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
 	struct brcmstb_l2_intc_data *data;
-- 
2.8.1
