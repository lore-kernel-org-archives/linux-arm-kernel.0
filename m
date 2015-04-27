From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Mon, 27 Apr 2015 21:51:59 +0900
Subject: [PATCH] ARM: EXYNOS: Constify irq_domain_ops
Message-ID: <1430139119-3721-1-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The irq_domain_ops are not modified by the driver and the irqdomain core
code accepts pointer to a const data.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 arch/arm/mach-exynos/suspend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index 3e6aea7f83af..8f0d3a8e392d 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -223,7 +223,7 @@ static int exynos_pmu_domain_alloc(struct irq_domain *domain,
 	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &parent_args);
 }
 
-static struct irq_domain_ops exynos_pmu_domain_ops = {
+static const struct irq_domain_ops exynos_pmu_domain_ops = {
 	.xlate	= exynos_pmu_domain_xlate,
 	.alloc	= exynos_pmu_domain_alloc,
 	.free	= irq_domain_free_irqs_common,
-- 
2.1.0
