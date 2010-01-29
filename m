From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 29 Jan 2010 11:06:21 +0900
Subject: [PATCH v2 3/7] ARM: S5P6442: Add IRQ support
Message-ID: <1264730781-16028-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds IRQ support for S5P6442. This patch adds interrupt
register definitions, IRQ definitions for various interrupt sources
and new VIC base for VIC2 in plat-s5p common irq code.

Signed-off-by: Adityapratap Sharma <aditya.ps@samsung.com>
Signed-off-by: Atul Dahiya <atul.dahiya@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p6442/include/mach/irqs.h     |   86 +++++++++++++++++++++++++
 arch/arm/mach-s5p6442/include/mach/regs-irq.h |   19 ++++++
 arch/arm/plat-s5p/include/plat/irqs.h         |    3 +
 arch/arm/plat-s5p/irq.c                       |    2 +
 4 files changed, 110 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5p6442/include/mach/irqs.h
 create mode 100644 arch/arm/mach-s5p6442/include/mach/regs-irq.h

diff --git a/arch/arm/mach-s5p6442/include/mach/irqs.h b/arch/arm/mach-s5p6442/include/mach/irqs.h
new file mode 100644
index 0000000..ddaf8cd
--- /dev/null
+++ b/arch/arm/mach-s5p6442/include/mach/irqs.h
@@ -0,0 +1,86 @@
+/* linux/arch/arm/mach-s5p6442/include/mach/irqs.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5P6442 - IRQ definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_IRQS_H
+#define __ASM_ARCH_IRQS_H __FILE__
+
+#include <plat/irqs.h>
+
+/* VIC0 */
+#define IRQ_EINT16_31 		S5P_IRQ_VIC0(16)
+#define IRQ_BATF 		S5P_IRQ_VIC0(17)
+#define IRQ_MDMA 		S5P_IRQ_VIC0(18)
+#define IRQ_PDMA 		S5P_IRQ_VIC0(19)
+#define IRQ_TIMER0_VIC		S5P_IRQ_VIC0(21)
+#define IRQ_TIMER1_VIC		S5P_IRQ_VIC0(22)
+#define IRQ_TIMER2_VIC		S5P_IRQ_VIC0(23)
+#define IRQ_TIMER3_VIC		S5P_IRQ_VIC0(24)
+#define IRQ_TIMER4_VIC		S5P_IRQ_VIC0(25)
+#define IRQ_SYSTIMER		S5P_IRQ_VIC0(26)
+#define IRQ_WDT			S5P_IRQ_VIC0(27)
+#define IRQ_RTC_ALARM		S5P_IRQ_VIC0(28)
+#define IRQ_RTC_TIC		S5P_IRQ_VIC0(29)
+#define IRQ_GPIOINT		S5P_IRQ_VIC0(30)
+
+/* VIC1 */
+#define IRQ_nPMUIRQ 		S5P_IRQ_VIC1(0)
+#define IRQ_ONENAND 		S5P_IRQ_VIC1(7)
+#define IRQ_UART0 		S5P_IRQ_VIC1(10)
+#define IRQ_UART1 		S5P_IRQ_VIC1(11)
+#define IRQ_UART2 		S5P_IRQ_VIC1(12)
+#define IRQ_SPI0 		S5P_IRQ_VIC1(15)
+#define IRQ_IIC 		S5P_IRQ_VIC1(19)
+#define IRQ_IIC1 		S5P_IRQ_VIC1(20)
+#define IRQ_IIC2 		S5P_IRQ_VIC1(21)
+#define IRQ_OTG 		S5P_IRQ_VIC1(24)
+#define IRQ_MSM 		S5P_IRQ_VIC1(25)
+#define IRQ_HSMMC0 		S5P_IRQ_VIC1(26)
+#define IRQ_HSMMC1 		S5P_IRQ_VIC1(27)
+#define IRQ_HSMMC2 		S5P_IRQ_VIC1(28)
+#define IRQ_COMMRX 		S5P_IRQ_VIC1(29)
+#define IRQ_COMMTX 		S5P_IRQ_VIC1(30)
+
+/* VIC2 */
+#define IRQ_LCD0 		S5P_IRQ_VIC2(0)
+#define IRQ_LCD1 		S5P_IRQ_VIC2(1)
+#define IRQ_LCD2 		S5P_IRQ_VIC2(2)
+#define IRQ_LCD3 		S5P_IRQ_VIC2(3)
+#define IRQ_ROTATOR 		S5P_IRQ_VIC2(4)
+#define IRQ_FIMC0 		S5P_IRQ_VIC2(5)
+#define IRQ_FIMC1 		S5P_IRQ_VIC2(6)
+#define IRQ_FIMC2 		S5P_IRQ_VIC2(7)
+#define IRQ_JPEG 		S5P_IRQ_VIC2(8)
+#define IRQ_3D 			S5P_IRQ_VIC2(10)
+#define IRQ_Mixer 		S5P_IRQ_VIC2(11)
+#define IRQ_MFC 		S5P_IRQ_VIC2(14)
+#define IRQ_TVENC 		S5P_IRQ_VIC2(15)
+#define IRQ_I2S0 		S5P_IRQ_VIC2(16)
+#define IRQ_I2S1 		S5P_IRQ_VIC2(17)
+#define IRQ_RP 			S5P_IRQ_VIC2(19)
+#define IRQ_PCM0 		S5P_IRQ_VIC2(20)
+#define IRQ_PCM1 		S5P_IRQ_VIC2(21)
+#define IRQ_ADC 		S5P_IRQ_VIC2(23)
+#define IRQ_PENDN 		S5P_IRQ_VIC2(24)
+#define IRQ_KEYPAD 		S5P_IRQ_VIC2(25)
+#define IRQ_SSS_INT 		S5P_IRQ_VIC2(27)
+#define IRQ_SSS_HASH 		S5P_IRQ_VIC2(28)
+#define IRQ_VIC_END 		S5P_IRQ_VIC2(31)
+
+#define S5P_IRQ_EINT_BASE	(IRQ_VIC_END + 1)
+
+#define IRQ_EINT(x)             ((x) < 16 ? S5P_IRQ_VIC0(x) : \
+					(S5P_IRQ_EINT_BASE + (x)-16))
+/* Set the default NR_IRQS */
+
+#define NR_IRQS 		(IRQ_EINT(31) + 1)
+
+#endif /* __ASM_ARCH_IRQS_H */
diff --git a/arch/arm/mach-s5p6442/include/mach/regs-irq.h b/arch/arm/mach-s5p6442/include/mach/regs-irq.h
new file mode 100644
index 0000000..73782b5
--- /dev/null
+++ b/arch/arm/mach-s5p6442/include/mach/regs-irq.h
@@ -0,0 +1,19 @@
+/* linux/arch/arm/mach-s5p6442/include/mach/regs-irq.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5P6442 - IRQ register definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_REGS_IRQ_H
+#define __ASM_ARCH_REGS_IRQ_H __FILE__
+
+#include <asm/hardware/vic.h>
+#include <mach/map.h>
+
+#endif /* __ASM_ARCH_REGS_IRQ_H */
diff --git a/arch/arm/plat-s5p/include/plat/irqs.h b/arch/arm/plat-s5p/include/plat/irqs.h
index 878acfe..46e5a77 100644
--- a/arch/arm/plat-s5p/include/plat/irqs.h
+++ b/arch/arm/plat-s5p/include/plat/irqs.h
@@ -28,11 +28,13 @@
 
 #define S5P_VIC0_BASE		S5P_IRQ(0)
 #define S5P_VIC1_BASE		S5P_IRQ(32)
+#define S5P_VIC2_BASE		S5P_IRQ(64)
 
 #define VIC_BASE(x)		(S5P_VIC0_BASE + ((x)*32))
 
 #define IRQ_VIC0_BASE		S5P_VIC0_BASE
 #define IRQ_VIC1_BASE		S5P_VIC1_BASE
+#define IRQ_VIC2_BASE		S5P_VIC2_BASE
 
 /* UART interrupts, each UART has 4 intterupts per channel so
  * use the space between the ISA and S3C main interrupts. Note, these
@@ -73,6 +75,7 @@
 
 #define S5P_IRQ_VIC0(x)		(S5P_VIC0_BASE + (x))
 #define S5P_IRQ_VIC1(x)		(S5P_VIC1_BASE + (x))
+#define S5P_IRQ_VIC2(x)		(S5P_VIC2_BASE + (x))
 
 #define S5P_TIMER_IRQ(x)	S5P_IRQ(11 + (x))
 
diff --git a/arch/arm/plat-s5p/irq.c b/arch/arm/plat-s5p/irq.c
index 11535a5..25e1eb6 100644
--- a/arch/arm/plat-s5p/irq.c
+++ b/arch/arm/plat-s5p/irq.c
@@ -45,11 +45,13 @@ static struct s3c_uart_irq uart_irqs[] = {
 		.base_irq	= IRQ_S5P_UART_BASE2,
 		.parent_irq	= IRQ_UART2,
 	},
+#if CONFIG_SERIAL_SAMSUNG_UARTS > 3
 	[3] = {
 		.regs		= S5P_VA_UART3,
 		.base_irq	= IRQ_S5P_UART_BASE3,
 		.parent_irq	= IRQ_UART3,
 	},
+#endif
 };
 
 void __init s5p_init_irq(u32 *vic, u32 num_vic)
-- 
1.6.2.5
