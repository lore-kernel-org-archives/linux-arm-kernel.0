From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:36:50 +0100
Subject: [PATCH 22/54] ARM: iop33x: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130133650.GW15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-iop33x/irq.c |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-iop33x/irq.c b/arch/arm/mach-iop33x/irq.c
index abb4ea2..0ff2f74 100644
--- a/arch/arm/mach-iop33x/irq.c
+++ b/arch/arm/mach-iop33x/irq.c
@@ -53,45 +53,45 @@ static void intsize_write(u32 val)
 }
 
 static void
-iop33x_irq_mask1 (unsigned int irq)
+iop33x_irq_mask1 (struct irq_data *d)
 {
-	iop33x_mask0 &= ~(1 << irq);
+	iop33x_mask0 &= ~(1 << d->irq);
 	intctl0_write(iop33x_mask0);
 }
 
 static void
-iop33x_irq_mask2 (unsigned int irq)
+iop33x_irq_mask2 (struct irq_data *d)
 {
-	iop33x_mask1 &= ~(1 << (irq - 32));
+	iop33x_mask1 &= ~(1 << (d->irq - 32));
 	intctl1_write(iop33x_mask1);
 }
 
 static void
-iop33x_irq_unmask1(unsigned int irq)
+iop33x_irq_unmask1(struct irq_data *d)
 {
-	iop33x_mask0 |= 1 << irq;
+	iop33x_mask0 |= 1 << d->irq;
 	intctl0_write(iop33x_mask0);
 }
 
 static void
-iop33x_irq_unmask2(unsigned int irq)
+iop33x_irq_unmask2(struct irq_data *d)
 {
-	iop33x_mask1 |= (1 << (irq - 32));
+	iop33x_mask1 |= (1 << (d->irq - 32));
 	intctl1_write(iop33x_mask1);
 }
 
 struct irq_chip iop33x_irqchip1 = {
-	.name	= "IOP33x-1",
-	.ack	= iop33x_irq_mask1,
-	.mask	= iop33x_irq_mask1,
-	.unmask	= iop33x_irq_unmask1,
+	.name		= "IOP33x-1",
+	.irq_ack	= iop33x_irq_mask1,
+	.irq_mask	= iop33x_irq_mask1,
+	.irq_unmask	= iop33x_irq_unmask1,
 };
 
 struct irq_chip iop33x_irqchip2 = {
-	.name	= "IOP33x-2",
-	.ack	= iop33x_irq_mask2,
-	.mask	= iop33x_irq_mask2,
-	.unmask	= iop33x_irq_unmask2,
+	.name		= "IOP33x-2",
+	.irq_ack	= iop33x_irq_mask2,
+	.irq_mask	= iop33x_irq_mask2,
+	.irq_unmask	= iop33x_irq_unmask2,
 };
 
 void __init iop33x_init_irq(void)
-- 
1.7.1
