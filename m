From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Mon, 27 Apr 2015 21:54:23 +0900
Subject: [PATCH 1/2] genirq: MSI: Constify irq_domain_ops
Message-ID: <1430139264-4362-1-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The irq_domain_ops are not modified. The irqdomain core code accepts
pointer to a const data.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 kernel/irq/msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 474de5cb394d..7bf1f1bbb7fa 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -124,7 +124,7 @@ static void msi_domain_free(struct irq_domain *domain, unsigned int virq,
 	irq_domain_free_irqs_top(domain, virq, nr_irqs);
 }
 
-static struct irq_domain_ops msi_domain_ops = {
+static const struct irq_domain_ops msi_domain_ops = {
 	.alloc		= msi_domain_alloc,
 	.free		= msi_domain_free,
 	.activate	= msi_domain_activate,
-- 
2.1.0
