From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:41:19 +0100
Subject: [PATCH 47/54] ARM: versatile: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130134119.GV15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-versatile/core.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index e38acb0..9b9b6fa 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -62,23 +62,23 @@
 #define VA_VIC_BASE		__io_address(VERSATILE_VIC_BASE)
 #define VA_SIC_BASE		__io_address(VERSATILE_SIC_BASE)
 
-static void sic_mask_irq(unsigned int irq)
+static void sic_mask_irq(struct irq_data *d)
 {
-	irq -= IRQ_SIC_START;
+	unsigned int irq = d->irq - IRQ_SIC_START;
 	writel(1 << irq, VA_SIC_BASE + SIC_IRQ_ENABLE_CLEAR);
 }
 
-static void sic_unmask_irq(unsigned int irq)
+static void sic_unmask_irq(struct irq_data *d)
 {
-	irq -= IRQ_SIC_START;
+	unsigned int irq = d->irq - IRQ_SIC_START;
 	writel(1 << irq, VA_SIC_BASE + SIC_IRQ_ENABLE_SET);
 }
 
 static struct irq_chip sic_chip = {
-	.name	= "SIC",
-	.ack	= sic_mask_irq,
-	.mask	= sic_mask_irq,
-	.unmask	= sic_unmask_irq,
+	.name		= "SIC",
+	.irq_ack	= sic_mask_irq,
+	.irq_mask	= sic_mask_irq,
+	.irq_unmask	= sic_unmask_irq,
 };
 
 static void
-- 
1.7.1
