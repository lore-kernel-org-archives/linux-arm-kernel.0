From: rmallon@gmail.com (Ryan Mallon)
Date: Tue, 13 Mar 2012 09:48:14 +1100
Subject: [PATCH v4 03/11] ep93xx: Move GPIO defines to gpio-ep93xx.h
Message-ID: <1331592502-9083-4-git-send-email-rmallon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the GPIO related defines out of ep93xx-regs.h and into
gpio-ep93xx.h where they belong.

Signed-off-by: Ryan Mallon <rmallon@gmail.com>
Reviewed-by: Mika Westerberg <mika.westerberg@iki.fi>
Acked-by: Hartley Sweeten <hsweeten@visionengravers.com>
---
 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |    8 --------
 arch/arm/mach-ep93xx/include/mach/gpio-ep93xx.h |   10 ++++++++++
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
index b029305..72b8687 100644
--- a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
+++ b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
@@ -64,14 +64,6 @@
 
 #define EP93XX_SECURITY_BASE		EP93XX_APB_IOMEM(0x00030000)
 
-#define EP93XX_GPIO_PHYS_BASE		EP93XX_APB_PHYS(0x00040000)
-#define EP93XX_GPIO_BASE		EP93XX_APB_IOMEM(0x00040000)
-#define EP93XX_GPIO_REG(x)		(EP93XX_GPIO_BASE + (x))
-#define EP93XX_GPIO_F_INT_STATUS	EP93XX_GPIO_REG(0x5c)
-#define EP93XX_GPIO_A_INT_STATUS	EP93XX_GPIO_REG(0xa0)
-#define EP93XX_GPIO_B_INT_STATUS	EP93XX_GPIO_REG(0xbc)
-#define EP93XX_GPIO_EEDRIVE		EP93XX_GPIO_REG(0xc8)
-
 #define EP93XX_AAC_PHYS_BASE		EP93XX_APB_PHYS(0x00080000)
 #define EP93XX_AAC_BASE			EP93XX_APB_IOMEM(0x00080000)
 
diff --git a/arch/arm/mach-ep93xx/include/mach/gpio-ep93xx.h b/arch/arm/mach-ep93xx/include/mach/gpio-ep93xx.h
index 8aff2ea..6d7c571 100644
--- a/arch/arm/mach-ep93xx/include/mach/gpio-ep93xx.h
+++ b/arch/arm/mach-ep93xx/include/mach/gpio-ep93xx.h
@@ -3,6 +3,16 @@
 #ifndef __GPIO_EP93XX_H
 #define __GPIO_EP93XX_H
 
+#include <mach/ep93xx-regs.h>
+
+#define EP93XX_GPIO_PHYS_BASE		EP93XX_APB_PHYS(0x00040000)
+#define EP93XX_GPIO_BASE		EP93XX_APB_IOMEM(0x00040000)
+#define EP93XX_GPIO_REG(x)		(EP93XX_GPIO_BASE + (x))
+#define EP93XX_GPIO_F_INT_STATUS	EP93XX_GPIO_REG(0x5c)
+#define EP93XX_GPIO_A_INT_STATUS	EP93XX_GPIO_REG(0xa0)
+#define EP93XX_GPIO_B_INT_STATUS	EP93XX_GPIO_REG(0xbc)
+#define EP93XX_GPIO_EEDRIVE		EP93XX_GPIO_REG(0xc8)
+
 /* GPIO port A.  */
 #define EP93XX_GPIO_LINE_A(x)		((x) + 0)
 #define EP93XX_GPIO_LINE_EGPIO0		EP93XX_GPIO_LINE_A(0)
-- 
1.7.0.4
