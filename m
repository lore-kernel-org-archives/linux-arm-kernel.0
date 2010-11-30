From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:25:56 +0100
Subject: [PATCH 10/54] ARM: bcmring: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130132556.GK15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-bcmring/irq.c |   42 +++++++++++++++++++++---------------------
 1 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-bcmring/irq.c b/arch/arm/mach-bcmring/irq.c
index e315263..84dcda0 100644
--- a/arch/arm/mach-bcmring/irq.c
+++ b/arch/arm/mach-bcmring/irq.c
@@ -30,61 +30,61 @@
 #include <mach/csp/intcHw_reg.h>
 #include <mach/csp/mm_io.h>
 
-static void bcmring_mask_irq0(unsigned int irq)
+static void bcmring_mask_irq0(struct irq_data *d)
 {
-	writel(1 << (irq - IRQ_INTC0_START),
+	writel(1 << (d->irq - IRQ_INTC0_START),
 	       MM_IO_BASE_INTC0 + INTCHW_INTENCLEAR);
 }
 
-static void bcmring_unmask_irq0(unsigned int irq)
+static void bcmring_unmask_irq0(struct irq_data *d)
 {
-	writel(1 << (irq - IRQ_INTC0_START),
+	writel(1 << (d->irq - IRQ_INTC0_START),
 	       MM_IO_BASE_INTC0 + INTCHW_INTENABLE);
 }
 
-static void bcmring_mask_irq1(unsigned int irq)
+static void bcmring_mask_irq1(struct irq_data *d)
 {
-	writel(1 << (irq - IRQ_INTC1_START),
+	writel(1 << (d->irq - IRQ_INTC1_START),
 	       MM_IO_BASE_INTC1 + INTCHW_INTENCLEAR);
 }
 
-static void bcmring_unmask_irq1(unsigned int irq)
+static void bcmring_unmask_irq1(struct irq_data *d)
 {
-	writel(1 << (irq - IRQ_INTC1_START),
+	writel(1 << (d->irq - IRQ_INTC1_START),
 	       MM_IO_BASE_INTC1 + INTCHW_INTENABLE);
 }
 
-static void bcmring_mask_irq2(unsigned int irq)
+static void bcmring_mask_irq2(struct irq_data *d)
 {
-	writel(1 << (irq - IRQ_SINTC_START),
+	writel(1 << (d->irq - IRQ_SINTC_START),
 	       MM_IO_BASE_SINTC + INTCHW_INTENCLEAR);
 }
 
-static void bcmring_unmask_irq2(unsigned int irq)
+static void bcmring_unmask_irq2(struct irq_data *d)
 {
-	writel(1 << (irq - IRQ_SINTC_START),
+	writel(1 << (d->irq - IRQ_SINTC_START),
 	       MM_IO_BASE_SINTC + INTCHW_INTENABLE);
 }
 
 static struct irq_chip bcmring_irq0_chip = {
 	.name = "ARM-INTC0",
-	.ack = bcmring_mask_irq0,
-	.mask = bcmring_mask_irq0,	/* mask a specific interrupt, blocking its delivery. */
-	.unmask = bcmring_unmask_irq0,	/* unmaks an interrupt */
+	.irq_ack = bcmring_mask_irq0,
+	.irq_mask = bcmring_mask_irq0,	/* mask a specific interrupt, blocking its delivery. */
+	.irq_unmask = bcmring_unmask_irq0,	/* unmaks an interrupt */
 };
 
 static struct irq_chip bcmring_irq1_chip = {
 	.name = "ARM-INTC1",
-	.ack = bcmring_mask_irq1,
-	.mask = bcmring_mask_irq1,
-	.unmask = bcmring_unmask_irq1,
+	.irq_ack = bcmring_mask_irq1,
+	.irq_mask = bcmring_mask_irq1,
+	.irq_unmask = bcmring_unmask_irq1,
 };
 
 static struct irq_chip bcmring_irq2_chip = {
 	.name = "ARM-SINTC",
-	.ack = bcmring_mask_irq2,
-	.mask = bcmring_mask_irq2,
-	.unmask = bcmring_unmask_irq2,
+	.irq_ack = bcmring_mask_irq2,
+	.irq_mask = bcmring_mask_irq2,
+	.irq_unmask = bcmring_unmask_irq2,
 };
 
 static void vic_init(void __iomem *base, struct irq_chip *chip,
-- 
1.7.1
