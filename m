From: vkale@apm.com (Vinayak Kale)
Date: Mon, 18 Nov 2013 18:52:28 +0530
Subject: [PATCH V3 1/2] genirq: Add an accessor for IRQ_PER_CPU flag
In-Reply-To: <1384780949-10922-1-git-send-email-vkale@apm.com>
References: <1384780949-10922-1-git-send-email-vkale@apm.com>
Message-ID: <1384780949-10922-2-git-send-email-vkale@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds an accessor function for IRQ_PER_CPU flag.
The accessor function is useful to dertermine whether an IRQ is percpu or not.

Signed-off-by: Vinayak Kale <vkale@apm.com>
---
 include/linux/irqdesc.h |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 56fb646..26e2661 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -152,6 +152,14 @@ static inline int irq_balancing_disabled(unsigned int irq)
 	return desc->status_use_accessors & IRQ_NO_BALANCING_MASK;
 }
 
+static inline int irq_is_percpu(unsigned int irq)
+{
+	struct irq_desc *desc;
+
+	desc = irq_to_desc(irq);
+	return desc->status_use_accessors & IRQ_PER_CPU;
+}
+
 static inline void
 irq_set_lockdep_class(unsigned int irq, struct lock_class_key *class)
 {
-- 
1.7.9.5
