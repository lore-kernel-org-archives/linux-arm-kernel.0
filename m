From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Jan 2013 23:35:46 +0000
Subject: [PATCH 03/13] ARM: spear: move identical headers to
 plat-spear/include/mach
In-Reply-To: <1359156956-32404-1-git-send-email-arnd@arndb.de>
References: <1359156956-32404-1-git-send-email-arnd@arndb.de>
Message-ID: <1359156956-32404-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As an intermediate step towards unification of the three spear
platforms, this gets rid of the mach/* header files that are
obviously not platform specific.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-spear13xx/include/mach/debug-macro.S | 14 -----
 arch/arm/mach-spear13xx/include/mach/timex.h       | 19 -------
 arch/arm/mach-spear13xx/include/mach/uncompress.h  | 19 -------
 arch/arm/mach-spear3xx/include/mach/debug-macro.S  | 14 -----
 arch/arm/mach-spear3xx/include/mach/generic.h      | 59 ----------------------
 arch/arm/mach-spear3xx/include/mach/hardware.h     |  1 -
 arch/arm/mach-spear3xx/include/mach/irqs.h         | 35 -------------
 arch/arm/mach-spear3xx/include/mach/timex.h        | 19 -------
 arch/arm/mach-spear3xx/include/mach/uncompress.h   | 19 -------
 arch/arm/mach-spear6xx/include/mach/debug-macro.S  | 14 -----
 arch/arm/mach-spear6xx/include/mach/generic.h      | 59 ----------------------
 arch/arm/mach-spear6xx/include/mach/hardware.h     |  1 -
 arch/arm/mach-spear6xx/include/mach/irqs.h         | 35 -------------
 arch/arm/mach-spear6xx/include/mach/timex.h        | 19 -------
 arch/arm/mach-spear6xx/include/mach/uncompress.h   | 19 -------
 .../include/{plat => mach}/debug-macro.S           |  0
 .../include/mach/generic.h                         |  0
 .../include/mach/hardware.h                        |  0
 .../include/mach/irqs.h                            |  0
 arch/arm/plat-spear/include/{plat => mach}/timex.h |  0
 .../plat-spear/include/{plat => mach}/uncompress.h |  0
 21 files changed, 346 deletions(-)
 delete mode 100644 arch/arm/mach-spear13xx/include/mach/debug-macro.S
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
 rename arch/arm/plat-spear/include/{plat => mach}/debug-macro.S (100%)
 rename arch/arm/{mach-spear13xx => plat-spear}/include/mach/generic.h (100%)
 rename arch/arm/{mach-spear13xx => plat-spear}/include/mach/hardware.h (100%)
 rename arch/arm/{mach-spear13xx => plat-spear}/include/mach/irqs.h (100%)
 rename arch/arm/plat-spear/include/{plat => mach}/timex.h (100%)
 rename arch/arm/plat-spear/include/{plat => mach}/uncompress.h (100%)

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
index 58c15c6..0000000
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ /dev/null
@@ -1,59 +0,0 @@
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
-extern struct sys_timer spear13xx_timer;
-extern struct sys_timer spear3xx_timer;
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
-void __init spear13xx_dt_init_irq(void);
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
index 58c15c6..0000000
--- a/arch/arm/mach-spear6xx/include/mach/generic.h
+++ /dev/null
@@ -1,59 +0,0 @@
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
-extern struct sys_timer spear13xx_timer;
-extern struct sys_timer spear3xx_timer;
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
-void __init spear13xx_dt_init_irq(void);
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
diff --git a/arch/arm/plat-spear/include/plat/debug-macro.S b/arch/arm/plat-spear/include/mach/debug-macro.S
similarity index 100%
rename from arch/arm/plat-spear/include/plat/debug-macro.S
rename to arch/arm/plat-spear/include/mach/debug-macro.S
diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/plat-spear/include/mach/generic.h
similarity index 100%
rename from arch/arm/mach-spear13xx/include/mach/generic.h
rename to arch/arm/plat-spear/include/mach/generic.h
diff --git a/arch/arm/mach-spear13xx/include/mach/hardware.h b/arch/arm/plat-spear/include/mach/hardware.h
similarity index 100%
rename from arch/arm/mach-spear13xx/include/mach/hardware.h
rename to arch/arm/plat-spear/include/mach/hardware.h
diff --git a/arch/arm/mach-spear13xx/include/mach/irqs.h b/arch/arm/plat-spear/include/mach/irqs.h
similarity index 100%
rename from arch/arm/mach-spear13xx/include/mach/irqs.h
rename to arch/arm/plat-spear/include/mach/irqs.h
diff --git a/arch/arm/plat-spear/include/plat/timex.h b/arch/arm/plat-spear/include/mach/timex.h
similarity index 100%
rename from arch/arm/plat-spear/include/plat/timex.h
rename to arch/arm/plat-spear/include/mach/timex.h
diff --git a/arch/arm/plat-spear/include/plat/uncompress.h b/arch/arm/plat-spear/include/mach/uncompress.h
similarity index 100%
rename from arch/arm/plat-spear/include/plat/uncompress.h
rename to arch/arm/plat-spear/include/mach/uncompress.h
-- 
1.8.0
