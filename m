From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 20 Jan 2011 12:55:46 +0530
Subject: [PATCH V5 07/63] ST SPEAr13XX: Adding machine specific header files
In-Reply-To: <cover.1295499392.git.viresh.kumar@st.com>
References: <cover.1295499392.git.viresh.kumar@st.com>
Message-ID: <36e32cd60a211b5b4e8e23768a798a574e4d6f13.1295499394.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shiraz Hashim <shiraz.hashim@st.com>

Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear13xx/include/mach/clkdev.h      |   19 ++
 arch/arm/mach-spear13xx/include/mach/debug-macro.S |   14 +
 arch/arm/mach-spear13xx/include/mach/entry-macro.S |   22 ++
 arch/arm/mach-spear13xx/include/mach/generic.h     |   46 +++
 arch/arm/mach-spear13xx/include/mach/gpio.h        |   19 ++
 arch/arm/mach-spear13xx/include/mach/hardware.h    |   26 ++
 arch/arm/mach-spear13xx/include/mach/io.h          |   19 ++
 arch/arm/mach-spear13xx/include/mach/irqs.h        |   91 ++++++
 arch/arm/mach-spear13xx/include/mach/memory.h      |   19 ++
 arch/arm/mach-spear13xx/include/mach/misc_regs.h   |  306 ++++++++++++++++++++
 arch/arm/mach-spear13xx/include/mach/smp.h         |   25 ++
 arch/arm/mach-spear13xx/include/mach/spear.h       |   93 ++++++
 arch/arm/mach-spear13xx/include/mach/spear1300.h   |   21 ++
 arch/arm/mach-spear13xx/include/mach/system.h      |   35 +++
 arch/arm/mach-spear13xx/include/mach/timex.h       |   19 ++
 arch/arm/mach-spear13xx/include/mach/uncompress.h  |   19 ++
 arch/arm/mach-spear13xx/include/mach/vmalloc.h     |   18 ++
 17 files changed, 811 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-spear13xx/include/mach/clkdev.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-spear13xx/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-spear13xx/include/mach/generic.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/gpio.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/hardware.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/io.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/irqs.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/memory.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/misc_regs.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/smp.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/spear.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/spear1300.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/system.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/timex.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/vmalloc.h

diff --git a/arch/arm/mach-spear13xx/include/mach/clkdev.h b/arch/arm/mach-spear13xx/include/mach/clkdev.h
new file mode 100644
index 0000000..effdb81
--- /dev/null
+++ b/arch/arm/mach-spear13xx/include/mach/clkdev.h
@@ -0,0 +1,19 @@
+/*
+ * arch/arm/mach-spear13xx/include/mach/clkdev.h
+ *
+ * Clock Dev framework definitions for spear13xx machine family
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Shiraz Hashim <shiraz.hashim@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_CLKDEV_H
+#define __MACH_CLKDEV_H
+
+#include <plat/clkdev.h>
+
+#endif /* __MACH_CLKDEV_H */
diff --git a/arch/arm/mach-spear13xx/include/mach/debug-macro.S b/arch/arm/mach-spear13xx/include/mach/debug-macro.S
new file mode 100644
index 0000000..3933edc
--- /dev/null
+++ b/arch/arm/mach-spear13xx/include/mach/debug-macro.S
@@ -0,0 +1,14 @@
+/*
+ * arch/arm/mach-spear13xx/include/mach/debug-macro.S
+ *
+ * Debugging macro include header spear13xx machine family
+ *
+ * Copyright (C) 2009 ST Microelectronics
+ * Shiraz Hashim <shiraz.hashim@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <plat/debug-macro.S>
diff --git a/arch/arm/mach-spear13xx/include/mach/entry-macro.S b/arch/arm/mach-spear13xx/include/mach/entry-macro.S
new file mode 100644
index 0000000..93d1215
--- /dev/null
+++ b/arch/arm/mach-spear13xx/include/mach/entry-macro.S
@@ -0,0 +1,22 @@
+/*
+ * arch/arm/mach-spear13xx/include/mach/entry-macro.S
+ *
+ * Copyright (C) 2009 ST Microelectronics
+ * Shiraz Hashim <shiraz.hashim@st.com>
+ *
+ * Copy of RealView platform implementation
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <mach/hardware.h>
+#include <asm/hardware/entry-macro-gic.S>
+
+		.macro	disable_fiq
+		.endm
+
+		.macro	arch_ret_to_user, tmp1, tmp2
+		.endm
+
diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
new file mode 100644
index 0000000..5c0f042
--- /dev/null
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -0,0 +1,46 @@
+/*
+ * arch/arm/mach-spear13xx/include/mach/generic.h
+ *
+ * spear13xx machine family generic header file
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Shiraz Hashim <shiraz.hashim@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_GENERIC_H
+#define __MACH_GENERIC_H
+
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/amba/bus.h>
+#include <asm/mach/time.h>
+#include <asm/mach/map.h>
+
+/*
+ * Each GPT has 2 timer channels
+ * Following GPT channels will be used as clock source and clockevent
+ */
+#define SPEAR_GPT0_BASE		SPEAR13XX_GPT0_BASE
+#define SPEAR_GPT0_CHAN0_IRQ	IRQ_GPT0_TMR0
+#define SPEAR_GPT0_CHAN1_IRQ	IRQ_GPT0_TMR1
+
+/* Add spear13xx family device structure declarations here */
+extern struct amba_device spear13xx_uart_device;
+extern struct sys_timer spear13xx_timer;
+
+/* Add spear1300 machine device structure declarations here */
+
+/* Add spear13xx family function declarations here */
+void __init clk_init(void);
+void __init spear_setup_timer(void);
+void __init spear1300_init(void);
+void __init spear13xx_map_io(void);
+void __init spear13xx_init_irq(void);
+void __init spear13xx_init(void);
+void spear13xx_secondary_startup(void);
+
+#endif /* __MACH_GENERIC_H */
diff --git a/arch/arm/mach-spear13xx/include/mach/gpio.h b/arch/arm/mach-spear13xx/include/mach/gpio.h
new file mode 100644
index 0000000..43fa541
--- /dev/null
+++ b/arch/arm/mach-spear13xx/include/mach/gpio.h
@@ -0,0 +1,19 @@
+/*
+ * arch/arm/mach-spear13xx/include/mach/gpio.h
+ *
+ * GPIO macros for spear13xx machine family
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Shiraz Hashim <shiraz.hashim@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_GPIO_H
+#define __MACH_GPIO_H
+
+#include <plat/gpio.h>
+
+#endif /* __MACH_GPIO_H */
diff --git a/arch/arm/mach-spear13xx/include/mach/hardware.h b/arch/arm/mach-spear13xx/include/mach/hardware.h
new file mode 100644
index 0000000..e2e8ba5
--- /dev/null
+++ b/arch/arm/mach-spear13xx/include/mach/hardware.h
@@ -0,0 +1,26 @@
+/*
+ * arch/arm/mach-spear13xx/include/mach/hardware.h
+ *
+ * Hardware definitions for spear13xx machine family
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Shiraz Hashim <shiraz.hashim@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_HARDWARE_H
+#define __MACH_HARDWARE_H
+
+#include <plat/hardware.h>
+#include <mach/spear.h>
+
+/* Vitual to physical translation of statically mapped space */
+#define IO_ADDRESS(x)		(x | 0xF0000000)
+
+/* typesafe io address */
+#define __io_address(n)		__io(IO_ADDRESS(n))
+
+#endif /* __MACH_HARDWARE_H */
diff --git a/arch/arm/mach-spear13xx/include/mach/io.h b/arch/arm/mach-spear13xx/include/mach/io.h
new file mode 100644
index 0000000..2fe3503
--- /dev/null
+++ b/arch/arm/mach-spear13xx/include/mach/io.h
@@ -0,0 +1,19 @@
+/*
+ * arch/arm/mach-spear13xx/include/mach/io.h
+ *
+ * IO definitions for spear13xx machine family
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Shiraz Hashim <shiraz.hashim@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_IO_H
+#define __MACH_IO_H
+
+#include <plat/io.h>
+
+#endif /* __MACH_IO_H */
diff --git a/arch/arm/mach-spear13xx/include/mach/irqs.h b/arch/arm/mach-spear13xx/include/mach/irqs.h
new file mode 100644
index 0000000..036bfc6
--- /dev/null
+++ b/arch/arm/mach-spear13xx/include/mach/irqs.h
@@ -0,0 +1,91 @@
+/*
+ * arch/arm/mach-spear13xx/include/mach/irqs.h
+ *
+ * IRQ helper macros for spear13xx machine family
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Shiraz Hashim <shiraz.hashim@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_IRQS_H
+#define __MACH_IRQS_H
+
+/* IRQ definitions */
+/*
+ * SGI : ID0 - ID15
+ * PPI : ID16 - ID31
+ * SHPI : ID32 - ID224
+ */
+
+#define IRQ_LOCALTIMER		29
+#define IRQ_LOCALWDOG		30
+
+/* Shared Peripheral Interrupt (SHPI) */
+#define IRQ_SHPI_START		32
+
+#define IRQ_PLAY_I2S2		(IRQ_SHPI_START + 10)
+#define IRQ_REC_I2S2		(IRQ_SHPI_START + 11)
+#define IRQ_ADC			(IRQ_SHPI_START + 12)
+#define IRQ_CLCD		(IRQ_SHPI_START + 13)
+#define IRQ_DMAC0_FLAG_0	(IRQ_SHPI_START + 14)
+#define IRQ_DMAC0_FLAG_1	(IRQ_SHPI_START + 15)
+#define IRQ_DMAC0_FLAG_2	(IRQ_SHPI_START + 16)
+#define IRQ_DMAC0_FLAG_3	(IRQ_SHPI_START + 17)
+#define IRQ_DMAC0_FLAG_4	(IRQ_SHPI_START + 18)
+#define IRQ_DMAC0_COMBINED	(IRQ_SHPI_START + 19)
+#define IRQ_FSMC0		(IRQ_SHPI_START + 20)
+#define IRQ_FSMC1		(IRQ_SHPI_START + 21)
+#define IRQ_FSMC2		(IRQ_SHPI_START + 22)
+#define IRQ_FSMC3		(IRQ_SHPI_START + 23)
+#define IRQ_GPIO0		(IRQ_SHPI_START + 24)
+#define IRQ_GPIO1		(IRQ_SHPI_START + 25)
+#define IRQ_PLAY_I2S1		(IRQ_SHPI_START + 26)
+#define IRQ_JPEG		(IRQ_SHPI_START + 27)
+#define IRQ_SDHCI		(IRQ_SHPI_START + 28)
+#define IRQ_CF			(IRQ_SHPI_START + 29)
+#define IRQ_SMI			(IRQ_SHPI_START + 30)
+#define IRQ_SSP			(IRQ_SHPI_START + 31)
+#define IRQ_C3			(IRQ_SHPI_START + 32)
+#define IRQ_GMAC_1		(IRQ_SHPI_START + 33)
+#define IRQ_GMAC_2		(IRQ_SHPI_START + 34)
+#define IRQ_UART		(IRQ_SHPI_START + 35)
+#define IRQ_RTC			(IRQ_SHPI_START + 36)
+#define IRQ_GPT0_TMR0		(IRQ_SHPI_START + 37)
+#define IRQ_GPT0_TMR1		(IRQ_SHPI_START + 38)
+#define IRQ_GPT1_TMR0		(IRQ_SHPI_START + 39)
+#define IRQ_GPT1_TMR1		(IRQ_SHPI_START + 40)
+#define IRQ_I2C			(IRQ_SHPI_START + 41)
+#define IRQ_GPT2_TMR0		(IRQ_SHPI_START + 42)
+#define IRQ_GPT2_TMR1		(IRQ_SHPI_START + 43)
+#define IRQ_GPT3_TMR0		(IRQ_SHPI_START + 44)
+#define IRQ_GPT3_TMR1		(IRQ_SHPI_START + 45)
+
+#define IRQ_JPEG_RME		(IRQ_SHPI_START + 52)
+#define IRQ_KBD			(IRQ_SHPI_START + 52)
+#define IRQ_REC_I2S1		(IRQ_SHPI_START + 53)
+#define IRQ_DMAC1_FLAG_0	(IRQ_SHPI_START + 54)
+#define IRQ_DMAC1_FLAG_1	(IRQ_SHPI_START + 55)
+#define IRQ_DMAC1_FLAG_2	(IRQ_SHPI_START + 56)
+#define IRQ_DMAC1_FLAG_3	(IRQ_SHPI_START + 57)
+#define IRQ_DMAC1_FLAG_4	(IRQ_SHPI_START + 58)
+#define IRQ_DMAC1_COMBINED	(IRQ_SHPI_START + 59)
+
+#define IRQ_UDC			(IRQ_SHPI_START + 62)
+#define IRQ_UPD			(IRQ_SHPI_START + 63)
+#define IRQ_USBH_EHCI0		(IRQ_SHPI_START + 64)
+#define IRQ_USBH_OHCI0		(IRQ_SHPI_START + 65)
+#define IRQ_USBH_EHCI1		(IRQ_SHPI_START + 66)
+#define IRQ_USBH_OHCI1		(IRQ_SHPI_START + 67)
+#define IRQ_PCIE1		(IRQ_SHPI_START + 68)
+#define IRQ_PCIE2		(IRQ_SHPI_START + 69)
+#define IRQ_PCIE3		(IRQ_SHPI_START + 70)
+
+#define IRQ_GIC_END		(IRQ_SHPI_START + 128)
+
+#define NR_IRQS			IRQ_GIC_END
+
+#endif /* __MACH_IRQS_H */
diff --git a/arch/arm/mach-spear13xx/include/mach/memory.h b/arch/arm/mach-spear13xx/include/mach/memory.h
new file mode 100644
index 0000000..200257c
--- /dev/null
+++ b/arch/arm/mach-spear13xx/include/mach/memory.h
@@ -0,0 +1,19 @@
+/*
+ * arch/arm/mach-spear13xx/include/mach/memory.h
+ *
+ * Memory map for spear13xx machine family
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Shiraz Hashim <shiraz.hashim@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_MEMORY_H
+#define __MACH_MEMORY_H
+
+#include <plat/memory.h>
+
+#endif /* __MACH_MEMORY_H */
diff --git a/arch/arm/mach-spear13xx/include/mach/misc_regs.h b/arch/arm/mach-spear13xx/include/mach/misc_regs.h
new file mode 100644
index 0000000..56ffa4e
--- /dev/null
+++ b/arch/arm/mach-spear13xx/include/mach/misc_regs.h
@@ -0,0 +1,306 @@
+/*
+ * arch/arm/mach-spear13xx/include/mach/misc_regs.h
+ *
+ * Miscellaneous registers definitions for spear13xx machine family
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Shiraz Hashim <shiraz.hashim@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_MISC_REGS_H
+#define __MACH_MISC_REGS_H
+
+#include <mach/hardware.h>
+
+#define MISC_BASE		IOMEM(VA_SPEAR13XX_MISC_BASE)
+
+/* General Configuration */
+#define SOC_CFG			(MISC_BASE + 0x000)
+#define BOOTSTRAP_CFG		(MISC_BASE + 0x004)
+
+/* Power Management Registers */
+#define PCM_CFG			(MISC_BASE + 0x100)
+#define PCM_WKUP_CFG		(MISC_BASE + 0x104)
+#define SWITCH_CTR		(MISC_BASE + 0x108)
+#define SYS_CLK_CTRL		(MISC_BASE + 0x200)
+#define SYS_SW_RES		(MISC_BASE + 0x204)
+
+/* Clock Configuration Registers */
+#define SYS_CLK_PLLTIMER	(MISC_BASE + 0x208)
+#define SYS_CLK_OSCITIMER	(MISC_BASE + 0x20c)
+
+/* PLL related registers and bit values */
+#define PLL_CFG			(MISC_BASE + 0x210)
+	/* PLL_CFG bit values */
+	#define OSC_24M_MASK	0
+	#define OSC_25M_MASK	1
+	#define PLL_CLK_MASK	3
+	#define PLL1_CLK_SHIFT	20
+	#define PLL2_CLK_SHIFT	22
+	#define PLL3_CLK_SHIFT	24
+
+#define PLL1_CTR		(MISC_BASE + 0x214)
+#define PLL1_FRQ		(MISC_BASE + 0x218)
+#define PLL1_MOD		(MISC_BASE + 0x21c)
+#define PLL2_CTR		(MISC_BASE + 0x220)
+#define PLL2_FRQ		(MISC_BASE + 0x224)
+#define PLL2_MOD		(MISC_BASE + 0x228)
+#define PLL3_CTR		(MISC_BASE + 0x22c)
+#define PLL3_FRQ		(MISC_BASE + 0x230)
+#define PLL3_MOD		(MISC_BASE + 0x234)
+#define PLL4_CTR		(MISC_BASE + 0x238)
+	/* PLL_CTR register masks */
+	#define PLL_ENABLE		2
+	#define PLL_MODE_SHIFT		4
+	#define PLL_MODE_MASK		3
+	#define PLL_MODE_NORMAL		0
+	#define PLL_MODE_FRACTION	1
+	#define PLL_MODE_DITH_DSB	2
+	#define PLL_MODE_DITH_SSB	3
+
+#define PLL4_FRQ		(MISC_BASE + 0x23c)
+	/* PLL FRQ register masks */
+	#define PLL_DIV_N_SHIFT		0
+	#define PLL_DIV_N_MASK		0xFF
+	#define PLL_DIV_P_SHIFT		8
+	#define PLL_DIV_P_MASK		0x7
+	#define PLL_NORM_FDBK_M_SHIFT	24
+	#define PLL_NORM_FDBK_M_MASK	0xFF
+	#define PLL_DITH_FDBK_M_SHIFT	16
+	#define PLL_DITH_FDBK_M_MASK	0xFFFF
+
+#define PLL4_MOD		(MISC_BASE + 0x240)
+
+#define PERIP_CLK_CFG		(MISC_BASE + 0x244)
+	/* PERIP_CLK_CFG bit values */
+	#define GPT_OSC24_MASK	0
+	#define GPT_APB_MASK	1
+	#define GPT_CLK_MASK	1
+	#define GPT0_CLK_SHIFT	8
+	#define GPT1_CLK_SHIFT	9
+	#define GPT2_CLK_SHIFT	12
+	#define GPT3_CLK_SHIFT	13
+	#define AUX_CLK_PLL1_MASK	1
+	#define AUX_CLK_PLL5_MASK	0
+	#define UART_CLK_MASK		1
+	#define UART_CLK_SHIFT		4
+
+#define GMAC_CLK_CFG		(MISC_BASE + 0x248)
+#define C3_CLK_SYNTH		(MISC_BASE + 0x24c)
+#define CLCD_CLK_SYNT		(MISC_BASE + 0x250)
+#define UART_CLK_SYNT		(MISC_BASE + 0x254)
+#define GMAC_CLK_SYNT		(MISC_BASE + 0x258)
+#define MCIF_SD_CLK_SYNT	(MISC_BASE + 0x25c)
+#define MCIF_CFXD_CLK_SYNT	(MISC_BASE + 0x260)
+#define RAS_CLK_SYNT0		(MISC_BASE + 0x264)
+#define RAS_CLK_SYNT1		(MISC_BASE + 0x268)
+#define RAS_CLK_SYNT2		(MISC_BASE + 0x26c)
+#define RAS_CLK_SYNT3		(MISC_BASE + 0x270)
+	/* aux clk synthesizer register masks */
+	#define AUX_EQ_SEL_SHIFT	30
+	#define AUX_EQ_SEL_MASK		1
+	#define AUX_EQ1_SEL		0
+	#define AUX_EQ2_SEL		1
+	#define AUX_XSCALE_SHIFT	16
+	#define AUX_XSCALE_MASK		0xFFF
+	#define AUX_YSCALE_SHIFT	0
+	#define AUX_YSCALE_MASK		0xFFF
+
+#define PERIP1_CLK_ENB		(MISC_BASE + 0x274)
+	/* PERIP1_CLK_ENB register masks */
+	#define BUS_CLK_ENB		0
+	#define SYSROM_CLK_ENB		1
+	#define AORAM_CLK_ENB		2
+	#define SYSRAM_CLK_ENB		3
+	#define FSMC_CLK_ENB		4
+	#define SMI_CLK_ENB		5
+	#define SD_CLK_ENB		6
+	#define CF_XD_CLK_ENB		7
+	#define GETH_CLK_ENB		8
+	#define UHC0_CLK_ENB		9
+	#define UHC1_CLK_ENB		10
+	#define UDC_UPD_CLK_ENB		11
+	#define PCI0_CLK_ENB		12
+	#define PCI1_CLK_ENB		13
+	#define PCI2_CLK_ENB		14
+	#define UART_CLK_ENB		15
+	#define SSP_CLK_ENB		17
+	#define I2C_CLK_ENB		18
+	#define I2S_SLV_CLK_ENB		19
+	#define I2S_MST_CLK_ENB		20
+	#define GPT0_CLK_ENB		21
+	#define GPT1_CLK_ENB		22
+	#define GPIOA_CLK_ENB		23
+	#define GPIOB_CLK_ENB		24
+	#define DMA0_CLK_ENB		25
+	#define DMA1_CLK_ENB		26
+	#define CLCD_CLK_ENB		27
+	#define JPEGC_CLK_ENB		28
+	#define C3_CLK_ENB		29
+	#define ADC_CLK_ENB		30
+	#define RTC_CLK_ENB		31
+
+#define PERIP2_CLK_ENB		(MISC_BASE + 0x278)
+	/* PERIP2_CLK_ENB register masks */
+	#define DDR_CTRL_CLK_ENB	0
+	#define DDR_CORE_CLK_ENB	1
+	#define CPU_DBG_CLK_ENB		2
+	#define KBD_CLK_ENB		3
+	#define GPT2_CLK_ENB		4
+	#define GPT3_CLK_ENB		5
+	#define ACP_CLK_ENB		6
+	#define I2S_REFOUT_CLK_ENB	7
+	#define THSENS_CLK_ENB		8
+
+#define PERIP1_SW_RST		(MISC_BASE + 0x27c)
+	#define JPEG_SOF_RST		28
+#define PERIP2_SW_RST		(MISC_BASE + 0x280)
+#define RAS_CLK_ENB		(MISC_BASE + 0x284)
+#define RAS_SW_RST		(MISC_BASE + 0x288)
+#define PLL1_SYNT		(MISC_BASE + 0x28c)
+#define I2S_CLK_CFG		(MISC_BASE + 0x290)
+
+/* Peripheral Configuration Registers */
+#define DMAC_HS_SEL		(MISC_BASE + 0x300)
+#define DMAC_SEL		(MISC_BASE + 0x304)
+#define DMAC_FLOW_SEL		(MISC_BASE + 0x308)
+#define DMAC_DIR_SEL		(MISC_BASE + 0x30c)
+#define DMAC_CFG		(MISC_BASE + 0x310)
+#define USBPHY_GEN_CFG		(MISC_BASE + 0x314)
+#define USBPHY_P1_CFG		(MISC_BASE + 0x318)
+#define USBPHY_P2_CFG		(MISC_BASE + 0x31c)
+#define USBPHY_P3_CFG		(MISC_BASE + 0x320)
+#define PCIE_CFG		(MISC_BASE + 0x324)
+#define PCIE_MIPHY_CFG		(MISC_BASE + 0x328)
+#define PERIP_CFG		(MISC_BASE + 0x32c)
+	#define MCIF_SEL_SHIFT	3
+	#define MCIF_SEL_MASK	0x3
+	#define SD_MMC_ACTIVE	0x1
+	#define CF_MMC_ACTIVE	0x2
+	#define XD_MMC_ACTIVE	0x3
+#define FSMC_CFG		(MISC_BASE + 0x330)
+#define MPMC_CTR_STS		(MISC_BASE + 0x334)
+
+/* Inter-Processor Communication Registers */
+#define PRC1_LOCK_CTR		(MISC_BASE + 0x500)
+#define PRC2_LOCK_CTR		(MISC_BASE + 0x504)
+#define PRC1_IRQ_CTR		(MISC_BASE + 0x508)
+#define PRC2_IRQ_CTR		(MISC_BASE + 0x51C)
+
+/* Pad Configuration Registers */
+#define PAD_PU_CFG_1		(MISC_BASE + 0x600)
+#define PAD_PU_CFG_2		(MISC_BASE + 0x604)
+#define PAD_PU_CFG_3		(MISC_BASE + 0x608)
+#define PAD_PU_CFG_4		(MISC_BASE + 0x60c)
+#define PAD_PU_CFG_5		(MISC_BASE + 0x610)
+#define PAD_PU_CFG_6		(MISC_BASE + 0x614)
+#define PAD_PU_CFG_7		(MISC_BASE + 0x618)
+#define PAD_PU_CFG_8		(MISC_BASE + 0x61c)
+#define PAD_PD_CFG_1		(MISC_BASE + 0x620)
+#define PAD_PD_CFG_2		(MISC_BASE + 0x624)
+#define PAD_PD_CFG_3		(MISC_BASE + 0x628)
+#define PAD_PD_CFG_4		(MISC_BASE + 0x62c)
+#define PAD_PD_CFG_5		(MISC_BASE + 0x630)
+#define PAD_PD_CFG_6		(MISC_BASE + 0x634)
+#define PAD_PD_CFG_7		(MISC_BASE + 0x638)
+#define PAD_PD_CFG_8		(MISC_BASE + 0x63c)
+#define PAD_SLEEP_CFG		(MISC_BASE + 0x640)
+#define PAD_HYST_CFG		(MISC_BASE + 0x644)
+#define PAD_DRV_CFG		(MISC_BASE + 0x648)
+#define PAD_SLEW_CFG		(MISC_BASE + 0x64c)
+#define PAD_FUNCTION_EN_1	(MISC_BASE + 0x650)
+#define PAD_FUNCTION_EN_2	(MISC_BASE + 0x654)
+#define PAD_FUNCTION_EN_3	(MISC_BASE + 0x658)
+#define DDR_PAD_CFG		(MISC_BASE + 0x65c)
+#define THSENS_CFG		(MISC_BASE + 0x6c4)
+
+/* Compensation Configuration Registers */
+#define COMP_1V8_2V5_3V3__1_CFG		(MISC_BASE + 0x700)
+#define COMP_1V8_2V5_3V3__2_CFG		(MISC_BASE + 0x704)
+#define COMP_3V3_1_CFG			(MISC_BASE + 0x708)
+#define COMP_3V3_2_CFG			(MISC_BASE + 0x70c)
+#define COMP_DDR_CFG			(MISC_BASE + 0x710)
+
+/* OTP Programming Registers */
+#define OTP_PROG_CTR		(MISC_BASE + 0x800)
+#define OTP_WDATA1_1		(MISC_BASE + 0x804)
+#define OTP_WDATA1_2		(MISC_BASE + 0x808)
+#define OTP_WDATA1_3		(MISC_BASE + 0x80c)
+#define OTP_WDATA1_4		(MISC_BASE + 0x810)
+#define OTP_WDATA1_5		(MISC_BASE + 0x814)
+#define OTP_WDATA1_6		(MISC_BASE + 0x818)
+#define OTP_WDATA1_7		(MISC_BASE + 0x81c)
+#define OTP_WDATA1_8		(MISC_BASE + 0x820)
+#define OTP_WDATA2_1		(MISC_BASE + 0x824)
+#define OTP_WDATA2_2		(MISC_BASE + 0x828)
+#define OTP_WDATA2_3		(MISC_BASE + 0x82c)
+#define OTP_WDATA2_4		(MISC_BASE + 0x830)
+#define OTP_WDATA2_5		(MISC_BASE + 0x834)
+#define OTP_WDATA2_6		(MISC_BASE + 0x838)
+#define OTP_WDATA2_7		(MISC_BASE + 0x83c)
+#define OTP_WDATA2_8		(MISC_BASE + 0x840)
+#define OTP_MASK_1		(MISC_BASE + 0x844)
+#define OTP_MASK_2		(MISC_BASE + 0x848)
+#define OTP_MASK_3		(MISC_BASE + 0x84c)
+#define OTP_MASK_4		(MISC_BASE + 0x850)
+#define OTP_MASK_5		(MISC_BASE + 0x854)
+#define OTP_MASK_6		(MISC_BASE + 0x858)
+#define OTP_MASK_7		(MISC_BASE + 0x85c)
+#define OTP_MASK_8		(MISC_BASE + 0x860)
+#define OTP_RDATA1_1		(MISC_BASE + 0x864)
+#define OTP_RDATA1_2		(MISC_BASE + 0x868)
+#define OTP_RDATA1_3		(MISC_BASE + 0x86c)
+#define OTP_RDATA1_4		(MISC_BASE + 0x870)
+#define OTP_RDATA1_5		(MISC_BASE + 0x874)
+#define OTP_RDATA1_6		(MISC_BASE + 0x878)
+#define OTP_RDATA1_7		(MISC_BASE + 0x87c)
+#define OTP_RDATA1_8		(MISC_BASE + 0x880)
+#define OTP_RDATA2_1		(MISC_BASE + 0x884)
+#define OTP_RDATA2_2		(MISC_BASE + 0x888)
+#define OTP_RDATA2_3		(MISC_BASE + 0x88c)
+#define OTP_RDATA2_4		(MISC_BASE + 0x890)
+#define OTP_RDATA2_5		(MISC_BASE + 0x894)
+#define OTP_RDATA2_6		(MISC_BASE + 0x898)
+#define OTP_RDATA2_7		(MISC_BASE + 0x89c)
+#define OTP_RDATA2_8		(MISC_BASE + 0x8a0)
+#define OTP_RDATAM_1		(MISC_BASE + 0x8a4)
+#define OTP_RDATAM_2		(MISC_BASE + 0x8a8)
+#define OTP_RDATAM_3		(MISC_BASE + 0x8ac)
+#define OTP_RDATAM_4		(MISC_BASE + 0x8b0)
+#define OTP_RDATAM_5		(MISC_BASE + 0x8b4)
+#define OTP_RDATAM_6		(MISC_BASE + 0x8b8)
+#define OTP_RDATAM_7		(MISC_BASE + 0x8bc)
+#define OTP_RDATAM_8		(MISC_BASE + 0x8c0)
+
+/* A9SM Registers */
+#define A9SM_CLUSTERID		(MISC_BASE + 0x900)
+#define A9SM_STATUS		(MISC_BASE + 0x904)
+#define A9SM_DEBUG		(MISC_BASE + 0x908)
+#define A9SM_FILTER		(MISC_BASE + 0x90c)
+#define A9SM_PARITY_CFG		(MISC_BASE + 0x910)
+#define A9SM_PARITY_ERR		(MISC_BASE + 0x914)
+
+/* SOC ID Registers */
+#define DIE_ID_1		(MISC_BASE + 0xa00)
+#define DIE_ID_2		(MISC_BASE + 0xa04)
+#define DIE_ID_3		(MISC_BASE + 0xa08)
+#define DIE_ID_4		(MISC_BASE + 0xa0c)
+#define DIE_ID_VALID		(MISC_BASE + 0xa10)
+
+/* SOC TEST & DEBUG Registers */
+#define MIPHY_TEST		(MISC_BASE + 0x1000)
+#define PCIE_MSTR_P0		(MISC_BASE + 0x1004)
+#define PCIE_AWMISC_P0		(MISC_BASE + 0x1008)
+#define PCIE_ARMISC_P0		(MISC_BASE + 0x100c)
+#define PCIE_MSTR_P1		(MISC_BASE + 0x1010)
+#define PCIE_AWMISC_P1		(MISC_BASE + 0x1014)
+#define PCIE_ARMISC_P1		(MISC_BASE + 0x1018)
+#define PCIE_MSTR_P2		(MISC_BASE + 0x101c)
+#define PCIE_AWMISC_P2		(MISC_BASE + 0x1020)
+#define PCIE_ARMISC_P2		(MISC_BASE + 0x1024)
+
+#endif /* __MACH_MISC_REGS_H */
diff --git a/arch/arm/mach-spear13xx/include/mach/smp.h b/arch/arm/mach-spear13xx/include/mach/smp.h
new file mode 100644
index 0000000..c1c4580
--- /dev/null
+++ b/arch/arm/mach-spear13xx/include/mach/smp.h
@@ -0,0 +1,25 @@
+/*
+ * arch/arm/mach-spear13xx/include/mach/smp.h
+ *
+ * Few SMP related definitions for spear13xx machine family
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Shiraz Hashim <shiraz.hashim@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_SMP_H
+#define __MACH_SMP_H
+
+#include <asm/hardware/gic.h>
+
+/* We use IRQ1 as the IPI */
+static inline void smp_cross_call(const struct cpumask *mask, int ipi)
+{
+	gic_raise_softirq(mask, ipi);
+}
+
+#endif
diff --git a/arch/arm/mach-spear13xx/include/mach/spear.h b/arch/arm/mach-spear13xx/include/mach/spear.h
new file mode 100644
index 0000000..d4b11a4
--- /dev/null
+++ b/arch/arm/mach-spear13xx/include/mach/spear.h
@@ -0,0 +1,93 @@
+/*
+ * arch/arm/mach-spear13xx/include/mach/spear.h
+ *
+ * spear13xx Machine family specific definition
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Shiraz Hashim <shiraz.hashim@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_SPEAR13XX_H
+#define __MACH_SPEAR13XX_H
+
+#include <mach/spear1300.h>
+
+#define SPEAR13XX_L2CC_BASE		0xED000000
+
+/* ARM9SMP peripheral base address */
+#define SPEAR13XX_A9SM_PERIP_BASE	0xEC800000
+#define VA_SPEAR13XX_A9SM_PERIP_BASE	IO_ADDRESS(SPEAR13XX_A9SM_PERIP_BASE)
+/* A9SM peripheral offsets */
+#define SPEAR13XX_SCU_BASE		(SPEAR13XX_A9SM_PERIP_BASE + 0x00)
+#define SPEAR13XX_GIC_CPU_BASE		(SPEAR13XX_A9SM_PERIP_BASE + 0x100)
+#define SPEAR13XX_GLOBAL_TMR_BASE	(SPEAR13XX_A9SM_PERIP_BASE + 0x200)
+#define SPEAR13XX_LOCAL_TMR_BASE	(SPEAR13XX_A9SM_PERIP_BASE + 0x600)
+#define SPEAR13XX_WDT_BASE		(SPEAR13XX_A9SM_PERIP_BASE + 0x620)
+#define SPEAR13XX_GIC_DIST_BASE		(SPEAR13XX_A9SM_PERIP_BASE + 0x1000)
+
+#define SPEAR13XX_UART_BASE		0xE0000000
+#define VA_SPEAR13XX_UART_BASE		IO_ADDRESS(SPEAR13XX_UART_BASE)
+
+#define SPEAR13XX_ADC_BASE		0xE0080000
+#define SPEAR13XX_SSP_BASE		0xE0100000
+#define SPEAR13XX_I2S0_BASE		0xE0180000
+#define SPEAR13XX_I2S1_BASE		0xE0200000
+#define SPEAR13XX_I2C_BASE		0xE0280000
+#define SPEAR13XX_KBD_BASE		0xE0300000
+#define SPEAR13XX_GPT0_BASE		0xE0380000
+#define SPEAR13XX_GPT1_BASE		0xE0400000
+#define SPEAR13XX_GPT2_BASE		0xE0480000
+#define SPEAR13XX_GPT3_BASE		0xE0500000
+#define SPEAR13XX_RTC_BASE		0xE0580000
+#define SPEAR13XX_GPIOA_BASE		0xE0600000
+#define SPEAR13XX_GPIOB_BASE		0xE0680000
+#define SPEAR13XX_MISC_BASE		0xE0700000
+#define VA_SPEAR13XX_MISC_BASE		IO_ADDRESS(SPEAR13XX_MISC_BASE)
+
+#define SPEAR13XX_SYSRAM0_BASE		0xB3800000
+#define SPEAR13XX_SYSRAM0_SIZE		0x00800000
+
+/*
+ * The system location which is polled by secondary cpus to find the
+ * jump address
+ */
+#define SPEAR13XX_SYS_LOCATION		(SPEAR13XX_SYSRAM0_BASE + 0x600)
+
+#define SPEAR13XX_SYSRAM1_BASE		0xE0800000
+#define SPEAR13XX_SYSRAM1_SIZE		0x00800000
+#define SPEAR13XX_CLCD_BASE		0xE1000000
+#define SPEAR13XX_C3_BASE		0xE1800000
+#define SPEAR13XX_GETH_BASE		0xE2000000
+#define SPEAR13XX_UPD_BASE		0xE2800000
+#define SPEAR13XX_UDC_BASE		0xE3800000
+#define SPEAR13XX_UHC0_OHCI_BASE	0xE4000000
+#define SPEAR13XX_UHC0_EHCI_BASE	0xE4800000
+#define SPEAR13XX_UHC1_OHCI_BASE	0xE5000000
+#define SPEAR13XX_UHC1_EHCI_BASE	0xE5800000
+#define SPEAR13XX_SMI_MEM_BASE		0xE6000000
+#define SPEAR13XX_SMI_CTRL_BASE		0xEA000000
+#define SPEAR13XX_DMAC0_BASE		0xEA800000
+#define SPEAR13XX_DMAC1_BASE		0xEB000000
+#define SPEAR13XX_MII_PHY_BASE		0xEB800000
+#define SPEAR13XX_MPMC_BASE		0xEC000000
+#define SPEAR13XX_PCIE0_BASE		0x80000000
+#define SPEAR13XX_PCIE1_BASE		0x90000000
+#define SPEAR13XX_PCIE2_BASE		0xC0000000
+#define SPEAR13XX_PCIE0_APP_BASE	0xB1000000
+#define SPEAR13XX_PCIE1_APP_BASE	0xB1800000
+#define SPEAR13XX_PCIE2_APP_BASE	0xB4000000
+#define SPEAR13XX_FSMC_MEM_BASE		0xA0000000
+#define SPEAR13XX_FSMC_BASE		0xB0000000
+#define SPEAR13XX_JPEG_BASE		0xB2000000
+#define SPEAR13XX_MCIF_CF_BASE		0xB2800000
+#define SPEAR13XX_MCIF_SDHCI_BASE	0xB3000000
+
+/* Debug uart for linux, will be used for debug and uncompress messages */
+#define SPEAR_DBG_UART_BASE		SPEAR13XX_UART_BASE
+#define VA_SPEAR_DBG_UART_BASE		VA_SPEAR13XX_UART_BASE
+
+#endif /* __MACH_SPEAR13XX_H */
diff --git a/arch/arm/mach-spear13xx/include/mach/spear1300.h b/arch/arm/mach-spear13xx/include/mach/spear1300.h
new file mode 100644
index 0000000..b3ba267
--- /dev/null
+++ b/arch/arm/mach-spear13xx/include/mach/spear1300.h
@@ -0,0 +1,21 @@
+/*
+ * arch/arm/mach-spear13xx/include/mach/spear1300.h
+ *
+ * SPEAr1300 Machine specific definition
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Shiraz Hashim <shiraz.hashim@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifdef	CONFIG_MACH_SPEAR1300
+
+#ifndef __MACH_SPEAR1300_H
+#define __MACH_SPEAR1300_H
+
+#endif /* __MACH_SPEAR1300_H */
+
+#endif /* CONFIG_MACH_SPEAR1300 */
diff --git a/arch/arm/mach-spear13xx/include/mach/system.h b/arch/arm/mach-spear13xx/include/mach/system.h
new file mode 100644
index 0000000..a9b159d
--- /dev/null
+++ b/arch/arm/mach-spear13xx/include/mach/system.h
@@ -0,0 +1,35 @@
+/*
+ * arch/arm/mach-spear13xx/include/mach/system.h
+ *
+ * spear13xx Machine family specific architecture functions
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Shiraz Hashim <shiraz.hashim@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_SYSTEM_H
+#define __MACH_SYSTEM_H
+
+#include <linux/io.h>
+#include <mach/hardware.h>
+#include <mach/misc_regs.h>
+
+static inline void arch_idle(void)
+{
+	/*
+	 * This should do all the clock switching
+	 * and wait for interrupt tricks
+	 */
+	cpu_do_idle();
+}
+
+static inline void arch_reset(char mode, const char *cmd)
+{
+	writel(0x01, SYS_SW_RES);
+}
+
+#endif /* __MACH_SYSTEM_H */
diff --git a/arch/arm/mach-spear13xx/include/mach/timex.h b/arch/arm/mach-spear13xx/include/mach/timex.h
new file mode 100644
index 0000000..0a81490
--- /dev/null
+++ b/arch/arm/mach-spear13xx/include/mach/timex.h
@@ -0,0 +1,19 @@
+/*
+ * arch/arm/mach-spear13xx/include/mach/timex.h
+ *
+ * spear13xx machine family specific timex definitions
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Shiraz Hashim <shiraz.hashim@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_TIMEX_H
+#define __MACH_TIMEX_H
+
+#define CLOCK_TICK_RATE			24000000
+
+#endif /* __MACH_TIMEX_H */
diff --git a/arch/arm/mach-spear13xx/include/mach/uncompress.h b/arch/arm/mach-spear13xx/include/mach/uncompress.h
new file mode 100644
index 0000000..3c27f25
--- /dev/null
+++ b/arch/arm/mach-spear13xx/include/mach/uncompress.h
@@ -0,0 +1,19 @@
+/*
+ * arch/arm/mach-spear13xx/include/mach/uncompress.h
+ *
+ * Serial port stubs for kernel decompress status messages
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Shiraz Hashim <shiraz.hashim@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_UNCOMPRESS_H
+#define __MACH_UNCOMPRESS_H
+
+#include <plat/uncompress.h>
+
+#endif /* __MACH_UNCOMPRESS_H */
diff --git a/arch/arm/mach-spear13xx/include/mach/vmalloc.h b/arch/arm/mach-spear13xx/include/mach/vmalloc.h
new file mode 100644
index 0000000..85ad57e
--- /dev/null
+++ b/arch/arm/mach-spear13xx/include/mach/vmalloc.h
@@ -0,0 +1,18 @@
+/*
+ * arch/arm/mach-spear13xx/include/mach/vmalloc.h
+ *
+ * Defining Vmalloc area for spear13xx machine family
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_VMALLOC_H
+#define __MACH_VMALLOC_H
+
+#include <plat/vmalloc.h>
+
+#endif /* __MACH_VMALLOC_H */
-- 
1.7.3.4
