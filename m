From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  7 Dec 2015 10:11:11 +0000
Subject: [PATCH 1/2] irqchip/gic-v3: Add missing struct device_node declaration
In-Reply-To: <1449483072-17694-1-git-send-email-marc.zyngier@arm.com>
References: <1449483072-17694-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1449483072-17694-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the GICv3 header file is used in a C file that doesn't include
any of the OF stuff, we end up with a bunch of ugly warnings.

Let's keep GCC quiet by adding a forward declaration.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/linux/irqchip/arm-gic-v3.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index c9ae0c6..d5d798b 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -330,6 +330,7 @@ struct rdists {
 };
 
 struct irq_domain;
+struct device_node;
 int its_cpu_init(void);
 int its_init(struct device_node *node, struct rdists *rdists,
 	     struct irq_domain *domain);
-- 
2.1.4
