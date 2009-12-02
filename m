From: mcuos.com@gmail.com (Wan ZongShun)
Date: Wed, 02 Dec 2009 21:51:06 +0800
Subject: [PATCH 1/4]ARM: NUC900: change condition of IRQ_ADC to NR_IRQS for
	nuc932
Message-ID: <4B1670CA.5070500@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Russell,

For applying to nuc932, I modified the 'for' loop condition.

Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
---
 arch/arm/mach-w90x900/irq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-w90x900/irq.c b/arch/arm/mach-w90x900/irq.c
index 5444a27..633ac8b 100644
--- a/arch/arm/mach-w90x900/irq.c
+++ b/arch/arm/mach-w90x900/irq.c
@@ -73,7 +73,7 @@ void __init nuc900_init_irq(void)
 
 	__raw_writel(0xFFFFFFFE, REG_AIC_MDCR);
 
-	for (irqno = IRQ_WDT; irqno <= IRQ_ADC; irqno++) {
+	for (irqno = IRQ_WDT; irqno < NR_IRQS; irqno++) {
 		set_irq_chip(irqno, &nuc900_irq_chip);
 		set_irq_handler(irqno, handle_level_irq);
 		set_irq_flags(irqno, IRQF_VALID);
-- 
1.5.6.3
