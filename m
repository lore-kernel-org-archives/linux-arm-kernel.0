From: zoss@devai.org (Zoltan Devai)
Date: Sun, 23 Oct 2011 23:10:43 +0200
Subject: [RFC PATCH 13/15] ARM: uncompress.h: Cleanup header guards and banners
In-Reply-To: <1319404245-12740-1-git-send-email-zoss@devai.org>
References: <1319404245-12740-1-git-send-email-zoss@devai.org>
Message-ID: <1319404245-12740-13-git-send-email-zoss@devai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bring some standard into the files:
- uncompress.h should only be included once, don't hide an
  error with the header guards
- If the copyright banner is longer than the real content,
  or the file has been mostly rewritten, just stick
  a short-form GPl notice on top

Signed-off-by: Zoltan Devai <zoss@devai.org>
---
 arch/arm/mach-at91/include/mach/uncompress.h       |   31 +------------------
 arch/arm/mach-bcmring/include/mach/uncompress.h    |   18 +++--------
 arch/arm/mach-clps711x/include/mach/uncompress.h   |   18 +----------
 arch/arm/mach-cns3xxx/include/mach/uncompress.h    |    8 +----
 arch/arm/mach-dove/include/mach/uncompress.h       |    3 --
 arch/arm/mach-ebsa110/include/mach/uncompress.h    |    5 ---
 arch/arm/mach-exynos4/include/mach/uncompress.h    |   15 +--------
 arch/arm/mach-footbridge/include/mach/uncompress.h |    8 +----
 arch/arm/mach-gemini/include/mach/uncompress.h     |   16 +---------
 arch/arm/mach-h720x/include/mach/uncompress.h      |   12 ++------
 arch/arm/mach-integrator/include/mach/uncompress.h |   18 +----------
 arch/arm/mach-iop13xx/include/mach/uncompress.h    |    5 +++
 arch/arm/mach-iop32x/include/mach/uncompress.h     |    4 ++-
 arch/arm/mach-iop33x/include/mach/uncompress.h     |    5 ++-
 arch/arm/mach-ixp2000/include/mach/uncompress.h    |   16 ++--------
 arch/arm/mach-ixp23xx/include/mach/uncompress.h    |   10 ------
 arch/arm/mach-ixp4xx/include/mach/uncompress.h     |   12 -------
 arch/arm/mach-kirkwood/include/mach/uncompress.h   |    2 -
 arch/arm/mach-ks8695/include/mach/uncompress.h     |   13 --------
 arch/arm/mach-lpc32xx/include/mach/uncompress.h    |   22 +-------------
 arch/arm/mach-mmp/include/mach/uncompress.h        |    2 -
 arch/arm/mach-msm/include/mach/uncompress.h        |   28 +++++-------------
 arch/arm/mach-mv78xx0/include/mach/uncompress.h    |    2 -
 arch/arm/mach-mxs/include/mach/uncompress.h        |   21 +------------
 arch/arm/mach-netx/include/mach/uncompress.h       |   25 +--------------
 arch/arm/mach-nomadik/include/mach/uncompress.h    |   22 +-------------
 arch/arm/mach-omap1/include/mach/uncompress.h      |    4 --
 arch/arm/mach-omap2/include/mach/uncompress.h      |    4 --
 arch/arm/mach-orion5x/include/mach/uncompress.h    |   10 ++----
 arch/arm/mach-picoxcell/include/mach/uncompress.h  |   16 +---------
 arch/arm/mach-pnx4008/include/mach/uncompress.h    |   20 +-----------
 arch/arm/mach-prima2/include/mach/uncompress.h     |   13 ++------
 arch/arm/mach-pxa/include/mach/uncompress.h        |    5 ---
 arch/arm/mach-realview/include/mach/uncompress.h   |   18 +----------
 arch/arm/mach-s3c64xx/include/mach/uncompress.h    |   18 +----------
 arch/arm/mach-s5p64x0/include/mach/uncompress.h    |    6 ----
 arch/arm/mach-s5pc100/include/mach/uncompress.h    |    6 ----
 arch/arm/mach-s5pv210/include/mach/uncompress.h    |   16 +---------
 arch/arm/mach-sa1100/include/mach/uncompress.h     |    9 ++----
 arch/arm/mach-shark/include/mach/uncompress.h      |    9 ++----
 arch/arm/mach-shmobile/include/mach/uncompress.h   |   13 +++-----
 arch/arm/mach-spear3xx/include/mach/uncompress.h   |   18 -----------
 arch/arm/mach-spear6xx/include/mach/uncompress.h   |   18 -----------
 arch/arm/mach-tegra/include/mach/uncompress.h      |   26 ++--------------
 arch/arm/mach-u300/include/mach/uncompress.h       |   18 +----------
 arch/arm/mach-ux500/include/mach/uncompress.h      |   21 +------------
 arch/arm/mach-versatile/include/mach/uncompress.h  |   18 +----------
 arch/arm/mach-vexpress/include/mach/uncompress.h   |   18 +----------
 arch/arm/mach-vt8500/include/mach/uncompress.h     |   19 ++---------
 arch/arm/mach-w90x900/include/mach/uncompress.h    |   20 +-----------
 arch/arm/mach-zynq/include/mach/uncompress.h       |   22 ++-----------
 arch/arm/plat-mxc/include/mach/uncompress.h        |    5 ---
 arch/arm/plat-spear/include/plat/uncompress.h      |   18 ++---------
 arch/arm/plat-tcc/include/mach/uncompress.h        |    6 ++--
 54 files changed, 106 insertions(+), 629 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/uncompress.h b/arch/arm/mach-at91/include/mach/uncompress.h
index 59c1c68..78eb71c 100644
--- a/arch/arm/mach-at91/include/mach/uncompress.h
+++ b/arch/arm/mach-at91/include/mach/uncompress.h
@@ -1,26 +1,8 @@
 /*
- * arch/arm/mach-at91/include/mach/uncompress.h
- *
- *  Copyright (C) 2003 SAN People
- *
  * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
-
-#ifndef __ASM_ARCH_UNCOMPRESS_H
-#define __ASM_ARCH_UNCOMPRESS_H
-
 #include <linux/atmel_serial.h>
 
 #if defined(CONFIG_AT91_EARLY_DBGU)
@@ -40,18 +22,9 @@
 #elif
 #define UART_OFFSET 0
 
-/*
- * The following code assumes the serial port has already been
- * initialized by the bootloader.  If you didn't setup a port in
- * your bootloader then nothing will appear (which might be desired).
- *
- * This does not append a newline
- */
 static inline void arch_decomp_setup(void)
 {
 	ucuart_init(UART_OFFSET, 0, UCUART_IO_MEM32, ATMEL_US_THR,
 			ATMEL_US_CSR, ATMEL_US_TXRDY, ATMEL_US_TXRDY,
 			ATMEL_US_CSR, ATMEL_US_TXEMPTY, ATMEL_US_TXEMPTY);
 }
-
-#endif
\ No newline at end of file
diff --git a/arch/arm/mach-bcmring/include/mach/uncompress.h b/arch/arm/mach-bcmring/include/mach/uncompress.h
index 125f7b4..ed7a564 100644
--- a/arch/arm/mach-bcmring/include/mach/uncompress.h
+++ b/arch/arm/mach-bcmring/include/mach/uncompress.h
@@ -1,16 +1,8 @@
-/*****************************************************************************
-* Copyright 2005 - 2008 Broadcom Corporation.  All rights reserved.
-*
-* Unless you and Broadcom execute a separate written software license
-* agreement governing use of this software, this software is licensed to you
-* under the terms of the GNU General Public License version 2, available at
-* http://www.broadcom.com/licenses/GPLv2.php (the "GPL").
-*
-* Notwithstanding the above, under no circumstances may you combine this
-* software in any way with any other Broadcom software provided under a
-* license other than the GPL, without Broadcom's express prior written
-* consent.
-*****************************************************************************/
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
 #include <mach/csp/mm_addr.h>
 
 #define BCMRING_UART_0_DR	MM_ADDR_IO_UARTA
diff --git a/arch/arm/mach-clps711x/include/mach/uncompress.h b/arch/arm/mach-clps711x/include/mach/uncompress.h
index c0fadf2..c947d4e 100644
--- a/arch/arm/mach-clps711x/include/mach/uncompress.h
+++ b/arch/arm/mach-clps711x/include/mach/uncompress.h
@@ -1,21 +1,7 @@
 /*
- *  arch/arm/mach-clps711x/include/mach/uncompress.h
- *
- *  Copyright (C) 2000 Deep Blue Solutions Ltd
- *
  * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
 #include <mach/hardware.h>
 #include <asm/hardware/clps7111.h>
diff --git a/arch/arm/mach-cns3xxx/include/mach/uncompress.h b/arch/arm/mach-cns3xxx/include/mach/uncompress.h
index 35be756..f649fa7 100644
--- a/arch/arm/mach-cns3xxx/include/mach/uncompress.h
+++ b/arch/arm/mach-cns3xxx/include/mach/uncompress.h
@@ -1,12 +1,8 @@
 /*
- * Copyright 2003 ARM Limited
- * Copyright 2008 Cavium Networks
- *
- * This file is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License, Version 2, as
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
 #include <asm/mach-types.h>
 #include <mach/cns3xxx.h>
 
diff --git a/arch/arm/mach-dove/include/mach/uncompress.h b/arch/arm/mach-dove/include/mach/uncompress.h
index 97a00eb..106f2f0 100644
--- a/arch/arm/mach-dove/include/mach/uncompress.h
+++ b/arch/arm/mach-dove/include/mach/uncompress.h
@@ -1,11 +1,8 @@
 /*
- * arch/arm/mach-dove/include/mach/uncompress.h
- *
  * This file is licensed under the terms of the GNU General Public
  * License version 2.  This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
-
 #include <mach/dove.h>
 
 static inline void arch_decomp_setup(void)
diff --git a/arch/arm/mach-ebsa110/include/mach/uncompress.h b/arch/arm/mach-ebsa110/include/mach/uncompress.h
index 38c0f7f..6ea8429 100644
--- a/arch/arm/mach-ebsa110/include/mach/uncompress.h
+++ b/arch/arm/mach-ebsa110/include/mach/uncompress.h
@@ -1,13 +1,8 @@
 /*
- *  arch/arm/mach-ebsa110/include/mach/uncompress.h
- *
- *  Copyright (C) 1996,1997,1998 Russell King
- *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
 static inline void arch_decomp_setup(void)
 {
 	ucuart_init_8250(0xf0000be0, 2, UCUART_IO_MEM8);
diff --git a/arch/arm/mach-exynos4/include/mach/uncompress.h b/arch/arm/mach-exynos4/include/mach/uncompress.h
index 21d97bc..21b7bd1 100644
--- a/arch/arm/mach-exynos4/include/mach/uncompress.h
+++ b/arch/arm/mach-exynos4/include/mach/uncompress.h
@@ -1,18 +1,8 @@
-/* linux/arch/arm/mach-exynos4/include/mach/uncompress.h
- *
- * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * EXYNOS4 - uncompress code
- *
+/*
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_UNCOMPRESS_H
-#define __ASM_ARCH_UNCOMPRESS_H __FILE__
-
+ */
 #include <mach/map.h>
 #include <plat/uncompress.h>
 
@@ -27,4 +17,3 @@ static void arch_detect_cpu(void)
 	fifo_mask = S5PV210_UFSTAT_TXMASK;
 	fifo_max = 15 << S5PV210_UFSTAT_TXSHIFT;
 }
-#endif /* __ASM_ARCH_UNCOMPRESS_H */
diff --git a/arch/arm/mach-footbridge/include/mach/uncompress.h b/arch/arm/mach-footbridge/include/mach/uncompress.h
index 5f41698..9cef55a 100644
--- a/arch/arm/mach-footbridge/include/mach/uncompress.h
+++ b/arch/arm/mach-footbridge/include/mach/uncompress.h
@@ -1,8 +1,4 @@
 /*
- *  arch/arm/mach-footbridge/include/mach/uncompress.h
- *
- *  Copyright (C) 1996-1999 Russell King
- *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -12,8 +8,8 @@
 /*
  * Note! This could cause problems on the NetWinder
  */
-#define DC21285_BASE ((volatile unsigned int *)0x42000160)
-#define SER0_BASE    ((volatile unsigned char *)0x7c0003f8)
+#define DC21285_BASE	0x42000160
+#define SER0_BASE	0x7c0003f8
 
 static inline void arch_decomp_setup(void)
 {
diff --git a/arch/arm/mach-gemini/include/mach/uncompress.h b/arch/arm/mach-gemini/include/mach/uncompress.h
index dd81586..9841798 100644
--- a/arch/arm/mach-gemini/include/mach/uncompress.h
+++ b/arch/arm/mach-gemini/include/mach/uncompress.h
@@ -1,23 +1,11 @@
 /*
- * Copyright (C) 2008-2009 Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
- *
- * Based on mach-pxa/include/mach/uncompress.h:
- * Copyright:	(C) 2001 MontaVista Software Inc.
- *
  * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
-
-#ifndef __MACH_UNCOMPRESS_H
-#define __MACH_UNCOMPRESS_H
-
 #include <mach/hardware.h>
 
 static inline void arch_decomp_setup(void)
 {
 	ucuart_init_8250(GEMINI_UART_BASE, 2, UCUART_IO_MEM32);
 }
-
-#endif /* __MACH_UNCOMPRESS_H */
diff --git a/arch/arm/mach-h720x/include/mach/uncompress.h b/arch/arm/mach-h720x/include/mach/uncompress.h
index 6f727ba..9c8bdd1 100644
--- a/arch/arm/mach-h720x/include/mach/uncompress.h
+++ b/arch/arm/mach-h720x/include/mach/uncompress.h
@@ -1,12 +1,8 @@
 /*
- * arch/arm/mach-h720x/include/mach/uncompress.h
- *
- * Copyright (C) 2001-2002 Jungjun Kim
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
-
-#ifndef __ASM_ARCH_UNCOMPRESS_H
-#define __ASM_ARCH_UNCOMPRESS_H
-
 #include <mach/hardware.h>
 
 /* debug-macro.S treats this port as an AMBA01x, but according to the
@@ -16,5 +12,3 @@ static inline void arch_decomp_setup(void)
 {
 	ucuart_init_8250(SERIAL0_BASE, 2, UCUART_IO_MEM8);
 }
-
-#endif
diff --git a/arch/arm/mach-integrator/include/mach/uncompress.h b/arch/arm/mach-integrator/include/mach/uncompress.h
index 57cc838..a6c0afb 100644
--- a/arch/arm/mach-integrator/include/mach/uncompress.h
+++ b/arch/arm/mach-integrator/include/mach/uncompress.h
@@ -1,21 +1,7 @@
 /*
- *  arch/arm/mach-integrator/include/mach/uncompress.h
- *
- *  Copyright (C) 1999 ARM Limited
- *
  * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
 static inline void arch_decomp_setup(void)
 {
diff --git a/arch/arm/mach-iop13xx/include/mach/uncompress.h b/arch/arm/mach-iop13xx/include/mach/uncompress.h
index 6c1c385..dfe67a8 100644
--- a/arch/arm/mach-iop13xx/include/mach/uncompress.h
+++ b/arch/arm/mach-iop13xx/include/mach/uncompress.h
@@ -1,3 +1,8 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
 #include <mach/hardware.h>
 
 static inline void arch_decomp_setup(void)
diff --git a/arch/arm/mach-iop32x/include/mach/uncompress.h b/arch/arm/mach-iop32x/include/mach/uncompress.h
index 3d970a9..6fe0ad9 100644
--- a/arch/arm/mach-iop32x/include/mach/uncompress.h
+++ b/arch/arm/mach-iop32x/include/mach/uncompress.h
@@ -1,5 +1,7 @@
 /*
- * arch/arm/mach-iop32x/include/mach/uncompress.h
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
 #include <mach/hardware.h>
 
diff --git a/arch/arm/mach-iop33x/include/mach/uncompress.h b/arch/arm/mach-iop33x/include/mach/uncompress.h
index 9ee4b3b..c661412 100644
--- a/arch/arm/mach-iop33x/include/mach/uncompress.h
+++ b/arch/arm/mach-iop33x/include/mach/uncompress.h
@@ -1,7 +1,8 @@
 /*
- * arch/arm/mach-iop33x/include/mach/uncompress.h
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
-
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
 
diff --git a/arch/arm/mach-ixp2000/include/mach/uncompress.h b/arch/arm/mach-ixp2000/include/mach/uncompress.h
index e9911fb..d32b2ef 100644
--- a/arch/arm/mach-ixp2000/include/mach/uncompress.h
+++ b/arch/arm/mach-ixp2000/include/mach/uncompress.h
@@ -1,17 +1,7 @@
 /*
- * arch/arm/mach-ixp2000/include/mach/uncompress.h
- *
- *
- * Original Author: Naeem Afzal <naeem.m.afzal@intel.com>
- * Maintainer: Deepak Saxena <dsaxena@plexity.net>
- *
- * Copyright 2002 Intel Corp.
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
 static inline void arch_decomp_setup(void)
 {
diff --git a/arch/arm/mach-ixp23xx/include/mach/uncompress.h b/arch/arm/mach-ixp23xx/include/mach/uncompress.h
index 22cc9f5..af3d63d 100644
--- a/arch/arm/mach-ixp23xx/include/mach/uncompress.h
+++ b/arch/arm/mach-ixp23xx/include/mach/uncompress.h
@@ -1,21 +1,11 @@
 /*
- * arch/arm/mach-ixp23xx/include/mach/uncompress.h
- *
- * Copyright (C) 2002-2004 Intel Corporation.
- *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
-#ifndef __ASM_ARCH_UNCOMPRESS_H
-#define __ASM_ARCH_UNCOMPRESS_H
-
 #include <mach/ixp23xx.h>
 
 static inline void arch_decomp_setup(void)
 {
 	ucuart_init_8250(IXP23XX_UART1_PHYS, 2, UCUART_IO_MEM32);
 }
-
-#endif
diff --git a/arch/arm/mach-ixp4xx/include/mach/uncompress.h b/arch/arm/mach-ixp4xx/include/mach/uncompress.h
index a8d075c..d3c683b 100644
--- a/arch/arm/mach-ixp4xx/include/mach/uncompress.h
+++ b/arch/arm/mach-ixp4xx/include/mach/uncompress.h
@@ -1,18 +1,8 @@
 /*
- * arch/arm/mach-ixp4xx/include/mach/uncompress.h 
- *
- * Copyright (C) 2002 Intel Corporation.
- * Copyright (C) 2003-2004 MontaVista Software, Inc.
- *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
- *
  */
-
-#ifndef _ARCH_UNCOMPRESS_H_
-#define _ARCH_UNCOMPRESS_H_
-
 #include "ixp4xx-regs.h"
 #include <asm/mach-types.h>
 
@@ -28,5 +18,3 @@ static inline void arch_decomp_setup(void)
 	else
 		ucuart_init_8250(IXP4XX_UART1_BASE_PHYS, 2, UCUART_IO_MEM32);
 }
-
-#endif
diff --git a/arch/arm/mach-kirkwood/include/mach/uncompress.h b/arch/arm/mach-kirkwood/include/mach/uncompress.h
index da9f19f..f2739f4 100644
--- a/arch/arm/mach-kirkwood/include/mach/uncompress.h
+++ b/arch/arm/mach-kirkwood/include/mach/uncompress.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-kirkwood/include/mach/uncompress.h
- *
  * This file is licensed under the terms of the GNU General Public
  * License version 2.  This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
diff --git a/arch/arm/mach-ks8695/include/mach/uncompress.h b/arch/arm/mach-ks8695/include/mach/uncompress.h
index 99cac67..e2be045a07 100644
--- a/arch/arm/mach-ks8695/include/mach/uncompress.h
+++ b/arch/arm/mach-ks8695/include/mach/uncompress.h
@@ -1,19 +1,8 @@
 /*
- * arch/arm/mach-ks8695/include/mach/uncompress.h
- *
- * Copyright (C) 2006 Ben Dooks <ben@simtec.co.uk>
- * Copyright (C) 2006 Simtec Electronics
- *
- * KS8695 - Kernel uncompressor
- *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
-#ifndef __ASM_ARCH_UNCOMPRESS_H
-#define __ASM_ARCH_UNCOMPRESS_H
-
 #include <mach/regs-uart.h>
 
 static inline void arch_decomp_setup(void)
@@ -22,5 +11,3 @@ static inline void arch_decomp_setup(void)
 			KS8695_URLS, URLS_URTHRE, URLS_URTHRE,
 			KS8695_URLS, URLS_URTE, URLS_URTE);
 }
-
-#endif
diff --git a/arch/arm/mach-lpc32xx/include/mach/uncompress.h b/arch/arm/mach-lpc32xx/include/mach/uncompress.h
index 0e119c4..0586c4c 100644
--- a/arch/arm/mach-lpc32xx/include/mach/uncompress.h
+++ b/arch/arm/mach-lpc32xx/include/mach/uncompress.h
@@ -1,29 +1,11 @@
 /*
- * arch/arm/mach-lpc32xx/include/mach/uncompress.h
- *
- * Author: Kevin Wells <kevin.wells@nxp.com>
- *
- * Copyright (C) 2010 NXP Semiconductors
- *
  * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
-
-#ifndef __ASM_ARM_ARCH_UNCOMPRESS_H
-#define __ASM_ARM_ARCH_UNCOMPRESS_H
-
 #include <mach/platform.h>
 
 static inline void arch_decomp_setup(void)
 {
 	ucuart_init_8250(LPC32XX_UART5_BASE, 2, UCUART_IO_MEM32);
 }
-
-#endif
diff --git a/arch/arm/mach-mmp/include/mach/uncompress.h b/arch/arm/mach-mmp/include/mach/uncompress.h
index e9bf8bf..c8b652f 100644
--- a/arch/arm/mach-mmp/include/mach/uncompress.h
+++ b/arch/arm/mach-mmp/include/mach/uncompress.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-mmp/include/mach/uncompress.h
- *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
diff --git a/arch/arm/mach-msm/include/mach/uncompress.h b/arch/arm/mach-msm/include/mach/uncompress.h
index 0fa9795..bb4d080 100644
--- a/arch/arm/mach-msm/include/mach/uncompress.h
+++ b/arch/arm/mach-msm/include/mach/uncompress.h
@@ -1,30 +1,18 @@
-/* arch/arm/mach-msm/include/mach/uncompress.h
- *
- * Copyright (C) 2007 Google, Inc.
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
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
-
-#ifndef __ASM_ARCH_MSM_UNCOMPRESS_H
-
 #include "hardware.h"
-#include "linux/io.h"
 #include "mach/msm_iomap.h"
 
+#ifndef MSM_DEBUG_UART_PHYS
+#define MSM_DEBUG_UART_PHYS 0
+#endif /* MSM_DEBUG_UART_PHYS */
+
 static inline void arch_decomp_setup(void)
 {
-#if defined(MSM_DEBUG_UART_PHYS)
 	ucuart_init(MSM_DEBUG_UART_PHYS, 2, UCUART_IO_MEM32, 0x0c,
 			0x08, 0x04, 0x04,
 			0, 0, 0);
-#endif /* MSM_DEBUG_UART_PHYS */
 }
-#endif
diff --git a/arch/arm/mach-mv78xx0/include/mach/uncompress.h b/arch/arm/mach-mv78xx0/include/mach/uncompress.h
index 064bb96..60115d3 100644
--- a/arch/arm/mach-mv78xx0/include/mach/uncompress.h
+++ b/arch/arm/mach-mv78xx0/include/mach/uncompress.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-mv78xx0/include/mach/uncompress.h
- *
  * This file is licensed under the terms of the GNU General Public
  * License version 2.  This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
diff --git a/arch/arm/mach-mxs/include/mach/uncompress.h b/arch/arm/mach-mxs/include/mach/uncompress.h
index c9587ce..9934c25 100644
--- a/arch/arm/mach-mxs/include/mach/uncompress.h
+++ b/arch/arm/mach-mxs/include/mach/uncompress.h
@@ -1,23 +1,8 @@
 /*
- *  arch/arm/mach-mxs/include/mach/uncompress.h
- *
- *  Copyright (C) 1999 ARM Limited
- *  Copyright (C) Shane Nay (shane at minirl.com)
- *  Copyright 2010 Freescale Semiconductor, Inc. All Rights Reserved.
- *
  * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
-#ifndef __MACH_MXS_UNCOMPRESS_H__
-#define __MACH_MXS_UNCOMPRESS_H__
-
 #include <asm/mach-types.h>
 
 #define MX23_DUART_BASE_ADDR	0x80070000
@@ -37,5 +22,3 @@ static inline void arch_decomp_setup(void)
 		break;
 	}
 }
-
-#endif /* __MACH_MXS_UNCOMPRESS_H__ */
diff --git a/arch/arm/mach-netx/include/mach/uncompress.h b/arch/arm/mach-netx/include/mach/uncompress.h
index 5a32b87..5944b34 100644
--- a/arch/arm/mach-netx/include/mach/uncompress.h
+++ b/arch/arm/mach-netx/include/mach/uncompress.h
@@ -1,29 +1,8 @@
 /*
- * arch/arm/mach-netx/include/mach/uncompress.h
- *
- * Copyright (C) 2005 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
- *
  * This program is free software; you can redistribute it and/or modify
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
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
-
-/*
- * The following code assumes the serial port has already been
- * initialized by the bootloader.  We search for the first enabled
- * port in the most probable order.  If you didn't setup a port in
- * your bootloader then nothing will appear (which might be desired).
- */
-
 #define UART1_BASE 0x100a00
 #define UART2_BASE 0x100a80
 
diff --git a/arch/arm/mach-nomadik/include/mach/uncompress.h b/arch/arm/mach-nomadik/include/mach/uncompress.h
index f5da290..24d0525 100644
--- a/arch/arm/mach-nomadik/include/mach/uncompress.h
+++ b/arch/arm/mach-nomadik/include/mach/uncompress.h
@@ -1,29 +1,11 @@
 /*
- *  Copyright (C) 2008 STMicroelectronics
- *
  * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
-
-#ifndef __ASM_ARCH_UNCOMPRESS_H
-#define __ASM_ARCH_UNCOMPRESS_H
-
 #include <mach/hardware.h>
 
 static inline void arch_decomp_setup(void)
 {
 	ucuart_init_amba01x(NOMADIK_UART1_BASE);
 }
-
-#endif /* __ASM_ARCH_UNCOMPRESS_H */
diff --git a/arch/arm/mach-omap1/include/mach/uncompress.h b/arch/arm/mach-omap1/include/mach/uncompress.h
index 0ff22dc..a4acb71 100644
--- a/arch/arm/mach-omap1/include/mach/uncompress.h
+++ b/arch/arm/mach-omap1/include/mach/uncompress.h
@@ -1,5 +1 @@
-/*
- * arch/arm/mach-omap1/include/mach/uncompress.h
- */
-
 #include <plat/uncompress.h>
diff --git a/arch/arm/mach-omap2/include/mach/uncompress.h b/arch/arm/mach-omap2/include/mach/uncompress.h
index 78e0557..a4acb71 100644
--- a/arch/arm/mach-omap2/include/mach/uncompress.h
+++ b/arch/arm/mach-omap2/include/mach/uncompress.h
@@ -1,5 +1 @@
-/*
- * arch/arm/mach-omap2/include/mach/uncompress.h
- */
-
 #include <plat/uncompress.h>
diff --git a/arch/arm/mach-orion5x/include/mach/uncompress.h b/arch/arm/mach-orion5x/include/mach/uncompress.h
index 4d7c1ba..692c366 100644
--- a/arch/arm/mach-orion5x/include/mach/uncompress.h
+++ b/arch/arm/mach-orion5x/include/mach/uncompress.h
@@ -1,11 +1,7 @@
 /*
- * arch/arm/mach-orion5x/include/mach/uncompress.h
- *
- * Tzachi Perelstein <tzachi@marvell.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
 #include <mach/orion5x.h>
 
diff --git a/arch/arm/mach-picoxcell/include/mach/uncompress.h b/arch/arm/mach-picoxcell/include/mach/uncompress.h
index 9464c63..bb627c3 100644
--- a/arch/arm/mach-picoxcell/include/mach/uncompress.h
+++ b/arch/arm/mach-picoxcell/include/mach/uncompress.h
@@ -1,19 +1,7 @@
 /*
- * Copyright (c) 2011 Picochip Ltd., Jamie Iles
- *
  * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
 #define ARCH_UCUART_NONGENERIC
 #define putc(c)
diff --git a/arch/arm/mach-pnx4008/include/mach/uncompress.h b/arch/arm/mach-pnx4008/include/mach/uncompress.h
index 1a18501..79be042 100644
--- a/arch/arm/mach-pnx4008/include/mach/uncompress.h
+++ b/arch/arm/mach-pnx4008/include/mach/uncompress.h
@@ -1,24 +1,8 @@
 /*
- *  arch/arm/mach-pnx4008/include/mach/uncompress.h
- *
- *  Copyright (C) 1999 ARM Limited
- *  Copyright (C) 2006 MontaVista Software, Inc.
- *
  * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
-
 #define UART5_BASE 0x40090000
 
 static inline void arch_decomp_setup(void)
diff --git a/arch/arm/mach-prima2/include/mach/uncompress.h b/arch/arm/mach-prima2/include/mach/uncompress.h
index 29ee15e..5e1fcbe 100644
--- a/arch/arm/mach-prima2/include/mach/uncompress.h
+++ b/arch/arm/mach-prima2/include/mach/uncompress.h
@@ -1,14 +1,8 @@
 /*
- * arch/arm/mach-prima2/include/mach/uncompress.h
- *
- * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
- *
- * Licensed under GPLv2 or later.
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
-
-#ifndef __ASM_ARCH_UNCOMPRESS_H
-#define __ASM_ARCH_UNCOMPRESS_H
-
 #include <mach/uart.h>
 
 static inline void arch_decomp_setup(void)
@@ -17,4 +11,3 @@ static inline void arch_decomp_setup(void)
 			SIRFSOC_UART_TXFIFO_DATA, SIRFSOC_UART_TXFIFO_STATUS,
 			SIRFSOC_UART1_TXFIFO_FULL, 0, 0, 0, 0);
 }
-#endif
diff --git a/arch/arm/mach-pxa/include/mach/uncompress.h b/arch/arm/mach-pxa/include/mach/uncompress.h
index 7d24bf1..f123d9f 100644
--- a/arch/arm/mach-pxa/include/mach/uncompress.h
+++ b/arch/arm/mach-pxa/include/mach/uncompress.h
@@ -1,9 +1,4 @@
 /*
- * arch/arm/mach-pxa/include/mach/uncompress.h
- *
- * Author:	Nicolas Pitre
- * Copyright:	(C) 2001 MontaVista Software Inc.
- *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
diff --git a/arch/arm/mach-realview/include/mach/uncompress.h b/arch/arm/mach-realview/include/mach/uncompress.h
index f69b003..8e7ecaf 100644
--- a/arch/arm/mach-realview/include/mach/uncompress.h
+++ b/arch/arm/mach-realview/include/mach/uncompress.h
@@ -1,21 +1,7 @@
 /*
- *  arch/arm/mach-realview/include/mach/uncompress.h
- *
- *  Copyright (C) 2003 ARM Limited
- *
  * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
 #include <asm/mach-types.h>
 
diff --git a/arch/arm/mach-s3c64xx/include/mach/uncompress.h b/arch/arm/mach-s3c64xx/include/mach/uncompress.h
index c6a82a2..78f5e06 100644
--- a/arch/arm/mach-s3c64xx/include/mach/uncompress.h
+++ b/arch/arm/mach-s3c64xx/include/mach/uncompress.h
@@ -1,20 +1,8 @@
-/* arch/arm/mach-s3c6400/include/mach/uncompress.h
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C6400 - uncompress code
- *
+/*
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_UNCOMPRESS_H
-#define __ASM_ARCH_UNCOMPRESS_H
-
+ */
 #include <mach/map.h>
 #include <plat/uncompress.h>
 
@@ -24,5 +12,3 @@ static void arch_detect_cpu(void)
 	fifo_mask = S3C2440_UFSTAT_TXMASK;
 	fifo_max = 63 << S3C2440_UFSTAT_TXSHIFT;
 }
-
-#endif /* __ASM_ARCH_UNCOMPRESS_H */
diff --git a/arch/arm/mach-s5p64x0/include/mach/uncompress.h b/arch/arm/mach-s5p64x0/include/mach/uncompress.h
index 0b896fc..436920a 100644
--- a/arch/arm/mach-s5p64x0/include/mach/uncompress.h
+++ b/arch/arm/mach-s5p64x0/include/mach/uncompress.h
@@ -9,10 +9,6 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
 */
-
-#ifndef __ASM_ARCH_UNCOMPRESS_H
-#define __ASM_ARCH_UNCOMPRESS_H
-
 #define ARCH_UCUART_NONGENERIC
 
 #include <mach/map.h>
@@ -177,5 +173,3 @@ static void arch_detect_cpu(void)
 {
 	/* we do not need to do any cpu detection here at the moment. */
 }
-
-#endif /* __ASM_ARCH_UNCOMPRESS_H */
diff --git a/arch/arm/mach-s5pc100/include/mach/uncompress.h b/arch/arm/mach-s5pc100/include/mach/uncompress.h
index 3d67981..9d64a2c 100644
--- a/arch/arm/mach-s5pc100/include/mach/uncompress.h
+++ b/arch/arm/mach-s5pc100/include/mach/uncompress.h
@@ -11,10 +11,6 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
 */
-
-#ifndef __ASM_ARCH_UNCOMPRESS_H
-#define __ASM_ARCH_UNCOMPRESS_H
-
 #define ARCH_UCUART_NONGENERIC
 
 #include <mach/map.h>
@@ -26,5 +22,3 @@ static void arch_detect_cpu(void)
 	fifo_mask = S3C2440_UFSTAT_TXMASK;
 	fifo_max = 63 << S3C2440_UFSTAT_TXSHIFT;
 }
-
-#endif /* __ASM_ARCH_UNCOMPRESS_H */
diff --git a/arch/arm/mach-s5pv210/include/mach/uncompress.h b/arch/arm/mach-s5pv210/include/mach/uncompress.h
index f5454f3..81afd51 100644
--- a/arch/arm/mach-s5pv210/include/mach/uncompress.h
+++ b/arch/arm/mach-s5pv210/include/mach/uncompress.h
@@ -1,18 +1,8 @@
-/* linux/arch/arm/mach-s5pv210/include/mach/uncompress.h
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * S5PV210 - uncompress code
- *
+/*
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_UNCOMPRESS_H
-#define __ASM_ARCH_UNCOMPRESS_H
-
+ */
 #define ARCH_UCUART_NONGENERIC
 #include <mach/map.h>
 #include <plat/uncompress.h>
@@ -21,5 +11,3 @@ static void arch_detect_cpu(void)
 {
 	/* we do not need to do any cpu detection here at the moment. */
 }
-
-#endif /* __ASM_ARCH_UNCOMPRESS_H */
diff --git a/arch/arm/mach-sa1100/include/mach/uncompress.h b/arch/arm/mach-sa1100/include/mach/uncompress.h
index 714f957..4c89c40 100644
--- a/arch/arm/mach-sa1100/include/mach/uncompress.h
+++ b/arch/arm/mach-sa1100/include/mach/uncompress.h
@@ -1,11 +1,8 @@
 /*
- * arch/arm/mach-sa1100/include/mach/uncompress.h
- *
- * (C) 1999 Nicolas Pitre <nico@fluxnic.net>
- *
- * Reorganised to be machine independent.
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
-
 #include "hardware.h"
 
 static inline int uart_enabled(int base)
diff --git a/arch/arm/mach-shark/include/mach/uncompress.h b/arch/arm/mach-shark/include/mach/uncompress.h
index cc1ce9b..3d3ab55 100644
--- a/arch/arm/mach-shark/include/mach/uncompress.h
+++ b/arch/arm/mach-shark/include/mach/uncompress.h
@@ -1,10 +1,7 @@
 /*
- * arch/arm/mach-shark/include/mach/uncompress.h
- * by Alexander Schulz
- *
- * derived from:
- * arch/arm/mach-footbridge/include/mach/uncompress.h
- * Copyright (C) 1996,1997,1998 Russell King
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
 static inline void arch_decomp_setup(void)
 {
diff --git a/arch/arm/mach-shmobile/include/mach/uncompress.h b/arch/arm/mach-shmobile/include/mach/uncompress.h
index 9df3a71..346028a 100644
--- a/arch/arm/mach-shmobile/include/mach/uncompress.h
+++ b/arch/arm/mach-shmobile/include/mach/uncompress.h
@@ -1,11 +1,10 @@
-#ifndef __ASM_MACH_UNCOMPRESS_H
-#define __ASM_MACH_UNCOMPRESS_H
-
-#define ARCH_UCUART_NONGENERIC
-
 /*
- * This does not append a newline
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
+#define ARCH_UCUART_NONGENERIC
+
 static void putc(int c)
 {
 }
@@ -15,5 +14,3 @@ static inline void flush(void)
 }
 
 #define arch_decomp_setup()
-
-#endif /* __ASM_MACH_UNCOMPRESS_H */
diff --git a/arch/arm/mach-spear3xx/include/mach/uncompress.h b/arch/arm/mach-spear3xx/include/mach/uncompress.h
index 53ba8bb..a4acb71 100644
--- a/arch/arm/mach-spear3xx/include/mach/uncompress.h
+++ b/arch/arm/mach-spear3xx/include/mach/uncompress.h
@@ -1,19 +1 @@
-/*
- * arch/arm/mach-spear3xx/include/mach/uncompress.h
- *
- * Serial port stubs for kernel decompress status messages
- *
- * Copyright (C) 2009 ST Microelectronics
- * Viresh Kumar<viresh.kumar@st.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __MACH_UNCOMPRESS_H
-#define __MACH_UNCOMPRESS_H
-
 #include <plat/uncompress.h>
-
-#endif /* __MACH_UNCOMPRESS_H */
diff --git a/arch/arm/mach-spear6xx/include/mach/uncompress.h b/arch/arm/mach-spear6xx/include/mach/uncompress.h
index 77f0765..a4acb71 100644
--- a/arch/arm/mach-spear6xx/include/mach/uncompress.h
+++ b/arch/arm/mach-spear6xx/include/mach/uncompress.h
@@ -1,19 +1 @@
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
 #include <plat/uncompress.h>
-
-#endif	/* __MACH_UNCOMPRESS_H */
diff --git a/arch/arm/mach-tegra/include/mach/uncompress.h b/arch/arm/mach-tegra/include/mach/uncompress.h
index 5c3ec5e..13318ef 100644
--- a/arch/arm/mach-tegra/include/mach/uncompress.h
+++ b/arch/arm/mach-tegra/include/mach/uncompress.h
@@ -1,26 +1,8 @@
 /*
- * arch/arm/mach-tegra/include/mach/uncompress.h
- *
- * Copyright (C) 2010 Google, Inc.
- *
- * Author:
- *	Colin Cross <ccross@google.com>
- *	Erik Gilling <konkers@google.com>
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
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
-
-#ifndef __MACH_TEGRA_UNCOMPRESS_H
-#define __MACH_TEGRA_UNCOMPRESS_H
-
 #include <linux/types.h>
 #include <linux/serial_reg.h>
 
@@ -38,5 +20,3 @@ static inline void arch_decomp_setup(void)
 
 	ucuart_init_8250(TEGRA_DEBUG_UART_BASE, 2, UCUART_IO_MEM8);
 }
-
-#endif
diff --git a/arch/arm/mach-u300/include/mach/uncompress.h b/arch/arm/mach-u300/include/mach/uncompress.h
index 7f09047..df644d4 100644
--- a/arch/arm/mach-u300/include/mach/uncompress.h
+++ b/arch/arm/mach-u300/include/mach/uncompress.h
@@ -1,21 +1,7 @@
 /*
- * arch/arm/mach-u300/include/mach/uncompress.h
- *
- * Copyright (C) 2003 ARM Limited
- *
  * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
 static inline void arch_decomp_setup(void)
 {
diff --git a/arch/arm/mach-ux500/include/mach/uncompress.h b/arch/arm/mach-ux500/include/mach/uncompress.h
index eb30110..39fcc4f 100644
--- a/arch/arm/mach-ux500/include/mach/uncompress.h
+++ b/arch/arm/mach-ux500/include/mach/uncompress.h
@@ -1,23 +1,8 @@
 /*
- *  Copyright (C) 2009 ST-Ericsson
- *
  * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
-#ifndef __ASM_ARCH_UNCOMPRESS_H
-#define __ASM_ARCH_UNCOMPRESS_H
-
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
 
@@ -29,5 +14,3 @@ static inline void arch_decomp_setup(void)
 	else
 		ucuart_init_amba01x(U8500_UART2_BASE);
 }
-
-#endif /* __ASM_ARCH_UNCOMPRESS_H */
diff --git a/arch/arm/mach-versatile/include/mach/uncompress.h b/arch/arm/mach-versatile/include/mach/uncompress.h
index 01390bd..5afe25b 100644
--- a/arch/arm/mach-versatile/include/mach/uncompress.h
+++ b/arch/arm/mach-versatile/include/mach/uncompress.h
@@ -1,21 +1,7 @@
 /*
- *  arch/arm/mach-versatile/include/mach/uncompress.h
- *
- *  Copyright (C) 2003 ARM Limited
- *
  * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
 static inline void arch_decomp_setup(void)
 {
diff --git a/arch/arm/mach-vexpress/include/mach/uncompress.h b/arch/arm/mach-vexpress/include/mach/uncompress.h
index 970eba5..aedf7cc 100644
--- a/arch/arm/mach-vexpress/include/mach/uncompress.h
+++ b/arch/arm/mach-vexpress/include/mach/uncompress.h
@@ -1,21 +1,7 @@
 /*
- *  arch/arm/mach-vexpress/include/mach/uncompress.h
- *
- *  Copyright (C) 2003 ARM Limited
- *
  * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
 static inline void arch_decomp_setup(void)
 {
diff --git a/arch/arm/mach-vt8500/include/mach/uncompress.h b/arch/arm/mach-vt8500/include/mach/uncompress.h
index 7fb6603..477ab84 100644
--- a/arch/arm/mach-vt8500/include/mach/uncompress.h
+++ b/arch/arm/mach-vt8500/include/mach/uncompress.h
@@ -1,18 +1,7 @@
-/* arch/arm/mach-vt8500/include/mach/uncompress.h
- *
- * Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
- *
- * Based on arch/arm/mach-dove/include/mach/uncompress.h
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
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
 static inline void arch_decomp_setup(void)
 {
diff --git a/arch/arm/mach-w90x900/include/mach/uncompress.h b/arch/arm/mach-w90x900/include/mach/uncompress.h
index f082f83..6118a77 100644
--- a/arch/arm/mach-w90x900/include/mach/uncompress.h
+++ b/arch/arm/mach-w90x900/include/mach/uncompress.h
@@ -1,27 +1,11 @@
 /*
- * arch/arm/mach-w90x900/include/mach/uncompress.h
- *
- * Copyright (c) 2008 Nuvoton technology corporation
- * All rights reserved.
- *
- * Wan ZongShun <mcuos.com@gmail.com>
- *
- * Based on arch/arm/mach-s3c2410/include/mach/uncompress.h
- *
  * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
-
-#ifndef __ASM_ARCH_UNCOMPRESS_H
-#define __ASM_ARCH_UNCOMPRESS_H
-
 #include <mach/map.h>
 
 static inline void arch_decomp_setup(void)
 {
 	ucuart_init_8250(W90X900_PA_UART, 2, UCUART_IO_MEM32);
 }
-#endif/* __ASM_W90X900_UNCOMPRESS_H */
diff --git a/arch/arm/mach-zynq/include/mach/uncompress.h b/arch/arm/mach-zynq/include/mach/uncompress.h
index 5eaf93b..fb1bbdf 100644
--- a/arch/arm/mach-zynq/include/mach/uncompress.h
+++ b/arch/arm/mach-zynq/include/mach/uncompress.h
@@ -1,20 +1,8 @@
-/* arch/arm/mach-zynq/include/mach/uncompress.h
- *
- *  Copyright (C) 2011 Xilinx
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
-
-#ifndef __MACH_UNCOMPRESS_H__
-#define __MACH_UNCOMPRESS_H__
-
 #include <mach/zynq_soc.h>
 #include <mach/uart.h>
 
@@ -24,5 +12,3 @@ static inline void arch_decomp_setup(void)
 			UART_SR_OFFSET, UART_SR_TXFULL, 0,
 			UART_SR_OFFSET, UART_SR_TXEMPTY, UART_SR_TXEMPTY);
 }
-
-#endif
diff --git a/arch/arm/plat-mxc/include/mach/uncompress.h b/arch/arm/plat-mxc/include/mach/uncompress.h
index b7023be..00059cc 100644
--- a/arch/arm/plat-mxc/include/mach/uncompress.h
+++ b/arch/arm/plat-mxc/include/mach/uncompress.h
@@ -14,9 +14,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  */
-#ifndef __ASM_ARCH_MXC_UNCOMPRESS_H__
-#define __ASM_ARCH_MXC_UNCOMPRESS_H__
-
 #define __MXC_BOOT_UNCOMPRESS
 
 #include <asm/mach-types.h>
@@ -111,5 +108,3 @@ static inline void arch_decomp_setup(void)
 	ucuart_init(uart_base, 0, UCUART_IO_MEM32, TXR,
 			USR2, USR2_TXFE, USR2_TXFE, 0, 0, 0);
 }
-
-#endif				/* __ASM_ARCH_MXC_UNCOMPRESS_H__ */
diff --git a/arch/arm/plat-spear/include/plat/uncompress.h b/arch/arm/plat-spear/include/plat/uncompress.h
index b9d8f6e..ffdfcde 100644
--- a/arch/arm/plat-spear/include/plat/uncompress.h
+++ b/arch/arm/plat-spear/include/plat/uncompress.h
@@ -1,22 +1,10 @@
 /*
- * arch/arm/plat-spear/include/plat/uncompress.h
- *
- * Serial port stubs for kernel decompress status messages
- *
- * Copyright (C) 2009 ST Microelectronics
- * Viresh Kumar<viresh.kumar@st.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
 #include <mach/hardware.h>
-
-#ifndef __PLAT_UNCOMPRESS_H
-#define __PLAT_UNCOMPRESS_H
-
 static inline void arch_decomp_setup(void)
 {
 	ucuart_init_amba01x(SPEAR_DBG_UART_BASE);
 }
-#endif /* __PLAT_UNCOMPRESS_H */
diff --git a/arch/arm/plat-tcc/include/mach/uncompress.h b/arch/arm/plat-tcc/include/mach/uncompress.h
index 23b2b77..f12e63e 100644
--- a/arch/arm/plat-tcc/include/mach/uncompress.h
+++ b/arch/arm/plat-tcc/include/mach/uncompress.h
@@ -1,7 +1,7 @@
 /*
- * Copyright (C) 2009 Hans J. Koch <hjk@linutronix.de>
- *
- * This file is licensed under the terms of the GPL version 2.
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
 #include <mach/tcc8k-regs.h>
 
-- 
1.7.4.1
