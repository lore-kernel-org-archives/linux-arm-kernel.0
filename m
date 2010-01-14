From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 14 Jan 2010 12:29:29 +0100
Subject: [PATCH 11/21] ARM: S5PC1XX: add S5PC110 memory map
In-Reply-To: <1263468579-5732-1-git-send-email-m.szyprowski@samsung.com>
References: <1263468579-5732-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1263468579-5732-12-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Samsung S5PC110 SoC are newer Samsung SoCs. Like S5PC100 they are based
on CortexA8 ARM CPU, but have much more powerfull integrated periperals.
This patch adds register map for S5PC110 sub-platform.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Byungho Min <bhmin@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-s5pc110/include/mach/map.h |  154 ++++++++++++++++++++++++++++++
 1 files changed, 154 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5pc110/include/mach/map.h

diff --git a/arch/arm/mach-s5pc110/include/mach/map.h b/arch/arm/mach-s5pc110/include/mach/map.h
new file mode 100644
index 0000000..af9ce84
--- /dev/null
+++ b/arch/arm/mach-s5pc110/include/mach/map.h
@@ -0,0 +1,154 @@
+/* linux/arch/arm/mach-s5pc110/include/mach/map.h
+ *
+ * Copyright 2009 Samsung Electronics Co.
+ *	Byungho Min <bhmin@samsung.com>
+ *
+ * Based on mach-s3c6400/include/mach/map.h
+ *
+ * S5PC110 - Memory map definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_MAP_H
+#define __ASM_ARCH_MAP_H __FILE__
+
+#include <plat/map-base.h>
+
+/*
+ * map-base.h has already defined virtual memory address
+ * S3C_VA_IRQ		S3C_ADDR(0x00000000)	irq controller(s)
+ * S3C_VA_SYS		S3C_ADDR(0x00100000)	system control
+ * S3C_VA_MEM		S3C_ADDR(0x00200000)	system control (not used)
+ * S3C_VA_TIMER		S3C_ADDR(0x00300000)	timer block
+ * S3C_VA_WATCHDOG	S3C_ADDR(0x00400000)	watchdog
+ * S3C_VA_UART		S3C_ADDR(0x01000000)	UART
+ *
+ * S5PC110 specific virtual memory address can be defined here
+ * S5PC1XX_VA_GPIO	S3C_ADDR(0x00500000)	GPIO
+ *
+ */
+
+/* Chip ID */
+#define S5PC110_PA_CHIPID	(0xE0000000)
+#define S5PC1XX_PA_CHIPID	S5PC110_PA_CHIPID
+#define S5PC1XX_VA_CHIPID	S3C_VA_SYS
+
+/* System */
+#define S5PC110_PA_CLK		(0xE0100000)
+#define S5PC110_PA_PWR		(0xE010C000)
+#define S5PC1XX_PA_CLK		S5PC110_PA_CLK
+#define S5PC1XX_PA_PWR		S5PC110_PA_PWR
+#define S5PC1XX_VA_CLK		(S3C_VA_SYS + 0x10000)
+#define S5PC1XX_VA_PWR		(S3C_VA_SYS + 0x20000)
+#define S5PC1XX_SZ_CLK		SZ_32K
+#define S5PC1XX_SZ_PWR		SZ_16K
+
+/* GPIO */
+#define S5PC110_PA_GPIO		(0xE0200000)
+#define S5PC1XX_PA_GPIO		S5PC110_PA_GPIO
+#define S5PC1XX_VA_GPIO		S3C_ADDR(0x00500000)
+
+/* Interrupt */
+#define S5PC110_PA_VIC		(0xF2000000)
+#define S5PC110_PA_VIC_OFFSET	0x100000
+#define S5PC1XX_PA_VIC(x)	(S5PC110_PA_VIC + ((x) * S5PC110_PA_VIC_OFFSET))
+#define S5PC110_VA_VIC		S3C_VA_IRQ
+#define S5PC110_VA_VIC_OFFSET	0x10000
+#define S5PC1XX_VA_VIC(x)	(S5PC110_VA_VIC + ((x) * S5PC110_VA_VIC_OFFSET))
+
+/* DMA */
+#define S5PC110_PA_MDMA		(0xFA200000)
+#define S5PC110_PA_PDMA0	(0xE0900000)
+#define S5PC110_PA_PDMA1	(0xE0A00000)
+
+/* Timer */
+#define S5PC110_PA_TIMER	(0xE2500000)
+#define S5PC1XX_PA_TIMER	S5PC110_PA_TIMER
+#define S5PC1XX_VA_TIMER	S3C_VA_TIMER
+
+/* RTC */
+#define S5PC110_PA_RTC		(0xE2800000)
+#define S5PC1XX_PA_RTC		S5PC110_PA_RTC
+
+/* UART */
+#define S5PC110_PA_UART		(0xE2900000)
+#define S5PC1XX_PA_UART		S5PC110_PA_UART
+#define S5PC110_PA_UART0	(S5PC110_PA_UART + 0x0)
+#define S5PC110_PA_UART1	(S5PC110_PA_UART + 0x400)
+#define S5PC110_PA_UART2	(S5PC110_PA_UART + 0x800)
+#define S5PC110_PA_UART3	(S5PC110_PA_UART + 0xC00)
+#define S5PC1XX_VA_UART		S3C_VA_UART
+
+/* I2C */
+#define S5PC110_PA_I2C		(0xE1800000)
+#define S5PC110_PA_I2C1		(0xFAB00000)
+#define S5PC110_PA_I2C2		(0xE1A00000)
+
+/* USB HS OTG */
+#define S5PC110_PA_USB_HSOTG	(0xEC000000)
+#define S5PC110_PA_USB_HSPHY	(0xEC100000)
+
+/* SD/MMC */
+#define S5PC110_PA_HSMMC(x)	(0xEB000000 + ((x) * 0x100000))
+#define S5PC110_PA_HSMMC0	S5PC110_PA_HSMMC(0)
+#define S5PC110_PA_HSMMC1	S5PC110_PA_HSMMC(1)
+#define S5PC110_PA_HSMMC2	S5PC110_PA_HSMMC(2)
+#define S5PC110_PA_HSMMC3	S5PC110_PA_HSMMC(2)
+
+/* LCD */
+#define S5PC110_PA_FB		(0xF8000000)
+
+/* Multimedia */
+#define S5PC110_PA_MFC		(0xF1700000)
+#define S5PC110_SZ_MFC		(0x0000FFFF)
+
+/* I2S */
+#define S5PC110_PA_I2S0		(0xEEE30000)
+#define S5PC110_PA_I2S1		(0xE2100000)
+#define S5PC110_PA_I2S2		(0xE2A00000)
+
+/* KEYPAD */
+#define S5PC110_PA_KEYPAD	(0xE1600000)
+
+/* ADC & TouchScreen */
+#define S5PC110_PA_TSADC	(0xE1700000)
+
+/* ETC */
+#define S5PC110_PA_SDRAM	(0x30000000)
+#define S5PC1XX_PA_SDRAM	S5PC110_PA_SDRAM
+
+/* compatibility defines. */
+#define S3C_PA_RTC		S5PC1XX_PA_RTC
+#define S3C_PA_UART		S5PC1XX_PA_UART
+#define S3C_PA_UART0		S5PC110_PA_UART0
+#define S3C_PA_UART1		S5PC110_PA_UART1
+#define S3C_PA_UART2		S5PC110_PA_UART2
+#define S3C_PA_UART3		S5PC110_PA_UART3
+
+#define S3C_VA_UART0		(S3C_VA_UART + 0x0)
+#define S3C_VA_UART1		(S3C_VA_UART + 0x400)
+#define S3C_VA_UART2		(S3C_VA_UART + 0x800)
+#define S3C_VA_UART3		(S3C_VA_UART + 0xC00)
+#define S3C_UART_OFFSET		0x400
+#define S3C_VA_UARTx(x)		(S3C_VA_UART + ((x) * S3C_UART_OFFSET))
+
+#define S3C_PA_FB		S5PC110_PA_FB
+#define S3C_VA_VIC0		(S3C_VA_IRQ + 0x0)
+#define S3C_VA_VIC1		(S3C_VA_IRQ + 0x10000)
+#define S3C_VA_VIC2		(S3C_VA_IRQ + 0x20000)
+#define S3C_VA_VIC3		(S3C_VA_IRQ + 0x30000)
+#define S3C_PA_IIC		S5PC110_PA_I2C
+#define S3C_PA_IIC1		S5PC110_PA_I2C1
+#define S3C_PA_IIC2		S5PC110_PA_I2C2
+#define S3C_PA_USB_HSOTG	S5PC110_PA_USB_HSOTG
+#define S3C_PA_USB_HSPHY	S5PC110_PA_USB_HSPHY
+#define S3C_PA_HSMMC0		S5PC110_PA_HSMMC0
+#define S3C_PA_HSMMC1		S5PC110_PA_HSMMC1
+#define S3C_PA_HSMMC2		S5PC110_PA_HSMMC2
+#define S3C_PA_KEYPAD		S5PC110_PA_KEYPAD
+#define S3C_PA_TSADC		S5PC110_PA_TSADC
+
+#endif /* __ASM_ARCH_C100_MAP_H */
-- 
1.6.4
