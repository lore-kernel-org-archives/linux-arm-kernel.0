From: vkale@apm.com (Vinayak Kale)
Date: Mon,  2 Dec 2013 15:04:02 +0530
Subject: [PATCH V6 1/2] genirq: Add an accessor for IRQ_PER_CPU flag
In-Reply-To: <1385976843-13280-1-git-send-email-vkale@apm.com>
References: <1385976843-13280-1-git-send-email-vkale@apm.com>
Message-ID: <1385976843-13280-2-git-send-email-vkale@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds an accessor function for IRQ_PER_CPU flag.
The accessor function is useful to determine whether an IRQ is percpu or not.

This patch is based on an older patch posted by Chris Smith here [1].
There is a minor change w.r.t. Chris's original patch: The accessor function
is renamed as 'irq_is_percpu' instead of 'irq_is_per_cpu'.

[1]: http://lkml.indiana.edu/hypermail/linux/kernel/1207.3/02955.html

Signed-off-by: Chris Smith <chris.smith@st.com>
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
