From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:41:06 +0100
Subject: [PATCH 34/54] ARM: nuc93x: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130134106.GI15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-nuc93x/irq.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-nuc93x/irq.c b/arch/arm/mach-nuc93x/irq.c
index a7a88ea..1f8a05a 100644
--- a/arch/arm/mach-nuc93x/irq.c
+++ b/arch/arm/mach-nuc93x/irq.c
@@ -25,9 +25,9 @@
 #include <mach/hardware.h>
 #include <mach/regs-irq.h>
 
-static void nuc93x_irq_mask(unsigned int irq)
+static void nuc93x_irq_mask(struct irq_data *d)
 {
-	__raw_writel(1 << irq, REG_AIC_MDCR);
+	__raw_writel(1 << d->irq, REG_AIC_MDCR);
 }
 
 /*
@@ -35,21 +35,21 @@ static void nuc93x_irq_mask(unsigned int irq)
  * to REG_AIC_EOSCR for ACK
  */
 
-static void nuc93x_irq_ack(unsigned int irq)
+static void nuc93x_irq_ack(struct irq_data *d)
 {
 	__raw_writel(0x01, REG_AIC_EOSCR);
 }
 
-static void nuc93x_irq_unmask(unsigned int irq)
+static void nuc93x_irq_unmask(struct irq_data *d)
 {
-	__raw_writel(1 << irq, REG_AIC_MECR);
+	__raw_writel(1 << d->irq, REG_AIC_MECR);
 
 }
 
 static struct irq_chip nuc93x_irq_chip = {
-	.ack	   = nuc93x_irq_ack,
-	.mask	   = nuc93x_irq_mask,
-	.unmask	   = nuc93x_irq_unmask,
+	.irq_ack	= nuc93x_irq_ack,
+	.irq_mask	= nuc93x_irq_mask,
+	.irq_unmask	= nuc93x_irq_unmask,
 };
 
 void __init nuc93x_init_irq(void)
-- 
1.7.1
