From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:25:52 +0100
Subject: [PATCH 08/54] ARM: aaec2000: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130132552.GI15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-aaec2000/core.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-aaec2000/core.c b/arch/arm/mach-aaec2000/core.c
index 3ef6833..f8465bd 100644
--- a/arch/arm/mach-aaec2000/core.c
+++ b/arch/arm/mach-aaec2000/core.c
@@ -68,25 +68,25 @@ void __init aaec2000_map_io(void)
 /*
  * Interrupt handling routines
  */
-static void aaec2000_int_ack(unsigned int irq)
+static void aaec2000_int_ack(struct irq_data *d)
 {
-	IRQ_INTSR = 1 << irq;
+	IRQ_INTSR = 1 << d->irq;
 }
 
-static void aaec2000_int_mask(unsigned int irq)
+static void aaec2000_int_mask(struct irq_data *d)
 {
-	IRQ_INTENC |= (1 << irq);
+	IRQ_INTENC |= (1 << d->irq);
 }
 
-static void aaec2000_int_unmask(unsigned int irq)
+static void aaec2000_int_unmask(struct irq_data *d)
 {
-	IRQ_INTENS |= (1 << irq);
+	IRQ_INTENS |= (1 << d->irq);
 }
 
 static struct irq_chip aaec2000_irq_chip = {
-	.ack	= aaec2000_int_ack,
-	.mask	= aaec2000_int_mask,
-	.unmask	= aaec2000_int_unmask,
+	.irq_ack	= aaec2000_int_ack,
+	.irq_mask	= aaec2000_int_mask,
+	.irq_unmask	= aaec2000_int_unmask,
 };
 
 void __init aaec2000_init_irq(void)
-- 
1.7.1
