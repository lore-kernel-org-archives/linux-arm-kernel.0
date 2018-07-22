From: martin@kaiser.cx (Martin Kaiser)
Date: Sun, 22 Jul 2018 20:02:13 +0200
Subject: [PATCH] irqchip/tango: Set irq handler and data in one go
Message-ID: <1532282533-26507-1-git-send-email-martin@kaiser.cx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the two separate calls for setting the irq handler and data with
a single irq_set_chained_handler_and_data() call.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/irqchip/irq-tango.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-tango.c b/drivers/irqchip/irq-tango.c
index 0c085303a583..580e2d72b9ba 100644
--- a/drivers/irqchip/irq-tango.c
+++ b/drivers/irqchip/irq-tango.c
@@ -205,8 +205,7 @@ static int __init tangox_irq_init(void __iomem *base, struct resource *baseres,
 
 	tangox_irq_domain_init(dom);
 
-	irq_set_chained_handler(irq, tangox_irq_handler);
-	irq_set_handler_data(irq, dom);
+	irq_set_chained_handler_and_data(irq, tangox_irq_handler, dom);
 
 	return 0;
 }
-- 
2.1.4
