From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 14 Aug 2011 00:14:05 +0800
Subject: [PATCH v2 6/8] arm/mxc: move IMX_GPIO_NR into mach/hardware.h
In-Reply-To: <1313252047-8820-1-git-send-email-shawn.guo@linaro.org>
References: <1313252047-8820-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1313252047-8820-7-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch moves IMX_GPIO_NR into mach/hardware.h, so that mach/gpio.h
becomes an empty header and can wait for a global removal from
asm/gpio.h.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/plat-mxc/include/mach/gpio.h     |   31 +----------------------------
 arch/arm/plat-mxc/include/mach/hardware.h |    4 +++
 2 files changed, 5 insertions(+), 30 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/gpio.h b/arch/arm/plat-mxc/include/mach/gpio.h
index 8e5276c..40a8c17 100644
--- a/arch/arm/plat-mxc/include/mach/gpio.h
+++ b/arch/arm/plat-mxc/include/mach/gpio.h
@@ -1,30 +1 @@
-/*
- * Copyright 2007 Freescale Semiconductor, Inc. All Rights Reserved.
- * Copyright 2008 Juergen Beisert, kernel at pengutronix.de
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
- */
-
-#ifndef __ASM_ARCH_MXC_GPIO_H__
-#define __ASM_ARCH_MXC_GPIO_H__
-
-#include <linux/spinlock.h>
-#include <mach/hardware.h>
-
-
-/* There's a off-by-one betweem the gpio bank number and the gpiochip */
-/* range e.g. GPIO_1_5 is gpio 5 under linux */
-#define IMX_GPIO_NR(bank, nr)		(((bank) - 1) * 32 + (nr))
-
-#endif
+/* empty */
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
