From: axel.lin@ingics.com (Axel Lin)
Date: Tue, 01 Sep 2015 09:52:21 +0800
Subject: [PATCH] ARM: pxa: balloon3: Fix build error
Message-ID: <1441072341.12012.0.camel@ingics.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

irq_data_get_chip() function does not exist, call irq_desc_get_chip()
instead.

Fixes: 9ec97561aa6d ("ARM/pxa: Prepare balloon3_irq_handler for irq argument removal")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 arch/arm/mach-pxa/balloon3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index 70366b3..c1cda98 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -502,7 +502,7 @@ static void balloon3_irq_handler(unsigned int __irq, struct irq_desc *desc)
 					balloon3_irq_enabled;
 	do {
 		struct irq_data *d = irq_desc_get_irq_data(desc);
-		struct irq_chip *chip = irq_data_get_chip(d);
+		struct irq_chip *chip = irq_desc_get_chip(desc);
 		unsigned int irq;
 
 		/* clear useless edge notification */
-- 
2.1.0
