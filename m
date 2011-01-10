From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 10 Jan 2011 23:53:13 +0100
Subject: [PATCH 5/5 v2] ARM: pxa: Fix recursive call of pxa_(un)mask_low_gpio()
In-Reply-To: <1294699993-4712-1-git-send-email-marek.vasut@gmail.com>
References: <1294699993-4712-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1294699993-4712-5-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
v2: Remove dead code as proposed by Sergei

 arch/arm/mach-pxa/irq.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
index a7deff5..76e69cf 100644
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -110,16 +110,12 @@ static void pxa_ack_low_gpio(unsigned int irq)
 
 static void pxa_mask_low_gpio(unsigned int irq)
 {
-	struct irq_desc *desc = irq_to_desc(irq);
-
-	desc->chip->mask(irq);
+	pxa_mask_irq(irq);
 }
 
 static void pxa_unmask_low_gpio(unsigned int irq)
 {
-	struct irq_desc *desc = irq_to_desc(irq);
-
-	desc->chip->unmask(irq);
+	pxa_unmask_irq(irq);
 }
 
 static struct irq_chip pxa_low_gpio_chip = {
-- 
1.7.2.3
