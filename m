From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 22 Jan 2017 13:23:43 +0100
Subject: [PATCH 19/22] ARM: gemini: switch to sparse IRQs
Message-ID: <20170122122343.11010-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no boardfiles or anything else using the fixed IRQs
anymore, switch the platform to use sparse IRQs and delete
the <mach/irqs.h> header.

Cc: Janos Laube <janos.dev@gmail.com>
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig                         |  1 +
 arch/arm/mach-gemini/include/mach/irqs.h | 53 --------------------------------
 2 files changed, 1 insertion(+), 53 deletions(-)
 delete mode 100644 arch/arm/mach-gemini/include/mach/irqs.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1b01eb5e2cea..2c448dc49467 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -367,6 +367,7 @@ config ARCH_GEMINI
 	select POWER_RESET
 	select POWER_RESET_SYSCON
 	select SERIAL_OF_PLATFORM
+	select SPARSE_IRQ
 	select USE_OF
 	help
 	  Support for the Cortina Systems Gemini family SoCs
diff --git a/arch/arm/mach-gemini/include/mach/irqs.h b/arch/arm/mach-gemini/include/mach/irqs.h
deleted file mode 100644
index 06bc47e77e8b..000000000000
--- a/arch/arm/mach-gemini/include/mach/irqs.h
+++ /dev/null
@@ -1,53 +0,0 @@
-/*
- *  Copyright (C) 2001-2006 Storlink, Corp.
- *  Copyright (C) 2008-2009 Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#ifndef __MACH_IRQS_H__
-#define __MACH_IRQS_H__
-
-#define IRQ_SERIRQ1	31
-#define IRQ_SERIRQ0	30
-#define IRQ_PCID	29
-#define IRQ_PCIC	28
-#define IRQ_PCIB	27
-#define IRQ_PWR		26
-#define IRQ_CIR		25
-#define IRQ_GPIO(x)	(22 + (x))
-#define IRQ_SSP		21
-#define IRQ_LPC		20
-#define IRQ_LCD		19
-#define IRQ_UART	18
-#define IRQ_RTC		17
-#define IRQ_TIMER3	16
-#define IRQ_TIMER2	15
-#define IRQ_TIMER1	14
-#define IRQ_FLASH	12
-#define IRQ_USB1	11
-#define IRQ_USB0	10
-#define IRQ_DMA		9
-#define IRQ_PCI		8
-#define IRQ_IPSEC	7
-#define IRQ_RAID	6
-#define IRQ_IDE1	5
-#define IRQ_IDE0	4
-#define IRQ_WATCHDOG	3
-#define IRQ_GMAC1	2
-#define IRQ_GMAC0	1
-#define IRQ_IPI		0
-
-#define NORMAL_IRQ_NUM	32
-
-#define GPIO_IRQ_BASE	NORMAL_IRQ_NUM
-#define GPIO_IRQ_NUM	(3 * 32)
-
-#define ARCH_TIMER_IRQ	IRQ_TIMER2
-
-#define NR_IRQS		(NORMAL_IRQ_NUM + GPIO_IRQ_NUM)
-
-#endif /* __MACH_IRQS_H__ */
-- 
2.9.3
