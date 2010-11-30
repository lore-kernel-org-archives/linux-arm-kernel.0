From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:36:49 +0100
Subject: [PATCH 21/54] ARM: iop32x: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130133649.GV15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-iop32x/irq.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-iop32x/irq.c b/arch/arm/mach-iop32x/irq.c
index ba59b2d..d3426a1 100644
--- a/arch/arm/mach-iop32x/irq.c
+++ b/arch/arm/mach-iop32x/irq.c
@@ -32,24 +32,24 @@ static void intstr_write(u32 val)
 }
 
 static void
-iop32x_irq_mask(unsigned int irq)
+iop32x_irq_mask(struct irq_data *d)
 {
-	iop32x_mask &= ~(1 << irq);
+	iop32x_mask &= ~(1 << d->irq);
 	intctl_write(iop32x_mask);
 }
 
 static void
-iop32x_irq_unmask(unsigned int irq)
+iop32x_irq_unmask(struct irq_data *d)
 {
-	iop32x_mask |= 1 << irq;
+	iop32x_mask |= 1 << d->irq;
 	intctl_write(iop32x_mask);
 }
 
 struct irq_chip ext_chip = {
-	.name	= "IOP32x",
-	.ack	= iop32x_irq_mask,
-	.mask	= iop32x_irq_mask,
-	.unmask	= iop32x_irq_unmask,
+	.name		= "IOP32x",
+	.irq_ack	= iop32x_irq_mask,
+	.irq_mask	= iop32x_irq_mask,
+	.irq_unmask	= iop32x_irq_unmask,
 };
 
 void __init iop32x_init_irq(void)
-- 
1.7.1
