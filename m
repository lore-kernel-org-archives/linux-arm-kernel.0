From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon,  3 Jul 2017 23:10:04 +0900
Subject: [PATCH] irqchip: constify irq_domain_ops
Message-ID: <1499091004-20909-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The core framework does not modify irq_domain_ops, so those driver
data can be qualified with 'const'.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/irqchip/irq-aspeed-vic.c     | 2 +-
 drivers/irqchip/irq-i8259.c          | 2 +-
 drivers/irqchip/irq-imx-gpcv2.c      | 2 +-
 drivers/irqchip/irq-mbigen.c         | 2 +-
 drivers/irqchip/irq-mips-gic.c       | 2 +-
 drivers/irqchip/irq-renesas-h8300h.c | 2 +-
 drivers/irqchip/irq-renesas-h8s.c    | 2 +-
 drivers/irqchip/irq-stm32-exti.c     | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-aspeed-vic.c b/drivers/irqchip/irq-aspeed-vic.c
index d24451d5bf8a..88e139e4c1f9 100644
--- a/drivers/irqchip/irq-aspeed-vic.c
+++ b/drivers/irqchip/irq-aspeed-vic.c
@@ -186,7 +186,7 @@ static int avic_map(struct irq_domain *d, unsigned int irq,
 	return 0;
 }
 
-static struct irq_domain_ops avic_dom_ops = {
+static const struct irq_domain_ops avic_dom_ops = {
 	.map = avic_map,
 	.xlate = irq_domain_xlate_onetwocell,
 };
diff --git a/drivers/irqchip/irq-i8259.c b/drivers/irqchip/irq-i8259.c
index 1aec12c6d9ac..7aafbb091b67 100644
--- a/drivers/irqchip/irq-i8259.c
+++ b/drivers/irqchip/irq-i8259.c
@@ -307,7 +307,7 @@ static int i8259A_irq_domain_map(struct irq_domain *d, unsigned int virq,
 	return 0;
 }
 
-static struct irq_domain_ops i8259A_ops = {
+static const struct irq_domain_ops i8259A_ops = {
 	.map = i8259A_irq_domain_map,
 	.xlate = irq_domain_xlate_onecell,
 };
diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
index 9463f3557e82..bb36f572e322 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -200,7 +200,7 @@ static int imx_gpcv2_domain_alloc(struct irq_domain *domain,
 					    &parent_fwspec);
 }
 
-static struct irq_domain_ops gpcv2_irqchip_data_domain_ops = {
+static const struct irq_domain_ops gpcv2_irqchip_data_domain_ops = {
 	.translate	= imx_gpcv2_domain_translate,
 	.alloc		= imx_gpcv2_domain_alloc,
 	.free		= irq_domain_free_irqs_common,
diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 31d6b5a582d2..567b29c47608 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -228,7 +228,7 @@ static int mbigen_irq_domain_alloc(struct irq_domain *domain,
 	return 0;
 }
 
-static struct irq_domain_ops mbigen_domain_ops = {
+static const struct irq_domain_ops mbigen_domain_ops = {
 	.translate	= mbigen_domain_translate,
 	.alloc		= mbigen_irq_domain_alloc,
 	.free		= irq_domain_free_irqs_common,
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 929f8558bf1c..eccea4ce4287 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -874,7 +874,7 @@ int gic_ipi_domain_match(struct irq_domain *d, struct device_node *node,
 	}
 }
 
-static struct irq_domain_ops gic_ipi_domain_ops = {
+static const struct irq_domain_ops gic_ipi_domain_ops = {
 	.xlate = gic_ipi_domain_xlate,
 	.alloc = gic_ipi_domain_alloc,
 	.free = gic_ipi_domain_free,
diff --git a/drivers/irqchip/irq-renesas-h8300h.c b/drivers/irqchip/irq-renesas-h8300h.c
index c378768d75b3..b8327590ae52 100644
--- a/drivers/irqchip/irq-renesas-h8300h.c
+++ b/drivers/irqchip/irq-renesas-h8300h.c
@@ -67,7 +67,7 @@ static int irq_map(struct irq_domain *h, unsigned int virq,
        return 0;
 }
 
-static struct irq_domain_ops irq_ops = {
+static const struct irq_domain_ops irq_ops = {
        .map    = irq_map,
        .xlate  = irq_domain_xlate_onecell,
 };
diff --git a/drivers/irqchip/irq-renesas-h8s.c b/drivers/irqchip/irq-renesas-h8s.c
index af8c6c61c824..71d8139be26c 100644
--- a/drivers/irqchip/irq-renesas-h8s.c
+++ b/drivers/irqchip/irq-renesas-h8s.c
@@ -73,7 +73,7 @@ static __init int irq_map(struct irq_domain *h, unsigned int virq,
        return 0;
 }
 
-static struct irq_domain_ops irq_ops = {
+static const struct irq_domain_ops irq_ops = {
        .map    = irq_map,
        .xlate  = irq_domain_xlate_onecell,
 };
diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 491568c95aa5..22c3cb844d8e 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -122,7 +122,7 @@ static void stm32_exti_free(struct irq_domain *d, unsigned int virq,
 	irq_domain_reset_irq_data(data);
 }
 
-struct irq_domain_ops irq_exti_domain_ops = {
+static const struct irq_domain_ops irq_exti_domain_ops = {
 	.map	= irq_map_generic_chip,
 	.xlate	= irq_domain_xlate_onetwocell,
 	.alloc  = stm32_exti_alloc,
-- 
2.7.4
