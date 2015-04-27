From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Mon, 27 Apr 2015 21:50:46 +0900
Subject: [PATCH] ARM: pxa: Constify irq_domain_ops
Message-ID: <1430139046-3618-1-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The irq_domain_ops are not modified by the driver and the irqdomain core
code accepts pointer to a const data.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 arch/arm/mach-pxa/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
index 89a7c06570d3..98608c5575cb 100644
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -138,7 +138,7 @@ static int pxa_irq_map(struct irq_domain *h, unsigned int virq,
 	return 0;
 }
 
-static struct irq_domain_ops pxa_irq_ops = {
+static const struct irq_domain_ops pxa_irq_ops = {
 	.map    = pxa_irq_map,
 	.xlate  = irq_domain_xlate_onecell,
 };
-- 
2.1.0
