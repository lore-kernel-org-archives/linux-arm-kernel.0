From: robherring2@gmail.com (Rob Herring)
Date: Mon,  6 Feb 2012 15:03:20 -0600
Subject: [PATCH 3/3] ARM: remove empty disable_fiq and arch_ret_to_user macros
In-Reply-To: <1328562200-8810-1-git-send-email-robherring2@gmail.com>
References: <1328562200-8810-1-git-send-email-robherring2@gmail.com>
Message-ID: <1328562200-8810-4-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Now that most platforms don't need disable_fiq and arch_ret_to_user
macros, we can remove the empty macros or empty entry-macro.S files.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-at91/include/mach/entry-macro.S      |    6 ----
 arch/arm/mach-bcmring/include/mach/entry-macro.S   |    6 ----
 arch/arm/mach-clps711x/include/mach/entry-macro.S  |    6 ----
 arch/arm/mach-cns3xxx/include/mach/entry-macro.S   |   15 -----------
 arch/arm/mach-davinci/include/mach/entry-macro.S   |    6 ----
 arch/arm/mach-dove/include/mach/entry-macro.S      |    6 ----
 arch/arm/mach-ebsa110/include/mach/entry-macro.S   |    6 ----
 arch/arm/mach-ep93xx/include/mach/entry-macro.S    |   17 ------------
 arch/arm/mach-exynos/include/mach/entry-macro.S    |   16 -----------
 .../arm/mach-footbridge/include/mach/entry-macro.S |    6 ----
 arch/arm/mach-gemini/include/mach/entry-macro.S    |    6 ----
 arch/arm/mach-h720x/include/mach/entry-macro.S     |    6 ----
 arch/arm/mach-highbank/include/mach/entry-macro.S  |    5 ---
 .../arm/mach-integrator/include/mach/entry-macro.S |    6 ----
 arch/arm/mach-iop13xx/include/mach/entry-macro.S   |    3 --
 arch/arm/mach-iop32x/include/mach/entry-macro.S    |    3 --
 arch/arm/mach-iop33x/include/mach/entry-macro.S    |    3 --
 arch/arm/mach-ixp2000/include/mach/entry-macro.S   |    6 ----
 arch/arm/mach-ixp23xx/include/mach/entry-macro.S   |    6 ----
 arch/arm/mach-ixp4xx/include/mach/entry-macro.S    |    6 ----
 arch/arm/mach-kirkwood/include/mach/entry-macro.S  |    6 ----
 arch/arm/mach-ks8695/include/mach/entry-macro.S    |    6 ----
 arch/arm/mach-lpc32xx/include/mach/entry-macro.S   |    6 ----
 arch/arm/mach-mmp/include/mach/entry-macro.S       |    6 ----
 arch/arm/mach-msm/include/mach/entry-macro.S       |    6 ----
 arch/arm/mach-mv78xx0/include/mach/entry-macro.S   |    6 ----
 arch/arm/mach-mxs/include/mach/entry-macro.S       |    6 ----
 arch/arm/mach-netx/include/mach/entry-macro.S      |   26 -------------------
 arch/arm/mach-nomadik/include/mach/entry-macro.S   |   13 ---------
 arch/arm/mach-omap1/include/mach/entry-macro.S     |    6 ----
 arch/arm/mach-omap2/include/mach/entry-macro.S     |   18 -------------
 arch/arm/mach-orion5x/include/mach/entry-macro.S   |    6 ----
 arch/arm/mach-picoxcell/include/mach/entry-macro.S |   16 -----------
 arch/arm/mach-pnx4008/include/mach/entry-macro.S   |    6 ----
 arch/arm/mach-prima2/include/mach/entry-macro.S    |    7 -----
 arch/arm/mach-pxa/include/mach/entry-macro.S       |   15 -----------
 arch/arm/mach-realview/include/mach/entry-macro.S  |   16 -----------
 arch/arm/mach-rpc/include/mach/entry-macro.S       |    4 ---
 arch/arm/mach-s3c2410/include/mach/entry-macro.S   |    8 ------
 arch/arm/mach-s3c64xx/include/mach/entry-macro.S   |   19 --------------
 arch/arm/mach-s5p64x0/include/mach/entry-macro.S   |   17 ------------
 arch/arm/mach-s5pc100/include/mach/entry-macro.S   |    6 ----
 arch/arm/mach-s5pv210/include/mach/entry-macro.S   |   17 ------------
 arch/arm/mach-sa1100/include/mach/entry-macro.S    |    6 ----
 arch/arm/mach-shark/include/mach/entry-macro.S     |    6 ----
 arch/arm/mach-shmobile/include/mach/entry-macro.S  |   22 ----------------
 arch/arm/mach-spear3xx/include/mach/entry-macro.S  |   18 -------------
 arch/arm/mach-spear6xx/include/mach/entry-macro.S  |   18 -------------
 arch/arm/mach-tegra/include/mach/entry-macro.S     |   20 --------------
 arch/arm/mach-u300/include/mach/entry-macro.S      |   16 -----------
 arch/arm/mach-ux500/include/mach/entry-macro.S     |   18 -------------
 arch/arm/mach-versatile/include/mach/entry-macro.S |   15 -----------
 arch/arm/mach-vexpress/include/mach/entry-macro.S  |    5 ---
 arch/arm/mach-vt8500/include/mach/entry-macro.S    |    6 ----
 arch/arm/mach-w90x900/include/mach/entry-macro.S   |    8 ------
 arch/arm/mach-zynq/include/mach/entry-macro.S      |   27 --------------------
 arch/arm/plat-mxc/include/mach/entry-macro.S       |   16 -----------
 57 files changed, 0 insertions(+), 583 deletions(-)
 delete mode 100644 arch/arm/mach-cns3xxx/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-ep93xx/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-exynos/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-highbank/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-netx/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-nomadik/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-omap2/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-picoxcell/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-pxa/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-realview/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-s5p64x0/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-s5pv210/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-shmobile/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-spear6xx/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-tegra/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-u300/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-ux500/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-versatile/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-vexpress/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-zynq/include/mach/entry-macro.S
 delete mode 100644 arch/arm/plat-mxc/include/mach/entry-macro.S

diff --git a/arch/arm/mach-at91/include/mach/entry-macro.S b/arch/arm/mach-at91/include/mach/entry-macro.S
index 423eea0..903bf20 100644
--- a/arch/arm/mach-at91/include/mach/entry-macro.S
+++ b/arch/arm/mach-at91/include/mach/entry-macro.S
@@ -13,17 +13,11 @@
 #include <mach/hardware.h>
 #include <mach/at91_aic.h>
 
-	.macro	disable_fiq
-	.endm
-
 	.macro  get_irqnr_preamble, base, tmp
 	ldr	\base, =at91_aic_base		@ base virtual address of AIC peripheral
 	ldr	\base, [\base]
 	.endm
 
-	.macro  arch_ret_to_user, tmp1, tmp2
-	.endm
-
 	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 	ldr	\irqnr, [\base, #AT91_AIC_IVR]		@ read IRQ vector register: de-asserts nIRQ to processor (and clears interrupt)
 	ldr	\irqstat, [\base, #AT91_AIC_ISR]	@ read interrupt source number
diff --git a/arch/arm/mach-bcmring/include/mach/entry-macro.S b/arch/arm/mach-bcmring/include/mach/entry-macro.S
index 94c950d..2f316f0 100644
--- a/arch/arm/mach-bcmring/include/mach/entry-macro.S
+++ b/arch/arm/mach-bcmring/include/mach/entry-macro.S
@@ -21,9 +21,6 @@
 #include <mach/hardware.h>
 #include <mach/csp/mm_io.h>
 
-		.macro	disable_fiq
-		.endm
-
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 		ldr	\base, =(MM_IO_BASE_INTC0)
 		ldr	\irqstat, [\base, #0]		@ get status
@@ -77,6 +74,3 @@
 
 		.macro  get_irqnr_preamble, base, tmp
 		.endm
-
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
diff --git a/arch/arm/mach-clps711x/include/mach/entry-macro.S b/arch/arm/mach-clps711x/include/mach/entry-macro.S
index 90fa2f7..125af59 100644
--- a/arch/arm/mach-clps711x/include/mach/entry-macro.S
+++ b/arch/arm/mach-clps711x/include/mach/entry-macro.S
@@ -10,15 +10,9 @@
 #include <mach/hardware.h>
 #include <asm/hardware/clps7111.h>
 
-		.macro	disable_fiq
-		.endm
-
 		.macro	get_irqnr_preamble, base, tmp
 		.endm
 
-		.macro	arch_ret_to_user, tmp1, tmp2
-		.endm
-
 #if (INTSR2 - INTSR1) != (INTMR2 - INTMR1)
 #error INTSR stride != INTMR stride
 #endif
diff --git a/arch/arm/mach-cns3xxx/include/mach/entry-macro.S b/arch/arm/mach-cns3xxx/include/mach/entry-macro.S
deleted file mode 100644
index 01c57df..0000000
--- a/arch/arm/mach-cns3xxx/include/mach/entry-macro.S
+++ /dev/null
@@ -1,15 +0,0 @@
-/*
- * Low-level IRQ helper macros for Cavium Networks platforms
- *
- * Copyright 2008 Cavium Networks
- *
- * This file is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License, Version 2, as
- * published by the Free Software Foundation.
- */
-
-		.macro	disable_fiq
-		.endm
-
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
diff --git a/arch/arm/mach-davinci/include/mach/entry-macro.S b/arch/arm/mach-davinci/include/mach/entry-macro.S
index e14c0dc..c1661d2 100644
--- a/arch/arm/mach-davinci/include/mach/entry-macro.S
+++ b/arch/arm/mach-davinci/include/mach/entry-macro.S
@@ -11,17 +11,11 @@
 #include <mach/io.h>
 #include <mach/irqs.h>
 
-		.macro	disable_fiq
-		.endm
-
 		.macro  get_irqnr_preamble, base, tmp
 		ldr \base, =davinci_intc_base
 		ldr \base, [\base]
 		.endm
 
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
-
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 #if defined(CONFIG_AINTC) && defined(CONFIG_CP_INTC)
 		ldr \tmp, =davinci_intc_type
diff --git a/arch/arm/mach-dove/include/mach/entry-macro.S b/arch/arm/mach-dove/include/mach/entry-macro.S
index e84c78c..72d622b 100644
--- a/arch/arm/mach-dove/include/mach/entry-macro.S
+++ b/arch/arm/mach-dove/include/mach/entry-macro.S
@@ -10,12 +10,6 @@
 
 #include <mach/bridge-regs.h>
 
-	.macro  disable_fiq
-	.endm
-
-	.macro  arch_ret_to_user, tmp1, tmp2
-	.endm
-
 	.macro  get_irqnr_preamble, base, tmp
 	ldr	\base, =IRQ_VIRT_BASE
 	.endm
diff --git a/arch/arm/mach-ebsa110/include/mach/entry-macro.S b/arch/arm/mach-ebsa110/include/mach/entry-macro.S
index cc3e599..14b110d 100644
--- a/arch/arm/mach-ebsa110/include/mach/entry-macro.S
+++ b/arch/arm/mach-ebsa110/include/mach/entry-macro.S
@@ -12,16 +12,10 @@
 
 #define IRQ_STAT		0xff000000	/* read */
 
-	.macro	disable_fiq
-	.endm
-
 	.macro  get_irqnr_preamble, base, tmp
 	mov	\base, #IRQ_STAT
 	.endm
 
-	.macro  arch_ret_to_user, tmp1, tmp2
-	.endm
-
 	.macro	get_irqnr_and_base, irqnr, stat, base, tmp
 	ldrb	\stat, [\base]			@ get interrupts
 	mov	\irqnr, #0
diff --git a/arch/arm/mach-ep93xx/include/mach/entry-macro.S b/arch/arm/mach-ep93xx/include/mach/entry-macro.S
deleted file mode 100644
index 9be6edc..0000000
--- a/arch/arm/mach-ep93xx/include/mach/entry-macro.S
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- * arch/arm/mach-ep93xx/include/mach/entry-macro.S
- * IRQ demultiplexing for EP93xx
- *
- * Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofly.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or (at
- * your option) any later version.
- */
-
-		.macro	disable_fiq
-		.endm
-
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
diff --git a/arch/arm/mach-exynos/include/mach/entry-macro.S b/arch/arm/mach-exynos/include/mach/entry-macro.S
deleted file mode 100644
index 3ba4f54..0000000
--- a/arch/arm/mach-exynos/include/mach/entry-macro.S
+++ /dev/null
@@ -1,16 +0,0 @@
-/* arch/arm/mach-exynos4/include/mach/entry-macro.S
- *
- * Cloned from arch/arm/mach-realview/include/mach/entry-macro.S
- *
- * Low-level IRQ helper macros for EXYNOS4 platforms
- *
- * This file is licensed under  the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
-*/
-
-		.macro	disable_fiq
-		.endm
-
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
diff --git a/arch/arm/mach-footbridge/include/mach/entry-macro.S b/arch/arm/mach-footbridge/include/mach/entry-macro.S
index d3847be..dabbd5c 100644
--- a/arch/arm/mach-footbridge/include/mach/entry-macro.S
+++ b/arch/arm/mach-footbridge/include/mach/entry-macro.S
@@ -14,9 +14,6 @@
 		.equ	dc21285_high, ARMCSR_BASE & 0xff000000
 		.equ	dc21285_low, ARMCSR_BASE & 0x00ffffff
 
-		.macro	disable_fiq
-		.endm
-
 		.macro  get_irqnr_preamble, base, tmp
 		mov	\base, #dc21285_high
 		.if	dc21285_low
@@ -24,9 +21,6 @@
 		.endif
 		.endm
 
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
-
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 		ldr	\irqstat, [\base, #0x180]	@ get interrupts
 
diff --git a/arch/arm/mach-gemini/include/mach/entry-macro.S b/arch/arm/mach-gemini/include/mach/entry-macro.S
index 1624f91..f044e43 100644
--- a/arch/arm/mach-gemini/include/mach/entry-macro.S
+++ b/arch/arm/mach-gemini/include/mach/entry-macro.S
@@ -12,15 +12,9 @@
 
 #define IRQ_STATUS	0x14
 
-	.macro  disable_fiq
-	.endm
-
 	.macro  get_irqnr_preamble, base, tmp
 	.endm
 
-	.macro  arch_ret_to_user, tmp1, tmp2
-	.endm
-
 	.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
 	ldr     \irqstat, =IO_ADDRESS(GEMINI_INTERRUPT_BASE + IRQ_STATUS)
 	ldr     \irqnr, [\irqstat]
diff --git a/arch/arm/mach-h720x/include/mach/entry-macro.S b/arch/arm/mach-h720x/include/mach/entry-macro.S
index c3948e5..75267fa 100644
--- a/arch/arm/mach-h720x/include/mach/entry-macro.S
+++ b/arch/arm/mach-h720x/include/mach/entry-macro.S
@@ -8,15 +8,9 @@
  * warranty of any kind, whether express or implied.
  */
 
-		.macro  disable_fiq
-		.endm
-
 		.macro  get_irqnr_preamble, base, tmp
 		.endm
 
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
-
 		.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
 #if defined (CONFIG_CPU_H7201) || defined (CONFIG_CPU_H7202)
 		@ we could use the id register on H7202, but this is not
diff --git a/arch/arm/mach-highbank/include/mach/entry-macro.S b/arch/arm/mach-highbank/include/mach/entry-macro.S
deleted file mode 100644
index a14f9e6..0000000
--- a/arch/arm/mach-highbank/include/mach/entry-macro.S
+++ /dev/null
@@ -1,5 +0,0 @@
-	.macro	disable_fiq
-	.endm
-
-	.macro	arch_ret_to_user, tmp1, tmp2
-	.endm
diff --git a/arch/arm/mach-integrator/include/mach/entry-macro.S b/arch/arm/mach-integrator/include/mach/entry-macro.S
index 3d029c9..5cc7b85 100644
--- a/arch/arm/mach-integrator/include/mach/entry-macro.S
+++ b/arch/arm/mach-integrator/include/mach/entry-macro.S
@@ -11,15 +11,9 @@
 #include <mach/platform.h>
 #include <mach/irqs.h>
 
- 		.macro	disable_fiq
-		.endm
-
 		.macro  get_irqnr_preamble, base, tmp
 		.endm
 
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
-
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 /* FIXME: should not be using soo many LDRs here */
 		ldr	\base, =IO_ADDRESS(INTEGRATOR_IC_BASE)
diff --git a/arch/arm/mach-iop13xx/include/mach/entry-macro.S b/arch/arm/mach-iop13xx/include/mach/entry-macro.S
index a624a78..1a2d603 100644
--- a/arch/arm/mach-iop13xx/include/mach/entry-macro.S
+++ b/arch/arm/mach-iop13xx/include/mach/entry-macro.S
@@ -16,9 +16,6 @@
  * Place - Suite 330, Boston, MA 02111-1307 USA.
  *
  */
-	.macro  disable_fiq
-	.endm
-
 	.macro get_irqnr_preamble, base, tmp
 	mrc	p15, 0, \tmp, c15, c1, 0
 	orr	\tmp, \tmp, #(1 << 6)
diff --git a/arch/arm/mach-iop32x/include/mach/entry-macro.S b/arch/arm/mach-iop32x/include/mach/entry-macro.S
index b02fb56..ea13ae0 100644
--- a/arch/arm/mach-iop32x/include/mach/entry-macro.S
+++ b/arch/arm/mach-iop32x/include/mach/entry-macro.S
@@ -9,9 +9,6 @@
  */
 #include <mach/iop32x.h>
 
-	.macro	disable_fiq
-	.endm
-
 	.macro get_irqnr_preamble, base, tmp
 	mrc	p15, 0, \tmp, c15, c1, 0
 	orr	\tmp, \tmp, #(1 << 6)
diff --git a/arch/arm/mach-iop33x/include/mach/entry-macro.S b/arch/arm/mach-iop33x/include/mach/entry-macro.S
index 4e1f728..0a398fe 100644
--- a/arch/arm/mach-iop33x/include/mach/entry-macro.S
+++ b/arch/arm/mach-iop33x/include/mach/entry-macro.S
@@ -9,9 +9,6 @@
  */
 #include <mach/iop33x.h>
 
-	.macro	disable_fiq
-	.endm
-
 	.macro get_irqnr_preamble, base, tmp
 	mrc	p15, 0, \tmp, c15, c1, 0
 	orr	\tmp, \tmp, #(1 << 6)
diff --git a/arch/arm/mach-ixp2000/include/mach/entry-macro.S b/arch/arm/mach-ixp2000/include/mach/entry-macro.S
index 5850ffc..c4444df 100644
--- a/arch/arm/mach-ixp2000/include/mach/entry-macro.S
+++ b/arch/arm/mach-ixp2000/include/mach/entry-macro.S
@@ -9,15 +9,9 @@
  */
 #include <mach/irqs.h>
 
-		.macro  disable_fiq
-		.endm
-
 		.macro  get_irqnr_preamble, base, tmp
 		.endm
 
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
-
 		.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
 
 		mov	\irqnr, #0x0              @clear out irqnr as default
diff --git a/arch/arm/mach-ixp23xx/include/mach/entry-macro.S b/arch/arm/mach-ixp23xx/include/mach/entry-macro.S
index 3f5338a..3fd2cb9 100644
--- a/arch/arm/mach-ixp23xx/include/mach/entry-macro.S
+++ b/arch/arm/mach-ixp23xx/include/mach/entry-macro.S
@@ -2,15 +2,9 @@
  * arch/arm/mach-ixp23xx/include/mach/entry-macro.S
  */
 
-		.macro	disable_fiq
-		.endm
-
 		.macro  get_irqnr_preamble, base, tmp
 		.endm
 
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
-
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 		ldr	\irqnr, =(IXP23XX_INTC_VIRT + IXP23XX_INTR_IRQ_ENC_ST_OFFSET)
 		ldr	\irqnr, [\irqnr]	@ get interrupt number
diff --git a/arch/arm/mach-ixp4xx/include/mach/entry-macro.S b/arch/arm/mach-ixp4xx/include/mach/entry-macro.S
index f2e14e9..79adf83 100644
--- a/arch/arm/mach-ixp4xx/include/mach/entry-macro.S
+++ b/arch/arm/mach-ixp4xx/include/mach/entry-macro.S
@@ -9,15 +9,9 @@
  */
 #include <mach/hardware.h>
 
-		.macro	disable_fiq
-		.endm
-
 		.macro  get_irqnr_preamble, base, tmp
 		.endm
 
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
-
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 		ldr	\irqstat, =(IXP4XX_INTC_BASE_VIRT+IXP4XX_ICIP_OFFSET)
 		ldr	\irqstat, [\irqstat]		@ get interrupts
diff --git a/arch/arm/mach-kirkwood/include/mach/entry-macro.S b/arch/arm/mach-kirkwood/include/mach/entry-macro.S
index 8939d36..82db29f 100644
--- a/arch/arm/mach-kirkwood/include/mach/entry-macro.S
+++ b/arch/arm/mach-kirkwood/include/mach/entry-macro.S
@@ -10,12 +10,6 @@
 
 #include <mach/bridge-regs.h>
 
-	.macro  disable_fiq
-	.endm
-
-	.macro  arch_ret_to_user, tmp1, tmp2
-	.endm
-
 	.macro  get_irqnr_preamble, base, tmp
 	ldr	\base, =IRQ_VIRT_BASE
 	.endm
diff --git a/arch/arm/mach-ks8695/include/mach/entry-macro.S b/arch/arm/mach-ks8695/include/mach/entry-macro.S
index b4fe0c1..8315b34 100644
--- a/arch/arm/mach-ks8695/include/mach/entry-macro.S
+++ b/arch/arm/mach-ks8695/include/mach/entry-macro.S
@@ -14,16 +14,10 @@
 #include <mach/hardware.h>
 #include <mach/regs-irq.h>
 
-	.macro	disable_fiq
-	.endm
-
 	.macro  get_irqnr_preamble, base, tmp
 		ldr	\base, =KS8695_IRQ_VA			@ Base address of interrupt controller
 	.endm
 
-	.macro  arch_ret_to_user, tmp1, tmp2
-	.endm
-
 	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 		ldr	\irqstat, [\base, #KS8695_INTMS]	@ Mask Status register
 
diff --git a/arch/arm/mach-lpc32xx/include/mach/entry-macro.S b/arch/arm/mach-lpc32xx/include/mach/entry-macro.S
index b725f6c..24ca11b 100644
--- a/arch/arm/mach-lpc32xx/include/mach/entry-macro.S
+++ b/arch/arm/mach-lpc32xx/include/mach/entry-macro.S
@@ -21,16 +21,10 @@
 
 #define LPC32XX_INTC_MASKED_STATUS_OFS	0x8
 
-	.macro	disable_fiq
-	.endm
-
 	.macro  get_irqnr_preamble, base, tmp
 	ldr	\base, =IO_ADDRESS(LPC32XX_MIC_BASE)
 	.endm
 
-	.macro  arch_ret_to_user, tmp1, tmp2
-	.endm
-
 /*
  * Return IRQ number in irqnr. Also return processor Z flag status in CPSR
  * as set if an interrupt is pending.
diff --git a/arch/arm/mach-mmp/include/mach/entry-macro.S b/arch/arm/mach-mmp/include/mach/entry-macro.S
index c42d9d4..9cff9e7 100644
--- a/arch/arm/mach-mmp/include/mach/entry-macro.S
+++ b/arch/arm/mach-mmp/include/mach/entry-macro.S
@@ -8,12 +8,6 @@
 
 #include <mach/regs-icu.h>
 
-	.macro	disable_fiq
-	.endm
-
-	.macro	arch_ret_to_user, tmp1, tmp2
-	.endm
-
 	.macro	get_irqnr_preamble, base, tmp
 	mrc	p15, 0, \tmp, c0, c0, 0		@ CPUID
 	and	\tmp, \tmp, #0xff00
diff --git a/arch/arm/mach-msm/include/mach/entry-macro.S b/arch/arm/mach-msm/include/mach/entry-macro.S
index 41f7003..f2ae908 100644
--- a/arch/arm/mach-msm/include/mach/entry-macro.S
+++ b/arch/arm/mach-msm/include/mach/entry-macro.S
@@ -16,12 +16,6 @@
  *
  */
 
-	.macro	disable_fiq
-	.endm
-
-	.macro	arch_ret_to_user, tmp1, tmp2
-	.endm
-
 #if !defined(CONFIG_ARM_GIC)
 #include <mach/msm_iomap.h>
 
diff --git a/arch/arm/mach-mv78xx0/include/mach/entry-macro.S b/arch/arm/mach-mv78xx0/include/mach/entry-macro.S
index 66ae2d2..6b1f088 100644
--- a/arch/arm/mach-mv78xx0/include/mach/entry-macro.S
+++ b/arch/arm/mach-mv78xx0/include/mach/entry-macro.S
@@ -10,12 +10,6 @@
 
 #include <mach/bridge-regs.h>
 
-	.macro  disable_fiq
-	.endm
-
-	.macro  arch_ret_to_user, tmp1, tmp2
-	.endm
-
 	.macro  get_irqnr_preamble, base, tmp
 	ldr	\base, =IRQ_VIRT_BASE
 	.endm
diff --git a/arch/arm/mach-mxs/include/mach/entry-macro.S b/arch/arm/mach-mxs/include/mach/entry-macro.S
index 9f0da12..0c14259 100644
--- a/arch/arm/mach-mxs/include/mach/entry-macro.S
+++ b/arch/arm/mach-mxs/include/mach/entry-macro.S
@@ -23,9 +23,6 @@
 #define MXS_ICOLL_VBASE		MXS_IO_ADDRESS(MXS_ICOLL_BASE_ADDR)
 #define HW_ICOLL_STAT_OFFSET	0x70
 
-	.macro	disable_fiq
-	.endm
-
 	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 	ldr	\irqnr, [\base, #HW_ICOLL_STAT_OFFSET]
 	cmp	\irqnr, #0x7F
@@ -36,6 +33,3 @@
 	.macro  get_irqnr_preamble, base, tmp
 	ldr	\base, =MXS_ICOLL_VBASE
 	.endm
-
-	.macro  arch_ret_to_user, tmp1, tmp2
-	.endm
diff --git a/arch/arm/mach-netx/include/mach/entry-macro.S b/arch/arm/mach-netx/include/mach/entry-macro.S
deleted file mode 100644
index 6e9f1cb..0000000
--- a/arch/arm/mach-netx/include/mach/entry-macro.S
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * arch/arm/mach-netx/include/mach/entry-macro.S
- *
- * Low-level IRQ helper macros for Hilscher netX based platforms
- *
- * Copyright (C) 2005 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2
- * as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-		.macro  disable_fiq
-		.endm
-
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
diff --git a/arch/arm/mach-nomadik/include/mach/entry-macro.S b/arch/arm/mach-nomadik/include/mach/entry-macro.S
deleted file mode 100644
index 98ea1c1..0000000
--- a/arch/arm/mach-nomadik/include/mach/entry-macro.S
+++ /dev/null
@@ -1,13 +0,0 @@
-/*
- * Low-level IRQ helper macros for Nomadik platforms
- *
- * This file is licensed under  the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-	.macro	disable_fiq
-	.endm
-
-	.macro	arch_ret_to_user, tmp1, tmp2
-	.endm
diff --git a/arch/arm/mach-omap1/include/mach/entry-macro.S b/arch/arm/mach-omap1/include/mach/entry-macro.S
index bfb4fb1..83c0250 100644
--- a/arch/arm/mach-omap1/include/mach/entry-macro.S
+++ b/arch/arm/mach-omap1/include/mach/entry-macro.S
@@ -14,15 +14,9 @@
 #include <mach/irqs.h>
 #include <asm/hardware/gic.h>
 
- 		.macro	disable_fiq
-		.endm
-
 		.macro  get_irqnr_preamble, base, tmp
 		.endm
 
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
-
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 		ldr	\base, =OMAP1_IO_ADDRESS(OMAP_IH1_BASE)
 		ldr	\irqnr, [\base, #IRQ_ITR_REG_OFFSET]
diff --git a/arch/arm/mach-omap2/include/mach/entry-macro.S b/arch/arm/mach-omap2/include/mach/entry-macro.S
deleted file mode 100644
index 56964a0..0000000
--- a/arch/arm/mach-omap2/include/mach/entry-macro.S
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * arch/arm/plat-omap/include/mach/entry-macro.S
- *
- * Low-level IRQ helper macros for OMAP-based platforms
- *
- * Copyright (C) 2009 Texas Instruments
- * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
- *
- * This file is licensed under  the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-		.macro	disable_fiq
-		.endm
-
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
diff --git a/arch/arm/mach-orion5x/include/mach/entry-macro.S b/arch/arm/mach-orion5x/include/mach/entry-macro.S
index d658992..79eb502 100644
--- a/arch/arm/mach-orion5x/include/mach/entry-macro.S
+++ b/arch/arm/mach-orion5x/include/mach/entry-macro.S
@@ -10,12 +10,6 @@
 
 #include <mach/bridge-regs.h>
 
-	.macro  disable_fiq
-	.endm
-
-	.macro  arch_ret_to_user, tmp1, tmp2
-	.endm
-
 	.macro  get_irqnr_preamble, base, tmp
 	ldr	\base, =MAIN_IRQ_CAUSE
 	.endm
diff --git a/arch/arm/mach-picoxcell/include/mach/entry-macro.S b/arch/arm/mach-picoxcell/include/mach/entry-macro.S
deleted file mode 100644
index 9b505ac..0000000
--- a/arch/arm/mach-picoxcell/include/mach/entry-macro.S
+++ /dev/null
@@ -1,16 +0,0 @@
-/*
- * entry-macro.S
- *
- * Copyright (c) 2011 Picochip Ltd., Jamie Iles
- *
- * Low-level IRQ helper macros for picoXcell platforms
- *
- * This file is licensed under  the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-	.macro  disable_fiq
-	.endm
-
-	.macro  arch_ret_to_user, tmp1, tmp2
-	.endm
diff --git a/arch/arm/mach-pnx4008/include/mach/entry-macro.S b/arch/arm/mach-pnx4008/include/mach/entry-macro.S
index db7eeeb..77a5558 100644
--- a/arch/arm/mach-pnx4008/include/mach/entry-macro.S
+++ b/arch/arm/mach-pnx4008/include/mach/entry-macro.S
@@ -25,15 +25,9 @@
 #define SIC1_BASE_INT   32
 #define SIC2_BASE_INT   64
 
-		.macro	disable_fiq
-		.endm
-
 		.macro  get_irqnr_preamble, base, tmp
 		.endm
 
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
-
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 /* decode the MIC interrupt numbers */
 		ldr	\base, =IO_ADDRESS(PNX4008_INTCTRLMIC_BASE)
diff --git a/arch/arm/mach-prima2/include/mach/entry-macro.S b/arch/arm/mach-prima2/include/mach/entry-macro.S
index 1c8a50f..86434e7 100644
--- a/arch/arm/mach-prima2/include/mach/entry-macro.S
+++ b/arch/arm/mach-prima2/include/mach/entry-macro.S
@@ -20,10 +20,3 @@
 	cmp \irqnr, #0x40			@ the irq num can't be larger than 0x3f
 	movges \irqnr, #0
 	.endm
-
-	.macro  disable_fiq
-	.endm
-
-	.macro  arch_ret_to_user, tmp1, tmp2
-	.endm
-
diff --git a/arch/arm/mach-pxa/include/mach/entry-macro.S b/arch/arm/mach-pxa/include/mach/entry-macro.S
deleted file mode 100644
index 260c0c1..0000000
--- a/arch/arm/mach-pxa/include/mach/entry-macro.S
+++ /dev/null
@@ -1,15 +0,0 @@
-/*
- * arch/arm/mach-pxa/include/mach/entry-macro.S
- *
- * Low-level IRQ helper macros for PXA-based platforms
- *
- * This file is licensed under  the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-		.macro	disable_fiq
-		.endm
-
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
diff --git a/arch/arm/mach-realview/include/mach/entry-macro.S b/arch/arm/mach-realview/include/mach/entry-macro.S
deleted file mode 100644
index e8a5179..0000000
--- a/arch/arm/mach-realview/include/mach/entry-macro.S
+++ /dev/null
@@ -1,16 +0,0 @@
-/*
- * arch/arm/mach-realview/include/mach/entry-macro.S
- *
- * Low-level IRQ helper macros for RealView platforms
- *
- * This file is licensed under  the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-		.macro	disable_fiq
-		.endm
-
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
-
diff --git a/arch/arm/mach-rpc/include/mach/entry-macro.S b/arch/arm/mach-rpc/include/mach/entry-macro.S
index 4e7e541..7178368 100644
--- a/arch/arm/mach-rpc/include/mach/entry-macro.S
+++ b/arch/arm/mach-rpc/include/mach/entry-macro.S
@@ -10,7 +10,3 @@
 	orr	\base, \base, #ioc_base_low
 	.endif
 	.endm
-
-	.macro  arch_ret_to_user, tmp1, tmp2
-	.endm
-
diff --git a/arch/arm/mach-s3c2410/include/mach/entry-macro.S b/arch/arm/mach-s3c2410/include/mach/entry-macro.S
index 473b3cd..7615a14 100644
--- a/arch/arm/mach-s3c2410/include/mach/entry-macro.S
+++ b/arch/arm/mach-s3c2410/include/mach/entry-macro.S
@@ -25,9 +25,6 @@
 	.macro  get_irqnr_preamble, base, tmp
 	.endm
 
-	.macro  arch_ret_to_user, tmp1, tmp2
-	.endm
-
 	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 
 		mov	\base, #S3C24XX_VA_IRQ
@@ -71,8 +68,3 @@
 		@@ exit here, Z flag unset if IRQ
 
 	.endm
-
-		/* currently don't need an disable_fiq macro */
-
-		.macro	disable_fiq
-		.endm
diff --git a/arch/arm/mach-s3c64xx/include/mach/entry-macro.S b/arch/arm/mach-s3c64xx/include/mach/entry-macro.S
deleted file mode 100644
index dc2bc15..0000000
--- a/arch/arm/mach-s3c64xx/include/mach/entry-macro.S
+++ /dev/null
@@ -1,19 +0,0 @@
-/* arch/arm/mach-s3c6400/include/mach/entry-macro.S
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * Low-level IRQ helper macros for the Samsung S3C64XX series
- *
- * This file is licensed under  the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
-*/
-
-		.macro  disable_fiq
-		.endm
-
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
diff --git a/arch/arm/mach-s5p64x0/include/mach/entry-macro.S b/arch/arm/mach-s5p64x0/include/mach/entry-macro.S
deleted file mode 100644
index fbb246d..0000000
--- a/arch/arm/mach-s5p64x0/include/mach/entry-macro.S
+++ /dev/null
@@ -1,17 +0,0 @@
-/* linux/arch/arm/mach-s5p64x0/include/mach/entry-macro.S
- *
- * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * Low-level IRQ helper macros for the Samsung S5P64X0
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-		.macro  disable_fiq
-		.endm
-
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
diff --git a/arch/arm/mach-s5pc100/include/mach/entry-macro.S b/arch/arm/mach-s5pc100/include/mach/entry-macro.S
index b8c242e..bad0700 100644
--- a/arch/arm/mach-s5pc100/include/mach/entry-macro.S
+++ b/arch/arm/mach-s5pc100/include/mach/entry-macro.S
@@ -12,14 +12,8 @@
  * warranty of any kind, whether express or implied.
 */
 
-	.macro	disable_fiq
-	.endm
-
 	.macro	get_irqnr_preamble, base, tmp
 	.endm
 
-	.macro	arch_ret_to_user, tmp1, tmp2
-	.endm
-
 	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 	.endm
diff --git a/arch/arm/mach-s5pv210/include/mach/entry-macro.S b/arch/arm/mach-s5pv210/include/mach/entry-macro.S
deleted file mode 100644
index bebca1b..0000000
--- a/arch/arm/mach-s5pv210/include/mach/entry-macro.S
+++ /dev/null
@@ -1,17 +0,0 @@
-/* linux/arch/arm/mach-s5pv210/include/mach/entry-macro.S
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * Low-level IRQ helper macros for the Samsung S5PV210
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-	.macro	disable_fiq
-	.endm
-
-	.macro	arch_ret_to_user, tmp1, tmp2
-	.endm
diff --git a/arch/arm/mach-sa1100/include/mach/entry-macro.S b/arch/arm/mach-sa1100/include/mach/entry-macro.S
index 6aa13c4..8cf7630 100644
--- a/arch/arm/mach-sa1100/include/mach/entry-macro.S
+++ b/arch/arm/mach-sa1100/include/mach/entry-macro.S
@@ -8,17 +8,11 @@
  * warranty of any kind, whether express or implied.
  */
 
- 		.macro	disable_fiq
-		.endm
-
 		.macro  get_irqnr_preamble, base, tmp
 		mov	\base, #0xfa000000		@ ICIP = 0xfa050000
 		add	\base, \base, #0x00050000
 		.endm
 
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
-
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 		ldr	\irqstat, [\base]		@ get irqs
 		ldr	\irqnr, [\base, #4]		@ ICMR = 0xfa050004
diff --git a/arch/arm/mach-shark/include/mach/entry-macro.S b/arch/arm/mach-shark/include/mach/entry-macro.S
index 0bb6cc6..5901b09 100644
--- a/arch/arm/mach-shark/include/mach/entry-macro.S
+++ b/arch/arm/mach-shark/include/mach/entry-macro.S
@@ -7,16 +7,10 @@
  * License version 2. This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
-		.macro	disable_fiq
-		.endm
-
 		.macro  get_irqnr_preamble, base, tmp
 		mov	\base, #0xe0000000
 		.endm
 
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
-
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 
 		mov	\irqstat, #0x0C
diff --git a/arch/arm/mach-shmobile/include/mach/entry-macro.S b/arch/arm/mach-shmobile/include/mach/entry-macro.S
deleted file mode 100644
index 2a57b29..0000000
--- a/arch/arm/mach-shmobile/include/mach/entry-macro.S
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * Copyright (C) 2010  Paul Mundt
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-	.macro  disable_fiq
-	.endm
-
-	.macro  arch_ret_to_user, tmp1, tmp2
-	.endm
diff --git a/arch/arm/mach-spear3xx/include/mach/entry-macro.S b/arch/arm/mach-spear3xx/include/mach/entry-macro.S
deleted file mode 100644
index de3bb41..0000000
--- a/arch/arm/mach-spear3xx/include/mach/entry-macro.S
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * arch/arm/mach-spear3xx/include/mach/entry-macro.S
- *
- * Low-level IRQ helper macros for SPEAr3xx machine family
- *
- * Copyright (C) 2009 ST Microelectronics
- * Viresh Kumar<viresh.kumar@st.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-		.macro	disable_fiq
-		.endm
-
-		.macro	arch_ret_to_user, tmp1, tmp2
-		.endm
diff --git a/arch/arm/mach-spear6xx/include/mach/entry-macro.S b/arch/arm/mach-spear6xx/include/mach/entry-macro.S
deleted file mode 100644
index d490a91..0000000
--- a/arch/arm/mach-spear6xx/include/mach/entry-macro.S
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * arch/arm/mach-spear6xx/include/mach/entry-macro.S
- *
- * Low-level IRQ helper macros for SPEAr6xx machine family
- *
- * Copyright (C) 2009 ST Microelectronics
- * Rajeev Kumar<rajeev-dlh.kumar@st.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-		.macro	disable_fiq
-		.endm
-
-		.macro	arch_ret_to_user, tmp1, tmp2
-		.endm
diff --git a/arch/arm/mach-tegra/include/mach/entry-macro.S b/arch/arm/mach-tegra/include/mach/entry-macro.S
deleted file mode 100644
index e577cfe..0000000
--- a/arch/arm/mach-tegra/include/mach/entry-macro.S
+++ /dev/null
@@ -1,20 +0,0 @@
-/* arch/arm/mach-tegra/include/mach/entry-macro.S
- *
- * Copyright (C) 2009 Palm, Inc.
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-	.macro	disable_fiq
-	.endm
-
-	.macro	arch_ret_to_user, tmp1, tmp2
-	.endm
diff --git a/arch/arm/mach-u300/include/mach/entry-macro.S b/arch/arm/mach-u300/include/mach/entry-macro.S
deleted file mode 100644
index 7181d6a..0000000
--- a/arch/arm/mach-u300/include/mach/entry-macro.S
+++ /dev/null
@@ -1,16 +0,0 @@
-/*
- *
- * arch-arm/mach-u300/include/mach/entry-macro.S
- *
- *
- * Copyright (C) 2006-2009 ST-Ericsson AB
- * License terms: GNU General Public License (GPL) version 2
- * Low-level IRQ helper macros for ST-Ericsson U300
- * Author: Linus Walleij <linus.walleij@stericsson.com>
- */
-
-	.macro	disable_fiq
-	.endm
-
-	.macro  arch_ret_to_user, tmp1, tmp2
-	.endm
diff --git a/arch/arm/mach-ux500/include/mach/entry-macro.S b/arch/arm/mach-ux500/include/mach/entry-macro.S
deleted file mode 100644
index e16299e..0000000
--- a/arch/arm/mach-ux500/include/mach/entry-macro.S
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * Low-level IRQ helper macros for U8500 platforms
- *
- * Copyright (C) 2009 ST-Ericsson.
- *
- * This file is a copy of ARM Realview platform.
- *	-just satisfied checkpatch script.
- *
- * This file is licensed under  the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-		.macro	disable_fiq
-		.endm
-
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
diff --git a/arch/arm/mach-versatile/include/mach/entry-macro.S b/arch/arm/mach-versatile/include/mach/entry-macro.S
deleted file mode 100644
index b6f0dbf..0000000
--- a/arch/arm/mach-versatile/include/mach/entry-macro.S
+++ /dev/null
@@ -1,15 +0,0 @@
-/*
- * arch/arm/mach-versatile/include/mach/entry-macro.S
- *
- * Low-level IRQ helper macros for Versatile platforms
- *
- * This file is licensed under  the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-		.macro	disable_fiq
-		.endm
-
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
diff --git a/arch/arm/mach-vexpress/include/mach/entry-macro.S b/arch/arm/mach-vexpress/include/mach/entry-macro.S
deleted file mode 100644
index a14f9e6..0000000
--- a/arch/arm/mach-vexpress/include/mach/entry-macro.S
+++ /dev/null
@@ -1,5 +0,0 @@
-	.macro	disable_fiq
-	.endm
-
-	.macro	arch_ret_to_user, tmp1, tmp2
-	.endm
diff --git a/arch/arm/mach-vt8500/include/mach/entry-macro.S b/arch/arm/mach-vt8500/include/mach/entry-macro.S
index 92684c7..367d1b5 100644
--- a/arch/arm/mach-vt8500/include/mach/entry-macro.S
+++ b/arch/arm/mach-vt8500/include/mach/entry-macro.S
@@ -8,18 +8,12 @@
  * warranty of any kind, whether express or implied.
  */
 
-	.macro	disable_fiq
-	.endm
-
 	.macro  get_irqnr_preamble, base, tmp
 	@ physical 0xd8140000 is virtual 0xf8140000
 	mov	\base, #0xf8000000
 	orr	\base, \base, #0x00140000
 	.endm
 
-	.macro  arch_ret_to_user, tmp1, tmp2
-	.endm
-
 	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 	ldr	\irqnr, [\base]
 	cmp	\irqnr, #63 @ may be false positive, check interrupt status
diff --git a/arch/arm/mach-w90x900/include/mach/entry-macro.S b/arch/arm/mach-w90x900/include/mach/entry-macro.S
index d39aca5..e286dac 100644
--- a/arch/arm/mach-w90x900/include/mach/entry-macro.S
+++ b/arch/arm/mach-w90x900/include/mach/entry-macro.S
@@ -15,9 +15,6 @@
 	.macro  get_irqnr_preamble, base, tmp
 	.endm
 
-	.macro  arch_ret_to_user, tmp1, tmp2
-	.endm
-
 	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 
 		mov	\base, #AIC_BA
@@ -27,8 +24,3 @@
 		cmp	\irqnr, #0
 
 	.endm
-
-	/* currently don't need an disable_fiq macro */
-
-	.macro	disable_fiq
-	.endm
diff --git a/arch/arm/mach-zynq/include/mach/entry-macro.S b/arch/arm/mach-zynq/include/mach/entry-macro.S
deleted file mode 100644
index d621fb7..0000000
--- a/arch/arm/mach-zynq/include/mach/entry-macro.S
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * arch/arm/mach-zynq/include/mach/entry-macro.S
- *
- * Low-level IRQ helper macros
- *
- *  Copyright (C) 2011 Xilinx
- *
- * based on arch/plat-mxc/include/mach/entry-macro.S
- *
- *  Copyright (C) 2007 Lennert Buytenhek <buytenh@wantstofly.org>
- *  Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-		.macro  disable_fiq
-		.endm
-
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
diff --git a/arch/arm/plat-mxc/include/mach/entry-macro.S b/arch/arm/plat-mxc/include/mach/entry-macro.S
deleted file mode 100644
index def5d30..0000000
--- a/arch/arm/plat-mxc/include/mach/entry-macro.S
+++ /dev/null
@@ -1,16 +0,0 @@
-/*
- *  Copyright (C) 2007 Lennert Buytenhek <buytenh@wantstofly.org>
- *  Copyright 2004-2009 Freescale Semiconductor, Inc. All Rights Reserved.
- */
-
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-	.macro	disable_fiq
-	.endm
-
-	.macro  arch_ret_to_user, tmp1, tmp2
-	.endm
-- 
1.7.5.4
