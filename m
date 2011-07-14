From: ajaykumar.rs@samsung.com (Ajay Kumar)
Date: Thu, 14 Jul 2011 09:27:12 -0400
Subject: [PATCH 2/6] ARM: S5P64X0: Add register base and IRQ for Framebuffer
In-Reply-To: <1310650036-28836-1-git-send-email-ajaykumar.rs@samsung.com>
References: <1310650036-28836-1-git-send-email-ajaykumar.rs@samsung.com>
Message-ID: <1310650036-28836-3-git-send-email-ajaykumar.rs@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds:
o Framebuffer related register mappings and bit fields.
o IRQ number being used.

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
---
 arch/arm/mach-s5p64x0/include/mach/irqs.h    |    4 ++++
 arch/arm/mach-s5p64x0/include/mach/map.h     |    3 +++
 arch/arm/mach-s5p64x0/include/mach/regs-fb.h |   19 +++++++++++++++++++
 3 files changed, 26 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5p64x0/include/mach/regs-fb.h

diff --git a/arch/arm/mach-s5p64x0/include/mach/irqs.h b/arch/arm/mach-s5p64x0/include/mach/irqs.h
index 513abff..09995b8 100644
--- a/arch/arm/mach-s5p64x0/include/mach/irqs.h
+++ b/arch/arm/mach-s5p64x0/include/mach/irqs.h
@@ -85,6 +85,10 @@
 #define IRQ_S3CUART_RX4		IRQ_S5P_UART_RX4
 #define IRQ_S3CUART_RX5		IRQ_S5P_UART_RX5
 
+#define IRQ_LCD_FIFO		IRQ_DISPCON0
+#define IRQ_LCD_VSYNC		IRQ_DISPCON1
+#define IRQ_LCD_SYSTEM		IRQ_DISPCON2
+
 /* S5P6450 EINT feature will be added */
 
 /*
diff --git a/arch/arm/mach-s5p64x0/include/mach/map.h b/arch/arm/mach-s5p64x0/include/mach/map.h
index 95c9125..c5ef50c 100644
--- a/arch/arm/mach-s5p64x0/include/mach/map.h
+++ b/arch/arm/mach-s5p64x0/include/mach/map.h
@@ -47,6 +47,8 @@
 
 #define S5P64X0_PA_HSMMC(x)	(0xED800000 + ((x) * 0x100000))
 
+#define S5P64X0_PA_FB		0xEE000000
+
 #define S5P64X0_PA_I2S		0xF2000000
 #define S5P6450_PA_I2S1		0xF2800000
 #define S5P6450_PA_I2S2		0xF2900000
@@ -64,6 +66,7 @@
 #define S3C_PA_IIC1		S5P6440_PA_IIC1
 #define S3C_PA_RTC		S5P64X0_PA_RTC
 #define S3C_PA_WDT		S5P64X0_PA_WDT
+#define S3C_PA_FB		S5P64X0_PA_FB
 
 #define S5P_PA_CHIPID		S5P64X0_PA_CHIPID
 #define S5P_PA_SROMC		S5P64X0_PA_SROMC
diff --git a/arch/arm/mach-s5p64x0/include/mach/regs-fb.h b/arch/arm/mach-s5p64x0/include/mach/regs-fb.h
new file mode 100644
index 0000000..cbb8d8c
--- /dev/null
+++ b/arch/arm/mach-s5p64x0/include/mach/regs-fb.h
@@ -0,0 +1,19 @@
+/*
+ * linux/arch/arm/mach-s5p64x0/include/mach/regs-fb.h
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * Framebuffer register definitions for Samsung S5P64X0.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_MACH_REGS_FB_H
+#define __ASM_ARCH_MACH_REGS_FB_H __FILE__
+
+#include <plat/regs-fb.h>
+
+#endif /* __ASM_ARCH_MACH_REGS_FB_H */
-- 
1.7.1
