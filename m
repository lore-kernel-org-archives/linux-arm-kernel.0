From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Mar 2013 17:46:46 +0100
Subject: [PATCH v2 03/13] ARM: spear: move identical headers to
 plat-spear/include/mach
In-Reply-To: <1363106816-9603-1-git-send-email-arnd@arndb.de>
References: <1363106816-9603-1-git-send-email-arnd@arndb.de>
Message-ID: <1363106816-9603-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As an intermediate step towards unification of the three spear
platforms, this gets rid of the mach/* header files that are
obviously not platform specific.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-spear13xx/include/mach/debug-macro.S | 14 ------
 arch/arm/mach-spear13xx/include/mach/generic.h     | 58 ----------------------
 arch/arm/mach-spear13xx/include/mach/hardware.h    |  1 -
 arch/arm/mach-spear13xx/include/mach/irqs.h        | 35 -------------
 arch/arm/mach-spear13xx/include/mach/timex.h       | 19 -------
 arch/arm/mach-spear13xx/include/mach/uncompress.h  | 19 -------
 arch/arm/mach-spear3xx/include/mach/debug-macro.S  | 14 ------
 arch/arm/mach-spear3xx/include/mach/generic.h      | 58 ----------------------
 arch/arm/mach-spear3xx/include/mach/hardware.h     |  1 -
 arch/arm/mach-spear3xx/include/mach/irqs.h         | 35 -------------
 arch/arm/mach-spear3xx/include/mach/timex.h        | 19 -------
 arch/arm/mach-spear3xx/include/mach/uncompress.h   | 19 -------
 arch/arm/mach-spear6xx/include/mach/debug-macro.S  | 14 ------
 arch/arm/mach-spear6xx/include/mach/generic.h      | 58 ----------------------
 arch/arm/mach-spear6xx/include/mach/hardware.h     |  1 -
 arch/arm/mach-spear6xx/include/mach/irqs.h         | 35 -------------
 arch/arm/mach-spear6xx/include/mach/timex.h        | 19 -------
 arch/arm/mach-spear6xx/include/mach/uncompress.h   | 19 -------
 arch/arm/plat-spear/include/mach/debug-macro.S     | 36 ++++++++++++++
 arch/arm/plat-spear/include/mach/generic.h         | 58 ++++++++++++++++++++++
 arch/arm/plat-spear/include/mach/hardware.h        |  1 +
 arch/arm/plat-spear/include/mach/irqs.h            | 35 +++++++++++++
 arch/arm/plat-spear/include/mach/timex.h           | 19 +++++++
 arch/arm/plat-spear/include/mach/uncompress.h      | 42 ++++++++++++++++
 arch/arm/plat-spear/include/plat/debug-macro.S     | 36 --------------
 arch/arm/plat-spear/include/plat/timex.h           | 19 -------
 arch/arm/plat-spear/include/plat/uncompress.h      | 42 ----------------
 27 files changed, 191 insertions(+), 535 deletions(-)
 delete mode 100644 arch/arm/mach-spear13xx/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-spear13xx/include/mach/generic.h
 delete mode 100644 arch/arm/mach-spear13xx/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-spear13xx/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-spear13xx/include/mach/timex.h
 delete mode 100644 arch/arm/mach-spear13xx/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/generic.h
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/timex.h
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-spear6xx/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-spear6xx/include/mach/generic.h
 delete mode 100644 arch/arm/mach-spear6xx/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-spear6xx/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-spear6xx/include/mach/timex.h
 delete mode 100644 arch/arm/mach-spear6xx/include/mach/uncompress.h
 create mode 100644 arch/arm/plat-spear/include/mach/debug-macro.S
 create mode 100644 arch/arm/plat-spear/include/mach/generic.h
 create mode 100644 arch/arm/plat-spear/include/mach/hardware.h
 create mode 100644 arch/arm/plat-spear/include/mach/irqs.h
 create mode 100644 arch/arm/plat-spear/include/mach/timex.h
 create mode 100644 arch/arm/plat-spear/include/mach/uncompress.h
 delete mode 100644 arch/arm/plat-spear/include/plat/debug-macro.S
 delete mode 100644 arch/arm/plat-spear/include/plat/timex.h
 delete mode 100644 arch/arm/plat-spear/include/plat/uncompress.h

diff --git a/arch/arm/mach-spear13xx/include/mach/debug-macro.S b/arch/arm/mach-spear13xx/include/mach/debug-macro.S
deleted file mode 100644
index 9e3ae6b..0000000
--- a/arch/arm/mach-spear13xx/include/mach/debug-macro.S
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- * arch/arm/mach-spear13xx/include/mach/debug-macro.S
- *
- * Debugging macro include header spear13xx machine family
- *
- * Copyright (C) 2012 ST Microelectronics
- * Viresh Kumar <viresh.linux@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <plat/debug-macro.S>
diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
deleted file mode 100644
index af47d9b..0000000
--- a/arch/arm/mach-spear13xx/include/mach/generic.h
+++ /dev/null
@@ -1,58 +0,0 @@
-/*
- * spear machine family generic header file
- *
- * Copyright (C) 2009-2012 ST Microelectronics
- * Rajeev Kumar <rajeev-dlh.kumar@st.com>
- * Viresh Kumar <viresh.linux@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __MACH_GENERIC_H
-#define __MACH_GENERIC_H
-
-#include <linux/dmaengine.h>
-#include <linux/amba/pl08x.h>
-#include <linux/init.h>
-#include <asm/mach/time.h>
-
-extern void spear13xx_timer_init(void);
-extern void spear3xx_timer_init(void);
-extern struct pl022_ssp_controller pl022_plat_data;
-extern struct pl08x_platform_data pl080_plat_data;
-extern struct dw_dma_platform_data dmac_plat_data;
-extern struct dw_dma_slave cf_dma_priv;
-extern struct dw_dma_slave nand_read_dma_priv;
-extern struct dw_dma_slave nand_write_dma_priv;
-bool dw_dma_filter(struct dma_chan *chan, void *slave);
-
-void __init spear_setup_of_timer(void);
-void __init spear3xx_clk_init(void);
-void __init spear3xx_map_io(void);
-void __init spear3xx_dt_init_irq(void);
-void __init spear6xx_clk_init(void);
-void __init spear13xx_map_io(void);
-void __init spear13xx_l2x0_init(void);
-
-void spear_restart(char, const char *);
-
-void spear13xx_secondary_startup(void);
-void __cpuinit spear13xx_cpu_die(unsigned int cpu);
-
-extern struct smp_operations spear13xx_smp_ops;
-
-#ifdef CONFIG_MACH_SPEAR1310
-void __init spear1310_clk_init(void);
-#else
-static inline void spear1310_clk_init(void) {}
-#endif
-
-#ifdef CONFIG_MACH_SPEAR1340
-void __init spear1340_clk_init(void);
-#else
-static inline void spear1340_clk_init(void) {}
-#endif
-
-#endif /* __MACH_GENERIC_H */
diff --git a/arch/arm/mach-spear13xx/include/mach/hardware.h b/arch/arm/mach-spear13xx/include/mach/hardware.h
deleted file mode 100644
index 40a8c17..0000000
--- a/arch/arm/mach-spear13xx/include/mach/hardware.h
+++ /dev/null
@@ -1 +0,0 @@
-/* empty */
diff --git a/arch/arm/mach-spear13xx/include/mach/irqs.h b/arch/arm/mach-spear13xx/include/mach/irqs.h
deleted file mode 100644
index 92da0a8..0000000
--- a/arch/arm/mach-spear13xx/include/mach/irqs.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/*
- * IRQ helper macros for spear machine family
- *
- * Copyright (C) 2009-2012 ST Microelectronics
- * Rajeev Kumar <rajeev-dlh.kumar@st.com>
- * Viresh Kumar <viresh.linux@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __MACH_IRQS_H
-#define __MACH_IRQS_H
-
-#ifdef CONFIG_ARCH_SPEAR3XX
-#define NR_IRQS			256
-#endif
-
-#ifdef CONFIG_ARCH_SPEAR6XX
-/* IRQ definitions */
-/* VIC 1 */
-#define IRQ_VIC_END				64
-
-/* GPIO pins virtual irqs */
-#define VIRTUAL_IRQS				24
-#define NR_IRQS					(IRQ_VIC_END + VIRTUAL_IRQS)
-#endif
-
-#ifdef CONFIG_ARCH_SPEAR13XX
-#define IRQ_GIC_END			160
-#define NR_IRQS				IRQ_GIC_END
-#endif
-
-#endif /* __MACH_IRQS_H */
diff --git a/arch/arm/mach-spear13xx/include/mach/timex.h b/arch/arm/mach-spear13xx/include/mach/timex.h
deleted file mode 100644
index 3a58b82..0000000
--- a/arch/arm/mach-spear13xx/include/mach/timex.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * arch/arm/mach-spear3xx/include/mach/timex.h
- *
- * SPEAr3XX machine family specific timex definitions
- *
- * Copyright (C) 2012 ST Microelectronics
- * Viresh Kumar <viresh.linux@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __MACH_TIMEX_H
-#define __MACH_TIMEX_H
-
-#include <plat/timex.h>
-
-#endif /* __MACH_TIMEX_H */
diff --git a/arch/arm/mach-spear13xx/include/mach/uncompress.h b/arch/arm/mach-spear13xx/include/mach/uncompress.h
deleted file mode 100644
index 70fe72f..0000000
--- a/arch/arm/mach-spear13xx/include/mach/uncompress.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * arch/arm/mach-spear13xx/include/mach/uncompress.h
- *
- * Serial port stubs for kernel decompress status messages
- *
- * Copyright (C) 2012 ST Microelectronics
- * Viresh Kumar <viresh.linux@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __MACH_UNCOMPRESS_H
-#define __MACH_UNCOMPRESS_H
-
-#include <plat/uncompress.h>
-
-#endif /* __MACH_UNCOMPRESS_H */
diff --git a/arch/arm/mach-spear3xx/include/mach/debug-macro.S b/arch/arm/mach-spear3xx/include/mach/debug-macro.S
deleted file mode 100644
index 0a6381f..0000000
--- a/arch/arm/mach-spear3xx/include/mach/debug-macro.S
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- * arch/arm/mach-spear3xx/include/mach/debug-macro.S
- *
- * Debugging macro include header spear3xx machine family
- *
- * Copyright (C) 2009 ST Microelectronics
- * Viresh Kumar<viresh.linux@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <plat/debug-macro.S>
diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
deleted file mode 100644
index af47d9b..0000000
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ /dev/null
@@ -1,58 +0,0 @@
-/*
- * spear machine family generic header file
- *
- * Copyright (C) 2009-2012 ST Microelectronics
- * Rajeev Kumar <rajeev-dlh.kumar@st.com>
- * Viresh Kumar <viresh.linux@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __MACH_GENERIC_H
-#define __MACH_GENERIC_H
-
-#include <linux/dmaengine.h>
-#include <linux/amba/pl08x.h>
-#include <linux/init.h>
-#include <asm/mach/time.h>
-
-extern void spear13xx_timer_init(void);
-extern void spear3xx_timer_init(void);
-extern struct pl022_ssp_controller pl022_plat_data;
-extern struct pl08x_platform_data pl080_plat_data;
-extern struct dw_dma_platform_data dmac_plat_data;
-extern struct dw_dma_slave cf_dma_priv;
-extern struct dw_dma_slave nand_read_dma_priv;
-extern struct dw_dma_slave nand_write_dma_priv;
-bool dw_dma_filter(struct dma_chan *chan, void *slave);
-
-void __init spear_setup_of_timer(void);
-void __init spear3xx_clk_init(void);
-void __init spear3xx_map_io(void);
-void __init spear3xx_dt_init_irq(void);
-void __init spear6xx_clk_init(void);
-void __init spear13xx_map_io(void);
-void __init spear13xx_l2x0_init(void);
-
-void spear_restart(char, const char *);
-
-void spear13xx_secondary_startup(void);
-void __cpuinit spear13xx_cpu_die(unsigned int cpu);
-
-extern struct smp_operations spear13xx_smp_ops;
-
-#ifdef CONFIG_MACH_SPEAR1310
-void __init spear1310_clk_init(void);
-#else
-static inline void spear1310_clk_init(void) {}
-#endif
-
-#ifdef CONFIG_MACH_SPEAR1340
-void __init spear1340_clk_init(void);
-#else
-static inline void spear1340_clk_init(void) {}
-#endif
-
-#endif /* __MACH_GENERIC_H */
diff --git a/arch/arm/mach-spear3xx/include/mach/hardware.h b/arch/arm/mach-spear3xx/include/mach/hardware.h
deleted file mode 100644
index 40a8c17..0000000
--- a/arch/arm/mach-spear3xx/include/mach/hardware.h
+++ /dev/null
@@ -1 +0,0 @@
-/* empty */
diff --git a/arch/arm/mach-spear3xx/include/mach/irqs.h b/arch/arm/mach-spear3xx/include/mach/irqs.h
deleted file mode 100644
index 92da0a8..0000000
--- a/arch/arm/mach-spear3xx/include/mach/irqs.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/*
- * IRQ helper macros for spear machine family
- *
- * Copyright (C) 2009-2012 ST Microelectronics
- * Rajeev Kumar <rajeev-dlh.kumar@st.com>
- * Viresh Kumar <viresh.linux@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __MACH_IRQS_H
-#define __MACH_IRQS_H
-
-#ifdef CONFIG_ARCH_SPEAR3XX
-#define NR_IRQS			256
-#endif
-
-#ifdef CONFIG_ARCH_SPEAR6XX
-/* IRQ definitions */
-/* VIC 1 */
-#define IRQ_VIC_END				64
-
-/* GPIO pins virtual irqs */
-#define VIRTUAL_IRQS				24
-#define NR_IRQS					(IRQ_VIC_END + VIRTUAL_IRQS)
-#endif
-
-#ifdef CONFIG_ARCH_SPEAR13XX
-#define IRQ_GIC_END			160
-#define NR_IRQS				IRQ_GIC_END
-#endif
-
-#endif /* __MACH_IRQS_H */
diff --git a/arch/arm/mach-spear3xx/include/mach/timex.h b/arch/arm/mach-spear3xx/include/mach/timex.h
deleted file mode 100644
index 9f5d08b..0000000
--- a/arch/arm/mach-spear3xx/include/mach/timex.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * arch/arm/mach-spear3xx/include/mach/timex.h
- *
- * SPEAr3XX machine family specific timex definitions
- *
- * Copyright (C) 2009 ST Microelectronics
- * Viresh Kumar <viresh.linux@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __MACH_TIMEX_H
-#define __MACH_TIMEX_H
-
-#include <plat/timex.h>
-
-#endif /* __MACH_TIMEX_H */
diff --git a/arch/arm/mach-spear3xx/include/mach/uncompress.h b/arch/arm/mach-spear3xx/include/mach/uncompress.h
deleted file mode 100644
index b909b01..0000000
--- a/arch/arm/mach-spear3xx/include/mach/uncompress.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * arch/arm/mach-spear3xx/include/mach/uncompress.h
- *
- * Serial port stubs for kernel decompress status messages
- *
- * Copyright (C) 2009 ST Microelectronics
- * Viresh Kumar <viresh.linux@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __MACH_UNCOMPRESS_H
-#define __MACH_UNCOMPRESS_H
-
-#include <plat/uncompress.h>
-
-#endif /* __MACH_UNCOMPRESS_H */
diff --git a/arch/arm/mach-spear6xx/include/mach/debug-macro.S b/arch/arm/mach-spear6xx/include/mach/debug-macro.S
deleted file mode 100644
index 0f3ea39..0000000
--- a/arch/arm/mach-spear6xx/include/mach/debug-macro.S
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- * arch/arm/mach-spear6xx/include/mach/debug-macro.S
- *
- * Debugging macro include header for SPEAr6xx machine family
- *
- * Copyright (C) 2009 ST Microelectronics
- * Rajeev Kumar<rajeev-dlh.kumar@st.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <plat/debug-macro.S>
diff --git a/arch/arm/mach-spear6xx/include/mach/generic.h b/arch/arm/mach-spear6xx/include/mach/generic.h
deleted file mode 100644
index af47d9b..0000000
--- a/arch/arm/mach-spear6xx/include/mach/generic.h
+++ /dev/null
@@ -1,58 +0,0 @@
-/*
- * spear machine family generic header file
- *
- * Copyright (C) 2009-2012 ST Microelectronics
- * Rajeev Kumar <rajeev-dlh.kumar@st.com>
- * Viresh Kumar <viresh.linux@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __MACH_GENERIC_H
-#define __MACH_GENERIC_H
-
-#include <linux/dmaengine.h>
-#include <linux/amba/pl08x.h>
-#include <linux/init.h>
-#include <asm/mach/time.h>
-
-extern void spear13xx_timer_init(void);
-extern void spear3xx_timer_init(void);
-extern struct pl022_ssp_controller pl022_plat_data;
-extern struct pl08x_platform_data pl080_plat_data;
-extern struct dw_dma_platform_data dmac_plat_data;
-extern struct dw_dma_slave cf_dma_priv;
-extern struct dw_dma_slave nand_read_dma_priv;
-extern struct dw_dma_slave nand_write_dma_priv;
-bool dw_dma_filter(struct dma_chan *chan, void *slave);
-
-void __init spear_setup_of_timer(void);
-void __init spear3xx_clk_init(void);
-void __init spear3xx_map_io(void);
-void __init spear3xx_dt_init_irq(void);
-void __init spear6xx_clk_init(void);
-void __init spear13xx_map_io(void);
-void __init spear13xx_l2x0_init(void);
-
-void spear_restart(char, const char *);
-
-void spear13xx_secondary_startup(void);
-void __cpuinit spear13xx_cpu_die(unsigned int cpu);
-
-extern struct smp_operations spear13xx_smp_ops;
-
-#ifdef CONFIG_MACH_SPEAR1310
-void __init spear1310_clk_init(void);
-#else
-static inline void spear1310_clk_init(void) {}
-#endif
-
-#ifdef CONFIG_MACH_SPEAR1340
-void __init spear1340_clk_init(void);
-#else
-static inline void spear1340_clk_init(void) {}
-#endif
-
-#endif /* __MACH_GENERIC_H */
diff --git a/arch/arm/mach-spear6xx/include/mach/hardware.h b/arch/arm/mach-spear6xx/include/mach/hardware.h
deleted file mode 100644
index 40a8c17..0000000
--- a/arch/arm/mach-spear6xx/include/mach/hardware.h
+++ /dev/null
@@ -1 +0,0 @@
-/* empty */
diff --git a/arch/arm/mach-spear6xx/include/mach/irqs.h b/arch/arm/mach-spear6xx/include/mach/irqs.h
deleted file mode 100644
index 92da0a8..0000000
--- a/arch/arm/mach-spear6xx/include/mach/irqs.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/*
- * IRQ helper macros for spear machine family
- *
- * Copyright (C) 2009-2012 ST Microelectronics
- * Rajeev Kumar <rajeev-dlh.kumar@st.com>
- * Viresh Kumar <viresh.linux@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __MACH_IRQS_H
-#define __MACH_IRQS_H
-
-#ifdef CONFIG_ARCH_SPEAR3XX
-#define NR_IRQS			256
-#endif
-
-#ifdef CONFIG_ARCH_SPEAR6XX
-/* IRQ definitions */
-/* VIC 1 */
-#define IRQ_VIC_END				64
-
-/* GPIO pins virtual irqs */
-#define VIRTUAL_IRQS				24
-#define NR_IRQS					(IRQ_VIC_END + VIRTUAL_IRQS)
-#endif
-
-#ifdef CONFIG_ARCH_SPEAR13XX
-#define IRQ_GIC_END			160
-#define NR_IRQS				IRQ_GIC_END
-#endif
-
-#endif /* __MACH_IRQS_H */
diff --git a/arch/arm/mach-spear6xx/include/mach/timex.h b/arch/arm/mach-spear6xx/include/mach/timex.h
deleted file mode 100644
index ac1c5b0..0000000
--- a/arch/arm/mach-spear6xx/include/mach/timex.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * arch/arm/mach-spear6xx/include/mach/timex.h
- *
- * SPEAr6XX machine family specific timex definitions
- *
- * Copyright (C) 2009 ST Microelectronics
- * Rajeev Kumar<rajeev-dlh.kumar@st.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __MACH_TIMEX_H
-#define __MACH_TIMEX_H
-
-#include <plat/timex.h>
-
-#endif	/* __MACH_TIMEX_H */
diff --git a/arch/arm/mach-spear6xx/include/mach/uncompress.h b/arch/arm/mach-spear6xx/include/mach/uncompress.h
deleted file mode 100644
index 77f0765..0000000
--- a/arch/arm/mach-spear6xx/include/mach/uncompress.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * arch/arm/mach-spear6xx/include/mach/uncompress.h
- *
- * Serial port stubs for kernel decompress status messages
- *
- * Copyright (C) 2009 ST Microelectronics
- * Rajeev Kumar<rajeev-dlh.kumar@st.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __MACH_UNCOMPRESS_H
-#define __MACH_UNCOMPRESS_H
-
-#include <plat/uncompress.h>
-
-#endif	/* __MACH_UNCOMPRESS_H */
diff --git a/arch/arm/plat-spear/include/mach/debug-macro.S b/arch/arm/plat-spear/include/mach/debug-macro.S
new file mode 100644
index 0000000..75b05ad
--- /dev/null
+++ b/arch/arm/plat-spear/include/mach/debug-macro.S
@@ -0,0 +1,36 @@
+/*
+ * arch/arm/plat-spear/include/plat/debug-macro.S
+ *
+ * Debugging macro include header for spear platform
+ *
+ * Copyright (C) 2009 ST Microelectronics
+ * Viresh Kumar <viresh.linux@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/amba/serial.h>
+#include <mach/spear.h>
+
+		.macro	addruart, rp, rv, tmp
+		mov	\rp, #SPEAR_DBG_UART_BASE		@ Physical base
+		mov	\rv, #VA_SPEAR_DBG_UART_BASE		@ Virtual base
+		.endm
+
+		.macro	senduart, rd, rx
+		strb	\rd, [\rx, #UART01x_DR]			@ ASC_TX_BUFFER
+		.endm
+
+		.macro	waituart, rd, rx
+1001:		ldr	\rd, [\rx, #UART01x_FR]			@ FLAG REGISTER
+		tst	\rd, #UART01x_FR_TXFF			@ TX_FULL
+		bne	1001b
+		.endm
+
+		.macro	busyuart, rd, rx
+1002:		ldr	\rd, [\rx, #UART01x_FR]			@ FLAG REGISTER
+		tst	\rd, #UART011_FR_TXFE			@ TX_EMPTY
+		beq	1002b
+		.endm
diff --git a/arch/arm/plat-spear/include/mach/generic.h b/arch/arm/plat-spear/include/mach/generic.h
new file mode 100644
index 0000000..af47d9b
--- /dev/null
+++ b/arch/arm/plat-spear/include/mach/generic.h
@@ -0,0 +1,58 @@
+/*
+ * spear machine family generic header file
+ *
+ * Copyright (C) 2009-2012 ST Microelectronics
+ * Rajeev Kumar <rajeev-dlh.kumar@st.com>
+ * Viresh Kumar <viresh.linux@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_GENERIC_H
+#define __MACH_GENERIC_H
+
+#include <linux/dmaengine.h>
+#include <linux/amba/pl08x.h>
+#include <linux/init.h>
+#include <asm/mach/time.h>
+
+extern void spear13xx_timer_init(void);
+extern void spear3xx_timer_init(void);
+extern struct pl022_ssp_controller pl022_plat_data;
+extern struct pl08x_platform_data pl080_plat_data;
+extern struct dw_dma_platform_data dmac_plat_data;
+extern struct dw_dma_slave cf_dma_priv;
+extern struct dw_dma_slave nand_read_dma_priv;
+extern struct dw_dma_slave nand_write_dma_priv;
+bool dw_dma_filter(struct dma_chan *chan, void *slave);
+
+void __init spear_setup_of_timer(void);
+void __init spear3xx_clk_init(void);
+void __init spear3xx_map_io(void);
+void __init spear3xx_dt_init_irq(void);
+void __init spear6xx_clk_init(void);
+void __init spear13xx_map_io(void);
+void __init spear13xx_l2x0_init(void);
+
+void spear_restart(char, const char *);
+
+void spear13xx_secondary_startup(void);
+void __cpuinit spear13xx_cpu_die(unsigned int cpu);
+
+extern struct smp_operations spear13xx_smp_ops;
+
+#ifdef CONFIG_MACH_SPEAR1310
+void __init spear1310_clk_init(void);
+#else
+static inline void spear1310_clk_init(void) {}
+#endif
+
+#ifdef CONFIG_MACH_SPEAR1340
+void __init spear1340_clk_init(void);
+#else
+static inline void spear1340_clk_init(void) {}
+#endif
+
+#endif /* __MACH_GENERIC_H */
diff --git a/arch/arm/plat-spear/include/mach/hardware.h b/arch/arm/plat-spear/include/mach/hardware.h
new file mode 100644
index 0000000..40a8c17
--- /dev/null
+++ b/arch/arm/plat-spear/include/mach/hardware.h
@@ -0,0 +1 @@
+/* empty */
diff --git a/arch/arm/plat-spear/include/mach/irqs.h b/arch/arm/plat-spear/include/mach/irqs.h
new file mode 100644
index 0000000..92da0a8
--- /dev/null
+++ b/arch/arm/plat-spear/include/mach/irqs.h
@@ -0,0 +1,35 @@
+/*
+ * IRQ helper macros for spear machine family
+ *
+ * Copyright (C) 2009-2012 ST Microelectronics
+ * Rajeev Kumar <rajeev-dlh.kumar@st.com>
+ * Viresh Kumar <viresh.linux@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_IRQS_H
+#define __MACH_IRQS_H
+
+#ifdef CONFIG_ARCH_SPEAR3XX
+#define NR_IRQS			256
+#endif
+
+#ifdef CONFIG_ARCH_SPEAR6XX
+/* IRQ definitions */
+/* VIC 1 */
+#define IRQ_VIC_END				64
+
+/* GPIO pins virtual irqs */
+#define VIRTUAL_IRQS				24
+#define NR_IRQS					(IRQ_VIC_END + VIRTUAL_IRQS)
+#endif
+
+#ifdef CONFIG_ARCH_SPEAR13XX
+#define IRQ_GIC_END			160
+#define NR_IRQS				IRQ_GIC_END
+#endif
+
+#endif /* __MACH_IRQS_H */
diff --git a/arch/arm/plat-spear/include/mach/timex.h b/arch/arm/plat-spear/include/mach/timex.h
new file mode 100644
index 0000000..ef95e5b
--- /dev/null
+++ b/arch/arm/plat-spear/include/mach/timex.h
@@ -0,0 +1,19 @@
+/*
+ * arch/arm/plat-spear/include/plat/timex.h
+ *
+ * SPEAr platform specific timex definitions
+ *
+ * Copyright (C) 2009 ST Microelectronics
+ * Viresh Kumar <viresh.linux@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __PLAT_TIMEX_H
+#define __PLAT_TIMEX_H
+
+#define CLOCK_TICK_RATE			48000000
+
+#endif /* __PLAT_TIMEX_H */
diff --git a/arch/arm/plat-spear/include/mach/uncompress.h b/arch/arm/plat-spear/include/mach/uncompress.h
new file mode 100644
index 0000000..51b2dc9
--- /dev/null
+++ b/arch/arm/plat-spear/include/mach/uncompress.h
@@ -0,0 +1,42 @@
+/*
+ * arch/arm/plat-spear/include/plat/uncompress.h
+ *
+ * Serial port stubs for kernel decompress status messages
+ *
+ * Copyright (C) 2009 ST Microelectronics
+ * Viresh Kumar <viresh.linux@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/io.h>
+#include <linux/amba/serial.h>
+#include <mach/spear.h>
+
+#ifndef __PLAT_UNCOMPRESS_H
+#define __PLAT_UNCOMPRESS_H
+/*
+ * This does not append a newline
+ */
+static inline void putc(int c)
+{
+	void __iomem *base = (void __iomem *)SPEAR_DBG_UART_BASE;
+
+	while (readl_relaxed(base + UART01x_FR) & UART01x_FR_TXFF)
+		barrier();
+
+	writel_relaxed(c, base + UART01x_DR);
+}
+
+static inline void flush(void)
+{
+}
+
+/*
+ * nothing to do
+ */
+#define arch_decomp_setup()
+
+#endif /* __PLAT_UNCOMPRESS_H */
diff --git a/arch/arm/plat-spear/include/plat/debug-macro.S b/arch/arm/plat-spear/include/plat/debug-macro.S
deleted file mode 100644
index 75b05ad..0000000
--- a/arch/arm/plat-spear/include/plat/debug-macro.S
+++ /dev/null
@@ -1,36 +0,0 @@
-/*
- * arch/arm/plat-spear/include/plat/debug-macro.S
- *
- * Debugging macro include header for spear platform
- *
- * Copyright (C) 2009 ST Microelectronics
- * Viresh Kumar <viresh.linux@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/amba/serial.h>
-#include <mach/spear.h>
-
-		.macro	addruart, rp, rv, tmp
-		mov	\rp, #SPEAR_DBG_UART_BASE		@ Physical base
-		mov	\rv, #VA_SPEAR_DBG_UART_BASE		@ Virtual base
-		.endm
-
-		.macro	senduart, rd, rx
-		strb	\rd, [\rx, #UART01x_DR]			@ ASC_TX_BUFFER
-		.endm
-
-		.macro	waituart, rd, rx
-1001:		ldr	\rd, [\rx, #UART01x_FR]			@ FLAG REGISTER
-		tst	\rd, #UART01x_FR_TXFF			@ TX_FULL
-		bne	1001b
-		.endm
-
-		.macro	busyuart, rd, rx
-1002:		ldr	\rd, [\rx, #UART01x_FR]			@ FLAG REGISTER
-		tst	\rd, #UART011_FR_TXFE			@ TX_EMPTY
-		beq	1002b
-		.endm
diff --git a/arch/arm/plat-spear/include/plat/timex.h b/arch/arm/plat-spear/include/plat/timex.h
deleted file mode 100644
index ef95e5b..0000000
--- a/arch/arm/plat-spear/include/plat/timex.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * arch/arm/plat-spear/include/plat/timex.h
- *
- * SPEAr platform specific timex definitions
- *
- * Copyright (C) 2009 ST Microelectronics
- * Viresh Kumar <viresh.linux@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __PLAT_TIMEX_H
-#define __PLAT_TIMEX_H
-
-#define CLOCK_TICK_RATE			48000000
-
-#endif /* __PLAT_TIMEX_H */
diff --git a/arch/arm/plat-spear/include/plat/uncompress.h b/arch/arm/plat-spear/include/plat/uncompress.h
deleted file mode 100644
index 51b2dc9..0000000
--- a/arch/arm/plat-spear/include/plat/uncompress.h
+++ /dev/null
@@ -1,42 +0,0 @@
-/*
- * arch/arm/plat-spear/include/plat/uncompress.h
- *
- * Serial port stubs for kernel decompress status messages
- *
- * Copyright (C) 2009 ST Microelectronics
- * Viresh Kumar <viresh.linux@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/io.h>
-#include <linux/amba/serial.h>
-#include <mach/spear.h>
-
-#ifndef __PLAT_UNCOMPRESS_H
-#define __PLAT_UNCOMPRESS_H
-/*
- * This does not append a newline
- */
-static inline void putc(int c)
-{
-	void __iomem *base = (void __iomem *)SPEAR_DBG_UART_BASE;
-
-	while (readl_relaxed(base + UART01x_FR) & UART01x_FR_TXFF)
-		barrier();
-
-	writel_relaxed(c, base + UART01x_DR);
-}
-
-static inline void flush(void)
-{
-}
-
-/*
- * nothing to do
- */
-#define arch_decomp_setup()
-
-#endif /* __PLAT_UNCOMPRESS_H */
-- 
1.8.1.2
