From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Mon, 27 Apr 2015 21:51:39 +0900
Subject: [PATCH] ARM: imx: Constify irq_domain_ops
Message-ID: <1430139099-3673-1-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The irq_domain_ops are not modified by the driver and the irqdomain core
code accepts pointer to a const data.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 arch/arm/mach-imx/gpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index 4d60005e9277..9051dc02dc79 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -227,7 +227,7 @@ static int imx_gpc_domain_alloc(struct irq_domain *domain,
 	return irq_domain_alloc_irqs_parent(domain, irq, nr_irqs, &parent_args);
 }
 
-static struct irq_domain_ops imx_gpc_domain_ops = {
+static const struct irq_domain_ops imx_gpc_domain_ops = {
 	.xlate	= imx_gpc_domain_xlate,
 	.alloc	= imx_gpc_domain_alloc,
 	.free	= irq_domain_free_irqs_common,
-- 
2.1.0
