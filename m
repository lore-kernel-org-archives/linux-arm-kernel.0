From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:36:46 +0100
Subject: [PATCH 20/54] ARM: iop13xx: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130133646.GU15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-iop13xx/irq.c |   64 +++++++++++++++++++++---------------------
 arch/arm/mach-iop13xx/msi.c |    4 +-
 2 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-iop13xx/irq.c b/arch/arm/mach-iop13xx/irq.c
index 0d099ca..a233470 100644
--- a/arch/arm/mach-iop13xx/irq.c
+++ b/arch/arm/mach-iop13xx/irq.c
@@ -123,79 +123,79 @@ static void write_intsize(u32 val)
 
 /* 0 = Interrupt Masked and 1 = Interrupt not masked */
 static void
-iop13xx_irq_mask0 (unsigned int irq)
+iop13xx_irq_mask0 (struct irq_data *d)
 {
-	write_intctl_0(read_intctl_0() & ~(1 << (irq - 0)));
+	write_intctl_0(read_intctl_0() & ~(1 << (d->irq - 0)));
 }
 
 static void
-iop13xx_irq_mask1 (unsigned int irq)
+iop13xx_irq_mask1 (struct irq_data *d)
 {
-	write_intctl_1(read_intctl_1() & ~(1 << (irq - 32)));
+	write_intctl_1(read_intctl_1() & ~(1 << (d->irq - 32)));
 }
 
 static void
-iop13xx_irq_mask2 (unsigned int irq)
+iop13xx_irq_mask2 (struct irq_data *d)
 {
-	write_intctl_2(read_intctl_2() & ~(1 << (irq - 64)));
+	write_intctl_2(read_intctl_2() & ~(1 << (d->irq - 64)));
 }
 
 static void
-iop13xx_irq_mask3 (unsigned int irq)
+iop13xx_irq_mask3 (struct irq_data *d)
 {
-	write_intctl_3(read_intctl_3() & ~(1 << (irq - 96)));
+	write_intctl_3(read_intctl_3() & ~(1 << (d->irq - 96)));
 }
 
 static void
-iop13xx_irq_unmask0(unsigned int irq)
+iop13xx_irq_unmask0(struct irq_data *d)
 {
-	write_intctl_0(read_intctl_0() | (1 << (irq - 0)));
+	write_intctl_0(read_intctl_0() | (1 << (d->irq - 0)));
 }
 
 static void
-iop13xx_irq_unmask1(unsigned int irq)
+iop13xx_irq_unmask1(struct irq_data *d)
 {
-	write_intctl_1(read_intctl_1() | (1 << (irq - 32)));
+	write_intctl_1(read_intctl_1() | (1 << (d->irq - 32)));
 }
 
 static void
-iop13xx_irq_unmask2(unsigned int irq)
+iop13xx_irq_unmask2(struct irq_data *d)
 {
-	write_intctl_2(read_intctl_2() | (1 << (irq - 64)));
+	write_intctl_2(read_intctl_2() | (1 << (d->irq - 64)));
 }
 
 static void
-iop13xx_irq_unmask3(unsigned int irq)
+iop13xx_irq_unmask3(struct irq_data *d)
 {
-	write_intctl_3(read_intctl_3() | (1 << (irq - 96)));
+	write_intctl_3(read_intctl_3() | (1 << (d->irq - 96)));
 }
 
 static struct irq_chip iop13xx_irqchip1 = {
-	.name	= "IOP13xx-1",
-	.ack    = iop13xx_irq_mask0,
-	.mask   = iop13xx_irq_mask0,
-	.unmask = iop13xx_irq_unmask0,
+	.name       = "IOP13xx-1",
+	.irq_ack    = iop13xx_irq_mask0,
+	.irq_mask   = iop13xx_irq_mask0,
+	.irq_unmask = iop13xx_irq_unmask0,
 };
 
 static struct irq_chip iop13xx_irqchip2 = {
-	.name	= "IOP13xx-2",
-	.ack    = iop13xx_irq_mask1,
-	.mask   = iop13xx_irq_mask1,
-	.unmask = iop13xx_irq_unmask1,
+	.name       = "IOP13xx-2",
+	.irq_ack    = iop13xx_irq_mask1,
+	.irq_mask   = iop13xx_irq_mask1,
+	.irq_unmask = iop13xx_irq_unmask1,
 };
 
 static struct irq_chip iop13xx_irqchip3 = {
-	.name	= "IOP13xx-3",
-	.ack    = iop13xx_irq_mask2,
-	.mask   = iop13xx_irq_mask2,
-	.unmask = iop13xx_irq_unmask2,
+	.name       = "IOP13xx-3",
+	.irq_ack    = iop13xx_irq_mask2,
+	.irq_mask   = iop13xx_irq_mask2,
+	.irq_unmask = iop13xx_irq_unmask2,
 };
 
 static struct irq_chip iop13xx_irqchip4 = {
-	.name	= "IOP13xx-4",
-	.ack    = iop13xx_irq_mask3,
-	.mask   = iop13xx_irq_mask3,
-	.unmask = iop13xx_irq_unmask3,
+	.name       = "IOP13xx-4",
+	.irq_ack    = iop13xx_irq_mask3,
+	.irq_mask   = iop13xx_irq_mask3,
+	.irq_unmask = iop13xx_irq_unmask3,
 };
 
 extern void iop_init_cp6_handler(void);
diff --git a/arch/arm/mach-iop13xx/msi.c b/arch/arm/mach-iop13xx/msi.c
index 7149fcc..c9c02e3 100644
--- a/arch/arm/mach-iop13xx/msi.c
+++ b/arch/arm/mach-iop13xx/msi.c
@@ -156,14 +156,14 @@ void arch_teardown_msi_irq(unsigned int irq)
 	destroy_irq(irq);
 }
 
-static void iop13xx_msi_nop(unsigned int irq)
+static void iop13xx_msi_nop(struct irq_data *d)
 {
 	return;
 }
 
 static struct irq_chip iop13xx_msi_chip = {
 	.name = "PCI-MSI",
-	.ack = iop13xx_msi_nop,
+	.irq_ack = iop13xx_msi_nop,
 	.irq_enable = unmask_msi_irq,
 	.irq_disable = mask_msi_irq,
 	.irq_mask = mask_msi_irq,
-- 
1.7.1
