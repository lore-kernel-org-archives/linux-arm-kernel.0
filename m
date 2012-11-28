From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 28 Nov 2012 17:40:50 +0100
Subject: [PATCH] irq: versatile: delete dangling variable
Message-ID: <1354120850-15382-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This one was just creating noise like this:

drivers/irqchip/irq-versatile-fpga.c: In function 'fpga_irq_of_init':
drivers/irqchip/irq-versatile-fpga.c:180:24: warning: unused variable 'f'

Reported-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Arnd, Olof: please put this patch directly where the offending
commit is. If I understand correctly that is on the branch
integrator/irq.
---
 drivers/irqchip/irq-versatile-fpga.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/irq-versatile-fpga.c b/drivers/irqchip/irq-versatile-fpga.c
index 789b3e5..9dbd82b 100644
--- a/drivers/irqchip/irq-versatile-fpga.c
+++ b/drivers/irqchip/irq-versatile-fpga.c
@@ -177,7 +177,6 @@ void __init fpga_irq_init(void __iomem *base, const char *name, int irq_start,
 int __init fpga_irq_of_init(struct device_node *node,
 			    struct device_node *parent)
 {
-	struct fpga_irq_data *f;
 	void __iomem *base;
 	u32 clear_mask;
 	u32 valid_mask;
-- 
1.7.11.3
