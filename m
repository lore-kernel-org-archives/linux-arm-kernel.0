From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 11 Mar 2014 16:54:33 +0100
Subject: [PATCH] irqchip: sun4i: Fix acomment about mask register
 initialization
Message-ID: <1394553273-30473-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The comment was claiming that we were masking all irqs, while the code actually
*un*masks all of them.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/irqchip/irq-sun4i.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-sun4i.c b/drivers/irqchip/irq-sun4i.c
index 3761bf1..749a355 100644
--- a/drivers/irqchip/irq-sun4i.c
+++ b/drivers/irqchip/irq-sun4i.c
@@ -109,7 +109,7 @@ static int __init sun4i_of_init(struct device_node *node,
 	writel(0, sun4i_irq_base + SUN4I_IRQ_ENABLE_REG(1));
 	writel(0, sun4i_irq_base + SUN4I_IRQ_ENABLE_REG(2));
 
-	/* Mask all the interrupts */
+	/* Unmask all the interrupts, ENABLE_REG(x) is used for masking */
 	writel(0, sun4i_irq_base + SUN4I_IRQ_MASK_REG(0));
 	writel(0, sun4i_irq_base + SUN4I_IRQ_MASK_REG(1));
 	writel(0, sun4i_irq_base + SUN4I_IRQ_MASK_REG(2));
-- 
1.9.0
