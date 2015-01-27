From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 27 Jan 2015 06:55:10 +0100
Subject: [PATCH] ARM: pxa: fix broken isa interrupts for zeus and viper
Message-ID: <1422338110-12070-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit "ARM: pxa: arbitrarily set first interrupt number" broke viper
and zeus boards which still refer to PXA_ISA_IRQ() macro. Redefine
the macro, which declares the legacy interrupts from 0 to 15.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/include/mach/irqs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-pxa/include/mach/irqs.h b/arch/arm/mach-pxa/include/mach/irqs.h
index 83e04d4..7e3ea35 100644
--- a/arch/arm/mach-pxa/include/mach/irqs.h
+++ b/arch/arm/mach-pxa/include/mach/irqs.h
@@ -14,6 +14,7 @@
 
 #include <asm/irq.h>
 
+#define PXA_ISA_IRQ(x)	(x)
 #define PXA_IRQ(x)	(NR_IRQS_LEGACY + (x))
 
 #define IRQ_SSP3	PXA_IRQ(0)	/* SSP3 service request */
-- 
2.1.0
