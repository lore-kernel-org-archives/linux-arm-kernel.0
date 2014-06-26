From: r.sricharan@ti.com (Sricharan R)
Date: Thu, 26 Jun 2014 12:40:30 +0530
Subject: [PATCH V4 12/16] irqchip: crossbar: Add kerneldoc for
 crossbar_domain_unmap callback
In-Reply-To: <1403766634-18543-1-git-send-email-r.sricharan@ti.com>
References: <1403766634-18543-1-git-send-email-r.sricharan@ti.com>
Message-ID: <1403766634-18543-13-git-send-email-r.sricharan@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding kerneldoc for unmap callback function.

Signed-off-by: Sricharan R <r.sricharan@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/irqchip/irq-crossbar.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
index a8c6156..518d712 100644
--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -89,6 +89,17 @@ static int crossbar_domain_map(struct irq_domain *d, unsigned int irq,
 	return 0;
 }
 
+/**
+ * crossbar_domain_unmap - unmap a crossbar<->irq connection
+ * @d: domain of irq to unmap
+ * @irq: virq number
+ *
+ * We do not maintain a use count of total number of map/unmap
+ * calls for a particular irq to find out if a irq can be really
+ * unmapped. This is because unmap is called during irq_dispose_mapping(irq),
+ * after which irq is anyways unusable. So an explicit map has to be called
+ * after that.
+ */
 static void crossbar_domain_unmap(struct irq_domain *d, unsigned int irq)
 {
 	irq_hw_number_t hw = irq_get_irq_data(irq)->hwirq;
-- 
1.7.9.5
