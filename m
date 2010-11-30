From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:41:14 +0100
Subject: [PATCH 43/54] ARM: stmp378x: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130134114.GR15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-stmp378x/stmp378x.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-stmp378x/stmp378x.c b/arch/arm/mach-stmp378x/stmp378x.c
index ddd49a7..c2f9fe0 100644
--- a/arch/arm/mach-stmp378x/stmp378x.c
+++ b/arch/arm/mach-stmp378x/stmp378x.c
@@ -47,7 +47,7 @@
 /*
  * IRQ handling
  */
-static void stmp378x_ack_irq(unsigned int irq)
+static void stmp378x_ack_irq(struct irq_data *d)
 {
 	/* Tell ICOLL to release IRQ line */
 	__raw_writel(0, REGS_ICOLL_BASE + HW_ICOLL_VECTOR);
@@ -60,24 +60,24 @@ static void stmp378x_ack_irq(unsigned int irq)
 	(void)__raw_readl(REGS_ICOLL_BASE + HW_ICOLL_STAT);
 }
 
-static void stmp378x_mask_irq(unsigned int irq)
+static void stmp378x_mask_irq(struct irq_data *d)
 {
 	/* IRQ disable */
 	stmp3xxx_clearl(BM_ICOLL_INTERRUPTn_ENABLE,
-			REGS_ICOLL_BASE + HW_ICOLL_INTERRUPTn + irq * 0x10);
+			REGS_ICOLL_BASE + HW_ICOLL_INTERRUPTn + d->irq * 0x10);
 }
 
-static void stmp378x_unmask_irq(unsigned int irq)
+static void stmp378x_unmask_irq(struct irq_data *d)
 {
 	/* IRQ enable */
 	stmp3xxx_setl(BM_ICOLL_INTERRUPTn_ENABLE,
-		      REGS_ICOLL_BASE + HW_ICOLL_INTERRUPTn + irq * 0x10);
+		      REGS_ICOLL_BASE + HW_ICOLL_INTERRUPTn + d->irq * 0x10);
 }
 
 static struct irq_chip stmp378x_chip = {
-	.ack	= stmp378x_ack_irq,
-	.mask	= stmp378x_mask_irq,
-	.unmask = stmp378x_unmask_irq,
+	.irq_ack	= stmp378x_ack_irq,
+	.irq_mask	= stmp378x_mask_irq,
+	.irq_unmask	= stmp378x_unmask_irq,
 };
 
 void __init stmp378x_init_irq(void)
-- 
1.7.1
