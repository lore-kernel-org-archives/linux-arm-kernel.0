From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:36:37 +0100
Subject: [PATCH 13/54] ARM: dove: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130133637.GN15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-dove/irq.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-dove/irq.c b/arch/arm/mach-dove/irq.c
index 61bfcb3..9317f05 100644
--- a/arch/arm/mach-dove/irq.c
+++ b/arch/arm/mach-dove/irq.c
@@ -36,9 +36,9 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	}
 }
 
-static void pmu_irq_mask(unsigned int irq)
+static void pmu_irq_mask(struct irq_data *d)
 {
-	int pin = irq_to_pmu(irq);
+	int pin = irq_to_pmu(d->irq);
 	u32 u;
 
 	u = readl(PMU_INTERRUPT_MASK);
@@ -46,9 +46,9 @@ static void pmu_irq_mask(unsigned int irq)
 	writel(u, PMU_INTERRUPT_MASK);
 }
 
-static void pmu_irq_unmask(unsigned int irq)
+static void pmu_irq_unmask(struct irq_data *d)
 {
-	int pin = irq_to_pmu(irq);
+	int pin = irq_to_pmu(d->irq);
 	u32 u;
 
 	u = readl(PMU_INTERRUPT_MASK);
@@ -56,9 +56,9 @@ static void pmu_irq_unmask(unsigned int irq)
 	writel(u, PMU_INTERRUPT_MASK);
 }
 
-static void pmu_irq_ack(unsigned int irq)
+static void pmu_irq_ack(struct irq_data *d)
 {
-	int pin = irq_to_pmu(irq);
+	int pin = irq_to_pmu(d->irq);
 	u32 u;
 
 	u = ~(1 << (pin & 31));
@@ -67,9 +67,9 @@ static void pmu_irq_ack(unsigned int irq)
 
 static struct irq_chip pmu_irq_chip = {
 	.name		= "pmu_irq",
-	.mask		= pmu_irq_mask,
-	.unmask		= pmu_irq_unmask,
-	.ack		= pmu_irq_ack,
+	.irq_mask	= pmu_irq_mask,
+	.irq_unmask	= pmu_irq_unmask,
+	.irq_ack	= pmu_irq_ack,
 };
 
 static void pmu_irq_handler(unsigned int irq, struct irq_desc *desc)
-- 
1.7.1
