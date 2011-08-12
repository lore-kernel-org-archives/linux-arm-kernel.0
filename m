From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 12 Aug 2011 15:55:01 +0800
Subject: [PATCH 6/6] arm/mxc: move IMX_GPIO_NR into mach/hardware.h
In-Reply-To: <1313135701-22456-1-git-send-email-shawn.guo@linaro.org>
References: <1313135701-22456-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1313135701-22456-7-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch moves IMX_GPIO_NR into mach/hardware.h, so that mach/gpio.h
becomes an empty header and can wait for a global removal from
asm/gpio.h.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/gpio.h     |    8 --------
 arch/arm/plat-mxc/include/mach/hardware.h |    4 ++++
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/gpio.h b/arch/arm/plat-mxc/include/mach/gpio.h
index 8e5276c..54fe5cb 100644
--- a/arch/arm/plat-mxc/include/mach/gpio.h
+++ b/arch/arm/plat-mxc/include/mach/gpio.h
@@ -19,12 +19,4 @@
 #ifndef __ASM_ARCH_MXC_GPIO_H__
 #define __ASM_ARCH_MXC_GPIO_H__
 
-#include <linux/spinlock.h>
-#include <mach/hardware.h>
-
-
-/* There's a off-by-one betweem the gpio bank number and the gpiochip */
-/* range e.g. GPIO_1_5 is gpio 5 under linux */
-#define IMX_GPIO_NR(bank, nr)		(((bank) - 1) * 32 + (nr))
-
 #endif
diff --git a/arch/arm/plat-mxc/include/mach/hardware.h b/arch/arm/plat-mxc/include/mach/hardware.h
index 77f6556..f57ec47 100644
--- a/arch/arm/plat-mxc/include/mach/hardware.h
+++ b/arch/arm/plat-mxc/include/mach/hardware.h
@@ -116,6 +116,10 @@
 	.type = _type,							\
 }
 
+/* There's a off-by-one betweem the gpio bank number and the gpiochip */
+/* range e.g. GPIO_1_5 is gpio 5 under linux */
+#define IMX_GPIO_NR(bank, nr)		(((bank) - 1) * 32 + (nr))
+
 #define IMX_GPIO_TO_IRQ(gpio)	(MXC_GPIO_IRQ_START + (gpio))
 
 #endif /* __ASM_ARCH_MXC_HARDWARE_H__ */
-- 
1.7.4.1
