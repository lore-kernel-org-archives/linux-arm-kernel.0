From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 20 Dec 2012 19:53:41 +0100
Subject: [PATCH 1/2] ARM: versatile: bump IRQ numbers
Message-ID: <1356029621-30203-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The Versatile starts to register Linux IRQ numbers from offset 0
which is illegal, since this is NO_IRQ. Bump all hard-coded IRQs
by 32 to get rid of the problem.

Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-versatile/include/mach/irqs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-versatile/include/mach/irqs.h b/arch/arm/mach-versatile/include/mach/irqs.h
index bf44c61..0fd771c 100644
--- a/arch/arm/mach-versatile/include/mach/irqs.h
+++ b/arch/arm/mach-versatile/include/mach/irqs.h
@@ -25,7 +25,7 @@
  *  IRQ interrupts definitions are the same as the INT definitions
  *  held within platform.h
  */
-#define IRQ_VIC_START		0
+#define IRQ_VIC_START		32
 #define IRQ_WDOGINT		(IRQ_VIC_START + INT_WDOGINT)
 #define IRQ_SOFTINT		(IRQ_VIC_START + INT_SOFTINT)
 #define IRQ_COMMRx		(IRQ_VIC_START + INT_COMMRx)
@@ -100,7 +100,7 @@
 /*
  * Secondary interrupt controller
  */
-#define IRQ_SIC_START		32
+#define IRQ_SIC_START		64
 #define IRQ_SIC_MMCI0B 		(IRQ_SIC_START + SIC_INT_MMCI0B)
 #define IRQ_SIC_MMCI1B 		(IRQ_SIC_START + SIC_INT_MMCI1B)
 #define IRQ_SIC_KMI0		(IRQ_SIC_START + SIC_INT_KMI0)
@@ -120,7 +120,7 @@
 #define IRQ_SIC_PCI1		(IRQ_SIC_START + SIC_INT_PCI1)
 #define IRQ_SIC_PCI2		(IRQ_SIC_START + SIC_INT_PCI2)
 #define IRQ_SIC_PCI3		(IRQ_SIC_START + SIC_INT_PCI3)
-#define IRQ_SIC_END		63
+#define IRQ_SIC_END		95
 
 #define IRQ_GPIO0_START		(IRQ_SIC_END + 1)
 #define IRQ_GPIO0_END		(IRQ_GPIO0_START + 31)
-- 
1.7.11.3
