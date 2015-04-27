From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Mon, 27 Apr 2015 21:49:12 +0900
Subject: [PATCH] ARM: sa1100: Constify irq_domain_ops
Message-ID: <1430138952-3410-1-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The irq_domain_ops are not modified by the driver and the irqdomain core
code accepts pointer to a const data.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 arch/arm/mach-sa1100/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-sa1100/irq.c b/arch/arm/mach-sa1100/irq.c
index 65aebfa66fe5..ea3eb4144b66 100644
--- a/arch/arm/mach-sa1100/irq.c
+++ b/arch/arm/mach-sa1100/irq.c
@@ -73,7 +73,7 @@ static int sa1100_normal_irqdomain_map(struct irq_domain *d,
 	return 0;
 }
 
-static struct irq_domain_ops sa1100_normal_irqdomain_ops = {
+static const struct irq_domain_ops sa1100_normal_irqdomain_ops = {
 	.map = sa1100_normal_irqdomain_map,
 	.xlate = irq_domain_xlate_onetwocell,
 };
-- 
2.1.0
