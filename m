From: david@lechnology.com (David Lechner)
Date: Sun, 20 Nov 2016 22:20:34 -0600
Subject: [PATCH] ARM: davinci: Allocate spare interrupts
Message-ID: <1479702034-32489-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allocates spare interrupts for mach-davinci. These extra interrupts
are need for things like IIO triggers that define software interrupts.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/include/mach/irqs.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/include/mach/irqs.h b/arch/arm/mach-davinci/include/mach/irqs.h
index edb2ca6..2b56bb2 100644
--- a/arch/arm/mach-davinci/include/mach/irqs.h
+++ b/arch/arm/mach-davinci/include/mach/irqs.h
@@ -403,7 +403,9 @@
 
 /* da850 currently has the most gpio pins (144) */
 #define DAVINCI_N_GPIO			144
+/* Extra IRQs for things like IIO triggers */
+#define DAVINCI_N_SPARE_IRQ		16
 /* da850 currently has the most irqs so use DA850_N_CP_INTC_IRQ */
-#define NR_IRQS				(DA850_N_CP_INTC_IRQ + DAVINCI_N_GPIO)
+#define NR_IRQS (DA850_N_CP_INTC_IRQ + DAVINCI_N_GPIO + DAVINCI_N_SPARE_IRQ)
 
 #endif /* __ASM_ARCH_IRQS_H */
-- 
2.7.4
