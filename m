From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 31 May 2013 11:19:01 +0200
Subject: [PATCH 26/39] ARM: u300: delete <mach/irqs.h>
In-Reply-To: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
References: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1369991954-17406-27-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

All IRQs are now obtained from the device tree, and this file
is unused, so delete it.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-u300/include/mach/irqs.h | 80 ----------------------------------
 arch/arm/mach-u300/timer.c             |  2 -
 2 files changed, 82 deletions(-)
 delete mode 100644 arch/arm/mach-u300/include/mach/irqs.h

diff --git a/arch/arm/mach-u300/include/mach/irqs.h b/arch/arm/mach-u300/include/mach/irqs.h
deleted file mode 100644
index 21d5e76..0000000
--- a/arch/arm/mach-u300/include/mach/irqs.h
+++ /dev/null
@@ -1,80 +0,0 @@
-/*
- *
- * arch/arm/mach-u300/include/mach/irqs.h
- *
- *
- * Copyright (C) 2006-2012 ST-Ericsson AB
- * License terms: GNU General Public License (GPL) version 2
- * IRQ channel definitions for the U300 platforms.
- * Author: Linus Walleij <linus.walleij@stericsson.com>
- */
-
-#ifndef __MACH_IRQS_H
-#define __MACH_IRQS_H
-
-#define IRQ_U300_INTCON0_START		32
-#define IRQ_U300_INTCON1_START		64
-/* These are on INTCON0 - 30 lines */
-#define IRQ_U300_IRQ0_EXT		32
-#define IRQ_U300_IRQ1_EXT		33
-#define IRQ_U300_DMA			34
-#define IRQ_U300_VIDEO_ENC_0		35
-#define IRQ_U300_VIDEO_ENC_1		36
-#define IRQ_U300_AAIF_RX		37
-#define IRQ_U300_AAIF_TX		38
-#define IRQ_U300_AAIF_VGPIO		39
-#define IRQ_U300_AAIF_WAKEUP		40
-#define IRQ_U300_PCM_I2S0_FRAME		41
-#define IRQ_U300_PCM_I2S0_FIFO		42
-#define IRQ_U300_PCM_I2S1_FRAME		43
-#define IRQ_U300_PCM_I2S1_FIFO		44
-#define IRQ_U300_XGAM_GAMCON		45
-#define IRQ_U300_XGAM_CDI		46
-#define IRQ_U300_XGAM_CDICON		47
-#define IRQ_U300_XGAM_PDI		49
-#define IRQ_U300_XGAM_PDICON		50
-#define IRQ_U300_XGAM_GAMEACC		51
-#define IRQ_U300_XGAM_MCIDCT		52
-#define IRQ_U300_APEX			53
-#define IRQ_U300_UART0			54
-#define IRQ_U300_SPI			55
-#define IRQ_U300_TIMER_APP_OS		56
-#define IRQ_U300_TIMER_APP_DD		57
-#define IRQ_U300_TIMER_APP_GP1		58
-#define IRQ_U300_TIMER_APP_GP2		59
-#define IRQ_U300_TIMER_OS		60
-#define IRQ_U300_TIMER_MS		61
-#define IRQ_U300_KEYPAD_KEYBF		62
-#define IRQ_U300_KEYPAD_KEYBR		63
-/* These are on INTCON1 - 32 lines */
-#define IRQ_U300_GPIO_PORT0		64
-#define IRQ_U300_GPIO_PORT1		65
-#define IRQ_U300_GPIO_PORT2		66
-
-/* These are for DB3150, DB3200 and DB3350 */
-#define IRQ_U300_WDOG			67
-#define IRQ_U300_EVHIST			68
-#define IRQ_U300_MSPRO			69
-#define IRQ_U300_MMCSD_MCIINTR0		70
-#define IRQ_U300_MMCSD_MCIINTR1		71
-#define IRQ_U300_I2C0			72
-#define IRQ_U300_I2C1			73
-#define IRQ_U300_RTC			74
-#define IRQ_U300_NFIF			75
-#define IRQ_U300_NFIF2			76
-
-/* The DB3350-specific interrupt lines */
-#define IRQ_U300_ISP_F0			77
-#define IRQ_U300_ISP_F1			78
-#define IRQ_U300_ISP_F2			79
-#define IRQ_U300_ISP_F3			80
-#define IRQ_U300_ISP_F4			81
-#define IRQ_U300_GPIO_PORT3		82
-#define IRQ_U300_SYSCON_PLL_LOCK	83
-#define IRQ_U300_UART1			84
-#define IRQ_U300_GPIO_PORT4		85
-#define IRQ_U300_GPIO_PORT5		86
-#define IRQ_U300_GPIO_PORT6		87
-#define U300_VIC_IRQS_END		88
-
-#endif
diff --git a/arch/arm/mach-u300/timer.c b/arch/arm/mach-u300/timer.c
index 00499d9..2e1c81d 100644
--- a/arch/arm/mach-u300/timer.c
+++ b/arch/arm/mach-u300/timer.c
@@ -22,8 +22,6 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 
-#include <mach/irqs.h>
-
 /* Generic stuff */
 #include <asm/sched_clock.h>
 #include <asm/mach/map.h>
-- 
1.7.11.3
