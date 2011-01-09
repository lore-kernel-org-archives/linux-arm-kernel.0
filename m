From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 10 Jan 2011 00:29:06 +0100
Subject: [PATCH 5/5] ARM: pxa: Fix recursive call of pxa_(un)mask_low_gpio()
In-Reply-To: <1294615746-27668-1-git-send-email-marek.vasut@gmail.com>
References: <1294615746-27668-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1294615746-27668-5-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/irq.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
index 81edf97..96571fe 100644
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -112,14 +112,14 @@ static void pxa_mask_low_gpio(unsigned int irq)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
 
-	desc->chip->mask(irq);
+	pxa_mask_irq(irq);
 }
 
 static void pxa_unmask_low_gpio(unsigned int irq)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
 
-	desc->chip->unmask(irq);
+	pxa_unmask_irq(irq);
 }
 
 static struct irq_chip pxa_low_gpio_chip = {
-- 
1.7.2.3
