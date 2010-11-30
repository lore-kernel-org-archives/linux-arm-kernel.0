From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:41:17 +0100
Subject: [PATCH 45/54] ARM: tcc8k: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130134117.GT15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-tcc8k/irq.c |   56 ++++++++++++++++++++++----------------------
 1 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-tcc8k/irq.c b/arch/arm/mach-tcc8k/irq.c
index 34575c4..aa9231f 100644
--- a/arch/arm/mach-tcc8k/irq.c
+++ b/arch/arm/mach-tcc8k/irq.c
@@ -18,65 +18,65 @@
 #include "common.h"
 
 /* Disable IRQ */
-static void tcc8000_mask_ack_irq0(unsigned int irq)
+static void tcc8000_mask_ack_irq0(struct irq_data *d)
 {
-	PIC0_IEN &= ~(1 << irq);
-	PIC0_CREQ |=  (1 << irq);
+	PIC0_IEN &= ~(1 << d->irq);
+	PIC0_CREQ |=  (1 << d->irq);
 }
 
-static void tcc8000_mask_ack_irq1(unsigned int irq)
+static void tcc8000_mask_ack_irq1(struct irq_data *d)
 {
-	PIC1_IEN &= ~(1 << (irq - 32));
-	PIC1_CREQ |= (1 << (irq - 32));
+	PIC1_IEN &= ~(1 << (d->irq - 32));
+	PIC1_CREQ |= (1 << (d->irq - 32));
 }
 
-static void tcc8000_mask_irq0(unsigned int irq)
+static void tcc8000_mask_irq0(struct irq_data *d)
 {
-	PIC0_IEN &= ~(1 << irq);
+	PIC0_IEN &= ~(1 << d->irq);
 }
 
-static void tcc8000_mask_irq1(unsigned int irq)
+static void tcc8000_mask_irq1(struct irq_data *d)
 {
-	PIC1_IEN &= ~(1 << (irq - 32));
+	PIC1_IEN &= ~(1 << (d->irq - 32));
 }
 
-static void tcc8000_ack_irq0(unsigned int irq)
+static void tcc8000_ack_irq0(struct irq_data *d)
 {
-	PIC0_CREQ |=  (1 << irq);
+	PIC0_CREQ |=  (1 << d->irq);
 }
 
-static void tcc8000_ack_irq1(unsigned int irq)
+static void tcc8000_ack_irq1(struct irq_data *d)
 {
-	PIC1_CREQ |= (1 << (irq - 32));
+	PIC1_CREQ |= (1 << (d->irq - 32));
 }
 
 /* Enable IRQ */
-static void tcc8000_unmask_irq0(unsigned int irq)
+static void tcc8000_unmask_irq0(struct irq_data *d)
 {
-	PIC0_IEN |= (1 << irq);
-	PIC0_INTOEN |= (1 << irq);
+	PIC0_IEN |= (1 << d->irq);
+	PIC0_INTOEN |= (1 << d->irq);
 }
 
-static void tcc8000_unmask_irq1(unsigned int irq)
+static void tcc8000_unmask_irq1(struct irq_data *d)
 {
-	PIC1_IEN |= (1 << (irq - 32));
-	PIC1_INTOEN |= (1 << (irq - 32));
+	PIC1_IEN |= (1 << (d->irq - 32));
+	PIC1_INTOEN |= (1 << (d->irq - 32));
 }
 
 static struct irq_chip tcc8000_irq_chip0 = {
 	.name		= "tcc_irq0",
-	.mask		= tcc8000_mask_irq0,
-	.ack		= tcc8000_ack_irq0,
-	.mask_ack	= tcc8000_mask_ack_irq0,
-	.unmask		= tcc8000_unmask_irq0,
+	.irq_mask	= tcc8000_mask_irq0,
+	.irq_ack	= tcc8000_ack_irq0,
+	.irq_mask_ack	= tcc8000_mask_ack_irq0,
+	.irq_unmask	= tcc8000_unmask_irq0,
 };
 
 static struct irq_chip tcc8000_irq_chip1 = {
 	.name		= "tcc_irq1",
-	.mask		= tcc8000_mask_irq1,
-	.ack		= tcc8000_ack_irq1,
-	.mask_ack	= tcc8000_mask_ack_irq1,
-	.unmask		= tcc8000_unmask_irq1,
+	.irq_mask	= tcc8000_mask_irq1,
+	.irq_ack	= tcc8000_ack_irq1,
+	.irq_mask_ack	= tcc8000_mask_ack_irq1,
+	.irq_unmask	= tcc8000_unmask_irq1,
 };
 
 void __init tcc8k_init_irq(void)
-- 
1.7.1
