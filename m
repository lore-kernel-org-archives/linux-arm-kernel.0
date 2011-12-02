From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri,  2 Dec 2011 14:30:09 +0100
Subject: [PATCH v2] irqdomain: protect macro variable in domain iterators
In-Reply-To: <1322833997-32083-1-git-send-email-nicolas.ferre@atmel.com>
References: <1322833997-32083-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <1322832609-24956-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
v2: add brackets to each macro variable.

 include/linux/irqdomain.h |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index bd4272b..e535063 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -82,12 +82,14 @@ static inline unsigned int irq_domain_to_irq(struct irq_domain *d,
 }
 
 #define irq_domain_for_each_hwirq(d, hw) \
-	for (hw = d->hwirq_base; hw < d->hwirq_base + d->nr_irq; hw++)
+	for ((hw) = (d)->hwirq_base; \
+	     (hw) < (d)->hwirq_base + (d)->nr_irq; \
+	     (hw)++)
 
 #define irq_domain_for_each_irq(d, hw, irq) \
-	for (hw = d->hwirq_base, irq = irq_domain_to_irq(d, hw); \
-	     hw < d->hwirq_base + d->nr_irq; \
-	     hw++, irq = irq_domain_to_irq(d, hw))
+	for ((hw) = (d)->hwirq_base, (irq) = irq_domain_to_irq((d), (hw)); \
+	     (hw) < (d)->hwirq_base + (d)->nr_irq; \
+	     (hw)++, (irq) = irq_domain_to_irq((d), (hw)))
 
 extern void irq_domain_add(struct irq_domain *domain);
 extern void irq_domain_del(struct irq_domain *domain);
-- 
1.7.5.4
