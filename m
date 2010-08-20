From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 20 Aug 2010 19:21:26 +0900
Subject: [PATCH] ARM: S5PV310: Fix on typo irqs.h of S5PV310
Message-ID: <1282299686-5143-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes typo 'IRQ_WTD'(?) in the irqs.h of S5PV310.
And minor update comments.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv310/include/mach/irqs.h |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-s5pv310/include/mach/irqs.h b/arch/arm/mach-s5pv310/include/mach/irqs.h
index 56885ca..4cdedda 100644
--- a/arch/arm/mach-s5pv310/include/mach/irqs.h
+++ b/arch/arm/mach-s5pv310/include/mach/irqs.h
@@ -15,12 +15,14 @@
 
 #include <plat/irqs.h>
 
-/* Private Peripheral Interrupt */
+/* PPI: Private Peripheral Interrupt */
+
 #define IRQ_PPI(x)		S5P_IRQ(x+16)
 
 #define IRQ_LOCALTIMER		IRQ_PPI(13)
 
-/* Shared Peripheral Interrupt */
+/* SPI: Shared Peripheral Interrupt */
+
 #define IRQ_SPI(x)		S5P_IRQ(x+32)
 
 #define IRQ_EINT0		IRQ_SPI(40)
@@ -36,7 +38,7 @@
 #define IRQ_PCIE		IRQ_SPI(50)
 #define IRQ_SYSTEM_TIMER	IRQ_SPI(51)
 #define IRQ_MFC			IRQ_SPI(52)
-#define IRQ_WTD			IRQ_SPI(53)
+#define IRQ_WDT			IRQ_SPI(53)
 #define IRQ_AUDIO_SS		IRQ_SPI(54)
 #define IRQ_AC97		IRQ_SPI(55)
 #define IRQ_SPDIF		IRQ_SPI(56)
@@ -67,8 +69,9 @@
 #define IRQ_IIC			COMBINER_IRQ(27, 0)
 
 /* Set the default NR_IRQS */
+
 #define NR_IRQS			COMBINER_IRQ(MAX_COMBINER_NR, 0)
 
 #define MAX_COMBINER_NR		39
 
-#endif /* ASM_ARCH_IRQS_H */
+#endif /* __ASM_ARCH_IRQS_H */
-- 
1.6.2.5
