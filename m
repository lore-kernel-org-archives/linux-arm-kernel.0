From: robherring2@gmail.com (Rob Herring)
Date: Mon, 13 Feb 2012 15:43:27 -0600
Subject: [PATCH 14/15] ARM: remove bunch of now unused mach/io.h files
In-Reply-To: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
Message-ID: <1329169408-17253-15-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Now that many platforms don't need mach/io.h, remove the usused ones.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-at91/include/mach/io.h      |   49 -----------------------------
 arch/arm/mach-bcmring/include/mach/io.h   |   33 -------------------
 arch/arm/mach-clps711x/include/mach/io.h  |   36 ---------------------
 arch/arm/mach-cns3xxx/include/mach/io.h   |   17 ----------
 arch/arm/mach-davinci/include/mach/io.h   |   24 --------------
 arch/arm/mach-ep93xx/include/mach/io.h    |   22 -------------
 arch/arm/mach-exynos/include/mach/io.h    |   26 ---------------
 arch/arm/mach-gemini/include/mach/io.h    |   18 ----------
 arch/arm/mach-h720x/include/mach/io.h     |   22 -------------
 arch/arm/mach-highbank/include/mach/io.h  |    7 ----
 arch/arm/mach-ks8695/include/mach/io.h    |   19 -----------
 arch/arm/mach-lpc32xx/include/mach/io.h   |   27 ----------------
 arch/arm/mach-mmp/include/mach/io.h       |   21 ------------
 arch/arm/mach-msm/include/mach/io.h       |   24 --------------
 arch/arm/mach-mxs/include/mach/io.h       |   22 -------------
 arch/arm/mach-netx/include/mach/io.h      |   28 ----------------
 arch/arm/mach-nomadik/include/mach/io.h   |   22 -------------
 arch/arm/mach-orion5x/include/mach/io.h   |   21 ------------
 arch/arm/mach-picoxcell/include/mach/io.h |   22 -------------
 arch/arm/mach-pnx4008/include/mach/io.h   |   21 ------------
 arch/arm/mach-prima2/include/mach/io.h    |   16 ---------
 arch/arm/mach-pxa/include/mach/io.h       |   20 ------------
 arch/arm/mach-realview/include/mach/io.h  |   28 ----------------
 arch/arm/mach-s3c64xx/include/mach/io.h   |   18 ----------
 arch/arm/mach-s5p64x0/include/mach/io.h   |   25 ---------------
 arch/arm/mach-s5pc100/include/mach/io.h   |   18 ----------
 arch/arm/mach-s5pv210/include/mach/io.h   |   26 ---------------
 arch/arm/mach-sa1100/include/mach/io.h    |   20 ------------
 arch/arm/mach-shmobile/include/mach/io.h  |    9 -----
 arch/arm/mach-spear3xx/include/mach/io.h  |   19 -----------
 arch/arm/mach-spear6xx/include/mach/io.h  |   20 ------------
 arch/arm/mach-u300/include/mach/io.h      |   20 ------------
 arch/arm/mach-ux500/include/mach/io.h     |   22 -------------
 arch/arm/mach-versatile/include/mach/io.h |   28 ----------------
 arch/arm/mach-vexpress/include/mach/io.h  |   26 ---------------
 arch/arm/mach-w90x900/include/mach/io.h   |   30 -----------------
 arch/arm/mach-zynq/include/mach/io.h      |   33 -------------------
 arch/arm/plat-mxc/include/mach/io.h       |   22 -------------
 arch/arm/plat-spear/include/plat/io.h     |   22 -------------
 39 files changed, 0 insertions(+), 903 deletions(-)
 delete mode 100644 arch/arm/mach-at91/include/mach/io.h
 delete mode 100644 arch/arm/mach-bcmring/include/mach/io.h
 delete mode 100644 arch/arm/mach-clps711x/include/mach/io.h
 delete mode 100644 arch/arm/mach-cns3xxx/include/mach/io.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/io.h
 delete mode 100644 arch/arm/mach-ep93xx/include/mach/io.h
 delete mode 100644 arch/arm/mach-exynos/include/mach/io.h
 delete mode 100644 arch/arm/mach-gemini/include/mach/io.h
 delete mode 100644 arch/arm/mach-h720x/include/mach/io.h
 delete mode 100644 arch/arm/mach-highbank/include/mach/io.h
 delete mode 100644 arch/arm/mach-ks8695/include/mach/io.h
 delete mode 100644 arch/arm/mach-lpc32xx/include/mach/io.h
 delete mode 100644 arch/arm/mach-mmp/include/mach/io.h
 delete mode 100644 arch/arm/mach-msm/include/mach/io.h
 delete mode 100644 arch/arm/mach-mxs/include/mach/io.h
 delete mode 100644 arch/arm/mach-netx/include/mach/io.h
 delete mode 100644 arch/arm/mach-nomadik/include/mach/io.h
 delete mode 100644 arch/arm/mach-orion5x/include/mach/io.h
 delete mode 100644 arch/arm/mach-picoxcell/include/mach/io.h
 delete mode 100644 arch/arm/mach-pnx4008/include/mach/io.h
 delete mode 100644 arch/arm/mach-prima2/include/mach/io.h
 delete mode 100644 arch/arm/mach-pxa/include/mach/io.h
 delete mode 100644 arch/arm/mach-realview/include/mach/io.h
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/io.h
 delete mode 100644 arch/arm/mach-s5p64x0/include/mach/io.h
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/io.h
 delete mode 100644 arch/arm/mach-s5pv210/include/mach/io.h
 delete mode 100644 arch/arm/mach-sa1100/include/mach/io.h
 delete mode 100644 arch/arm/mach-shmobile/include/mach/io.h
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/io.h
 delete mode 100644 arch/arm/mach-spear6xx/include/mach/io.h
 delete mode 100644 arch/arm/mach-u300/include/mach/io.h
 delete mode 100644 arch/arm/mach-ux500/include/mach/io.h
 delete mode 100644 arch/arm/mach-versatile/include/mach/io.h
 delete mode 100644 arch/arm/mach-vexpress/include/mach/io.h
 delete mode 100644 arch/arm/mach-w90x900/include/mach/io.h
 delete mode 100644 arch/arm/mach-zynq/include/mach/io.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/io.h
 delete mode 100644 arch/arm/plat-spear/include/plat/io.h

diff --git a/arch/arm/mach-at91/include/mach/io.h b/arch/arm/mach-at91/include/mach/io.h
deleted file mode 100644
index 4ca09ef..0000000
--- a/arch/arm/mach-at91/include/mach/io.h
+++ /dev/null
@@ -1,49 +0,0 @@
-/*
- * arch/arm/mach-at91/include/mach/io.h
- *
- *  Copyright (C) 2003 SAN People
- *
- * This program is free software; you can redistribute it and/or modify
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
- */
-
-#ifndef __ASM_ARCH_IO_H
-#define __ASM_ARCH_IO_H
-
-#include <mach/hardware.h>
-
-#define IO_SPACE_LIMIT		0xFFFFFFFF
-
-#define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
-#ifndef __ASSEMBLY__
-
-static inline unsigned int at91_sys_read(unsigned int reg_offset)
-{
-	void __iomem *addr = (void __iomem *)AT91_VA_BASE_SYS;
-
-	return __raw_readl(addr + reg_offset);
-}
-
-static inline void at91_sys_write(unsigned int reg_offset, unsigned long value)
-{
-	void __iomem *addr = (void __iomem *)AT91_VA_BASE_SYS;
-
-	__raw_writel(value, addr + reg_offset);
-}
-
-#endif
-
-#endif
diff --git a/arch/arm/mach-bcmring/include/mach/io.h b/arch/arm/mach-bcmring/include/mach/io.h
deleted file mode 100644
index dae5e9b..0000000
--- a/arch/arm/mach-bcmring/include/mach/io.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- *
- *  Copyright (C) 1999 ARM Limited
- *
- * This program is free software; you can redistribute it and/or modify
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
- */
-#ifndef __ASM_ARM_ARCH_IO_H
-#define __ASM_ARM_ARCH_IO_H
-
-#include <mach/hardware.h>
-
-#define IO_SPACE_LIMIT 0xffffffff
-
-/*
- * We don't actually have real ISA nor PCI buses, but there is so many
- * drivers out there that might just work if we fake them...
- */
-#define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
-#endif
diff --git a/arch/arm/mach-clps711x/include/mach/io.h b/arch/arm/mach-clps711x/include/mach/io.h
deleted file mode 100644
index 2e0b3ce..0000000
--- a/arch/arm/mach-clps711x/include/mach/io.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/*
- *  arch/arm/mach-clps711x/include/mach/io.h
- *
- *  Copyright (C) 1999 ARM Limited
- *
- * This program is free software; you can redistribute it and/or modify
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
- */
-#ifndef __ASM_ARM_ARCH_IO_H
-#define __ASM_ARM_ARCH_IO_H
-
-#define IO_SPACE_LIMIT 0xffffffff
-
-#define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
-/*
- * We don't support ins[lb]/outs[lb].  Make them fault.
- */
-#define __raw_readsb(p,d,l)	do { *(int *)0 = 0; } while (0)
-#define __raw_readsl(p,d,l)	do { *(int *)0 = 0; } while (0)
-#define __raw_writesb(p,d,l)	do { *(int *)0 = 0; } while (0)
-#define __raw_writesl(p,d,l)	do { *(int *)0 = 0; } while (0)
-
-#endif
diff --git a/arch/arm/mach-cns3xxx/include/mach/io.h b/arch/arm/mach-cns3xxx/include/mach/io.h
deleted file mode 100644
index 33b6fc1..0000000
--- a/arch/arm/mach-cns3xxx/include/mach/io.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- * Copyright 2008 Cavium Networks
- * Copyright 2003 ARM Limited
- *
- * This file is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License, Version 2, as
- * published by the Free Software Foundation.
- */
-#ifndef __MACH_IO_H
-#define __MACH_IO_H
-
-#define IO_SPACE_LIMIT 0xffffffff
-
-#define __io(a)			__typesafe_io(a)
-#define __mem_pci(a)		(a)
-
-#endif
diff --git a/arch/arm/mach-davinci/include/mach/io.h b/arch/arm/mach-davinci/include/mach/io.h
deleted file mode 100644
index b2267d1..0000000
--- a/arch/arm/mach-davinci/include/mach/io.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * DaVinci IO address definitions
- *
- * Copied from include/asm/arm/arch-omap/io.h
- *
- * 2007 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-#ifndef __ASM_ARCH_IO_H
-#define __ASM_ARCH_IO_H
-
-#define IO_SPACE_LIMIT 0xffffffff
-
-/*
- * We don't actually have real ISA nor PCI buses, but there is so many
- * drivers out there that might just work if we fake them...
- */
-#define __io(a)			__typesafe_io(a)
-#define __mem_pci(a)		(a)
-#define __mem_isa(a)		(a)
-
-#endif /* __ASM_ARCH_IO_H */
diff --git a/arch/arm/mach-ep93xx/include/mach/io.h b/arch/arm/mach-ep93xx/include/mach/io.h
deleted file mode 100644
index 594b77f..0000000
--- a/arch/arm/mach-ep93xx/include/mach/io.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * arch/arm/mach-ep93xx/include/mach/io.h
- */
-
-#ifndef __ASM_MACH_IO_H
-#define __ASM_MACH_IO_H
-
-#define IO_SPACE_LIMIT		0xffffffff
-
-#define __io(p)			__typesafe_io(p)
-#define __mem_pci(p)		(p)
-
-/*
- * A typesafe __io() variation for variable initialisers
- */
-#ifdef __ASSEMBLER__
-#define IOMEM(p)		p
-#else
-#define IOMEM(p)		((void __iomem __force *)(p))
-#endif
-
-#endif /* __ASM_MACH_IO_H */
diff --git a/arch/arm/mach-exynos/include/mach/io.h b/arch/arm/mach-exynos/include/mach/io.h
deleted file mode 100644
index d5478d2..0000000
--- a/arch/arm/mach-exynos/include/mach/io.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/* linux/arch/arm/mach-exynos4/include/mach/io.h
- *
- * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * Copyright 2008-2010 Ben Dooks <ben-linux@fluff.org>
- *
- * Based on arch/arm/mach-s5p6442/include/mach/io.h
- *
- * Default IO routines for EXYNOS4
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARM_ARCH_IO_H
-#define __ASM_ARM_ARCH_IO_H __FILE__
-
-/* No current ISA/PCI bus support. */
-#define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
-#define IO_SPACE_LIMIT (0xFFFFFFFF)
-
-#endif /* __ASM_ARM_ARCH_IO_H */
diff --git a/arch/arm/mach-gemini/include/mach/io.h b/arch/arm/mach-gemini/include/mach/io.h
deleted file mode 100644
index c548056..0000000
--- a/arch/arm/mach-gemini/include/mach/io.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- *  Copyright (C) 2001-2006 Storlink, Corp.
- *  Copyright (C) 2008-2009 Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-#ifndef __MACH_IO_H
-#define __MACH_IO_H
-
-#define IO_SPACE_LIMIT	0xffffffff
-
-#define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
-#endif /* __MACH_IO_H */
diff --git a/arch/arm/mach-h720x/include/mach/io.h b/arch/arm/mach-h720x/include/mach/io.h
deleted file mode 100644
index 2c8659c..0000000
--- a/arch/arm/mach-h720x/include/mach/io.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * arch/arm/mach-h720x/include/mach/io.h
- *
- * Copyright (C) 2000 Steve Hill (sjhill at cotw.com)
- *
- * Changelog:
- *
- *  09-19-2001	JJKIM
- *  		Created from arch/arm/mach-l7200/include/mach/io.h
- *
- *  03-27-2003  Robert Schwebel <r.schwebel@pengutronix.de>:
- *  		re-unified header files for h720x
- */
-#ifndef __ASM_ARM_ARCH_IO_H
-#define __ASM_ARM_ARCH_IO_H
-
-#define IO_SPACE_LIMIT 0xffffffff
-
-#define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
-#endif
diff --git a/arch/arm/mach-highbank/include/mach/io.h b/arch/arm/mach-highbank/include/mach/io.h
deleted file mode 100644
index 70cfa3b..0000000
--- a/arch/arm/mach-highbank/include/mach/io.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef __MACH_IO_H
-#define __MACH_IO_H
-
-#define __io(a)		({ (void)(a); __typesafe_io(0); })
-#define __mem_pci(a)	(a)
-
-#endif
diff --git a/arch/arm/mach-ks8695/include/mach/io.h b/arch/arm/mach-ks8695/include/mach/io.h
deleted file mode 100644
index a7a63ac..0000000
--- a/arch/arm/mach-ks8695/include/mach/io.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * arch/arm/mach-ks8695/include/mach/io.h
- *
- * Copyright (C) 2006 Andrew Victor
- *
- * This file is licensed under  the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __ASM_ARCH_IO_H
-#define __ASM_ARCH_IO_H
-
-#define IO_SPACE_LIMIT		0xffffffff
-
-#define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
-#endif
diff --git a/arch/arm/mach-lpc32xx/include/mach/io.h b/arch/arm/mach-lpc32xx/include/mach/io.h
deleted file mode 100644
index 9b59ab5..0000000
--- a/arch/arm/mach-lpc32xx/include/mach/io.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * arch/arm/mach-lpc32xx/include/mach/io.h
- *
- * Author: Kevin Wells <kevin.wells@nxp.com>
- *
- * Copyright (C) 2010 NXP Semiconductors
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#ifndef __ASM_ARM_ARCH_IO_H
-#define __ASM_ARM_ARCH_IO_H
-
-#define IO_SPACE_LIMIT	0xffffffff
-
-#define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
-#endif
diff --git a/arch/arm/mach-mmp/include/mach/io.h b/arch/arm/mach-mmp/include/mach/io.h
deleted file mode 100644
index e7adf3d..0000000
--- a/arch/arm/mach-mmp/include/mach/io.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * linux/arch/arm/mach-mmp/include/mach/io.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ASM_MACH_IO_H
-#define __ASM_MACH_IO_H
-
-#define IO_SPACE_LIMIT 0xffffffff
-
-/*
- * We don't actually have real ISA nor PCI buses, but there is so many
- * drivers out there that might just work if we fake them...
- */
-#define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
-#endif /* __ASM_MACH_IO_H */
diff --git a/arch/arm/mach-msm/include/mach/io.h b/arch/arm/mach-msm/include/mach/io.h
deleted file mode 100644
index 1071f98..0000000
--- a/arch/arm/mach-msm/include/mach/io.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* arch/arm/mach-msm/include/mach/io.h
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
- */
-
-#ifndef __ASM_ARM_ARCH_IO_H
-#define __ASM_ARM_ARCH_IO_H
-
-#define IO_SPACE_LIMIT 0xffffffff
-
-#define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)    (a)
-
-#endif
diff --git a/arch/arm/mach-mxs/include/mach/io.h b/arch/arm/mach-mxs/include/mach/io.h
deleted file mode 100644
index 289b722..0000000
--- a/arch/arm/mach-mxs/include/mach/io.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- *  Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
- */
-
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __MACH_MXS_IO_H__
-#define __MACH_MXS_IO_H__
-
-/* Allow IO space to be anywhere in the memory */
-#define IO_SPACE_LIMIT 0xffffffff
-
-/* io address mapping macro */
-#define __io(a)		__typesafe_io(a)
-
-#define __mem_pci(a)	(a)
-
-#endif /* __MACH_MXS_IO_H__ */
diff --git a/arch/arm/mach-netx/include/mach/io.h b/arch/arm/mach-netx/include/mach/io.h
deleted file mode 100644
index c3921cb..0000000
--- a/arch/arm/mach-netx/include/mach/io.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- *  arch/arm/mach-netx/include/mach/io.h
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
-#ifndef __ASM_ARM_ARCH_IO_H
-#define __ASM_ARM_ARCH_IO_H
-
-#define IO_SPACE_LIMIT 0xffffffff
-
-#define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)            (a)
-
-#endif
diff --git a/arch/arm/mach-nomadik/include/mach/io.h b/arch/arm/mach-nomadik/include/mach/io.h
deleted file mode 100644
index 2e1eca1..0000000
--- a/arch/arm/mach-nomadik/include/mach/io.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * arch/arm/mach-nomadik/include/mach/io.h   (copied from mach-sa1100)
- *
- * Copyright (C) 1997-1999 Russell King
- *
- * Modifications:
- *  06-12-1997  RMK     Created.
- *  07-04-1999  RMK     Major cleanup
- */
-#ifndef __ASM_ARM_ARCH_IO_H
-#define __ASM_ARM_ARCH_IO_H
-
-#define IO_SPACE_LIMIT 0xffffffff
-
-/*
- * We don't actually have real ISA nor PCI buses, but there is so many
- * drivers out there that might just work if we fake them...
- */
-#define __io(a)         __typesafe_io(a)
-#define __mem_pci(a)    (a)
-
-#endif
diff --git a/arch/arm/mach-orion5x/include/mach/io.h b/arch/arm/mach-orion5x/include/mach/io.h
deleted file mode 100644
index 444136d..0000000
--- a/arch/arm/mach-orion5x/include/mach/io.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * arch/arm/mach-orion5x/include/mach/io.h
- *
- * Tzachi Perelstein <tzachi@marvell.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __ASM_ARCH_IO_H
-#define __ASM_ARCH_IO_H
-
-#include "orion5x.h"
-
-#define IO_SPACE_LIMIT		0xffffffff
-
-#define __io(a)			__typesafe_io(a)
-#define __mem_pci(a)		(a)
-
-#endif
diff --git a/arch/arm/mach-picoxcell/include/mach/io.h b/arch/arm/mach-picoxcell/include/mach/io.h
deleted file mode 100644
index 7573ec7..0000000
--- a/arch/arm/mach-picoxcell/include/mach/io.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * Copyright (c) 2011 Picochip Ltd., Jamie Iles
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-#ifndef __ASM_ARM_ARCH_IO_H
-#define __ASM_ARM_ARCH_IO_H
-
-/* No ioports, but needed for driver compatibility. */
-#define __io(a)			__typesafe_io(a)
-/* No PCI possible on picoxcell. */
-#define __mem_pci(a)		(a)
-
-#endif /* __ASM_ARM_ARCH_IO_H */
diff --git a/arch/arm/mach-pnx4008/include/mach/io.h b/arch/arm/mach-pnx4008/include/mach/io.h
deleted file mode 100644
index cbf0904..0000000
--- a/arch/arm/mach-pnx4008/include/mach/io.h
+++ /dev/null
@@ -1,21 +0,0 @@
-
-/*
- *  arch/arm/mach-pnx4008/include/mach/io.h
- *
- * Author: Dmitry Chigirev <chigirev@ru.mvista.com>
- *
- * 2005 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-
-#ifndef __ASM_ARM_ARCH_IO_H
-#define __ASM_ARM_ARCH_IO_H
-
-#define IO_SPACE_LIMIT 0xffffffff
-
-#define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
-#endif
diff --git a/arch/arm/mach-prima2/include/mach/io.h b/arch/arm/mach-prima2/include/mach/io.h
deleted file mode 100644
index 6c31e9e..0000000
--- a/arch/arm/mach-prima2/include/mach/io.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/*
- * arch/arm/mach-prima2/include/mach/io.h
- *
- * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
- *
- * Licensed under GPLv2 or later.
- */
-
-#ifndef __MACH_PRIMA2_IO_H
-#define __MACH_PRIMA2_IO_H
-
-#define IO_SPACE_LIMIT ((resource_size_t)0)
-
-#define __mem_pci(a)            (a)
-
-#endif
diff --git a/arch/arm/mach-pxa/include/mach/io.h b/arch/arm/mach-pxa/include/mach/io.h
deleted file mode 100644
index fdca3be..0000000
--- a/arch/arm/mach-pxa/include/mach/io.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- * arch/arm/mach-pxa/include/mach/io.h
- *
- * Copied from asm/arch/sa1100/io.h
- */
-#ifndef __ASM_ARM_ARCH_IO_H
-#define __ASM_ARM_ARCH_IO_H
-
-#include <mach/hardware.h>
-
-#define IO_SPACE_LIMIT 0xffffffff
-
-/*
- * We don't actually have real ISA nor PCI buses, but there is so many
- * drivers out there that might just work if we fake them...
- */
-#define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
-#endif
diff --git a/arch/arm/mach-realview/include/mach/io.h b/arch/arm/mach-realview/include/mach/io.h
deleted file mode 100644
index f05bcdf..0000000
--- a/arch/arm/mach-realview/include/mach/io.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- *  arch/arm/mach-realview/include/mach/io.h
- *
- *  Copyright (C) 2003 ARM Limited
- *
- * This program is free software; you can redistribute it and/or modify
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
- */
-#ifndef __ASM_ARM_ARCH_IO_H
-#define __ASM_ARM_ARCH_IO_H
-
-#define IO_SPACE_LIMIT 0xffffffff
-
-#define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
-#endif
diff --git a/arch/arm/mach-s3c64xx/include/mach/io.h b/arch/arm/mach-s3c64xx/include/mach/io.h
deleted file mode 100644
index de5716d..0000000
--- a/arch/arm/mach-s3c64xx/include/mach/io.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* arch/arm/mach-s3c64xxinclude/mach/io.h
- *
- * Copyright 2008 Simtec Electronics
- *	Ben Dooks <ben-linux@fluff.org>
- *
- * Default IO routines for S3C64XX based
- */
-
-#ifndef __ASM_ARM_ARCH_IO_H
-#define __ASM_ARM_ARCH_IO_H
-
-/* No current ISA/PCI bus support. */
-#define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
-#define IO_SPACE_LIMIT (0xFFFFFFFF)
-
-#endif
diff --git a/arch/arm/mach-s5p64x0/include/mach/io.h b/arch/arm/mach-s5p64x0/include/mach/io.h
deleted file mode 100644
index a3e095c..0000000
--- a/arch/arm/mach-s5p64x0/include/mach/io.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* linux/arch/arm/mach-s5p64x0/include/mach/io.h
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * Copyright 2008 Simtec Electronics
- *	Ben Dooks <ben-linux@fluff.org>
- *
- * Default IO routines for S5P64X0 based
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARM_ARCH_IO_H
-#define __ASM_ARM_ARCH_IO_H
-
-/* No current ISA/PCI bus support. */
-#define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
-#define IO_SPACE_LIMIT (0xFFFFFFFF)
-
-#endif
diff --git a/arch/arm/mach-s5pc100/include/mach/io.h b/arch/arm/mach-s5pc100/include/mach/io.h
deleted file mode 100644
index 819acf5..0000000
--- a/arch/arm/mach-s5pc100/include/mach/io.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* arch/arm/mach-s5pc100/include/mach/io.h
- *
- * Copyright 2008 Simtec Electronics
- *	Ben Dooks <ben-linux@fluff.org>
- *
- * Default IO routines for S5PC100 systems
- */
-
-#ifndef __ASM_ARM_ARCH_IO_H
-#define __ASM_ARM_ARCH_IO_H
-
-/* No current ISA/PCI bus support. */
-#define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
-#define IO_SPACE_LIMIT (0xFFFFFFFF)
-
-#endif
diff --git a/arch/arm/mach-s5pv210/include/mach/io.h b/arch/arm/mach-s5pv210/include/mach/io.h
deleted file mode 100644
index 5ab9d56..0000000
--- a/arch/arm/mach-s5pv210/include/mach/io.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/* linux/arch/arm/mach-s5pv210/include/mach/io.h
- *
- * Copyright 2008-2010 Ben Dooks <ben-linux@fluff.org>
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * Based on arch/arm/mach-s5p6442/include/mach/io.h
- *
- * Default IO routines for S5PV210
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARM_ARCH_IO_H
-#define __ASM_ARM_ARCH_IO_H __FILE__
-
-/* No current ISA/PCI bus support. */
-#define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
-#define IO_SPACE_LIMIT (0xFFFFFFFF)
-
-#endif /* __ASM_ARM_ARCH_IO_H */
diff --git a/arch/arm/mach-sa1100/include/mach/io.h b/arch/arm/mach-sa1100/include/mach/io.h
deleted file mode 100644
index dfc27ff..0000000
--- a/arch/arm/mach-sa1100/include/mach/io.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- * arch/arm/mach-sa1100/include/mach/io.h
- *
- * Copyright (C) 1997-1999 Russell King
- *
- * Modifications:
- *  06-12-1997	RMK	Created.
- *  07-04-1999	RMK	Major cleanup
- */
-#ifndef __ASM_ARM_ARCH_IO_H
-#define __ASM_ARM_ARCH_IO_H
-
-/*
- * __io() is required to be an equivalent mapping to __mem_pci() for
- * SOC_COMMON to work.
- */
-#define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
-#endif
diff --git a/arch/arm/mach-shmobile/include/mach/io.h b/arch/arm/mach-shmobile/include/mach/io.h
deleted file mode 100644
index 7339fe4..0000000
--- a/arch/arm/mach-shmobile/include/mach/io.h
+++ /dev/null
@@ -1,9 +0,0 @@
-#ifndef __ASM_MACH_IO_H
-#define __ASM_MACH_IO_H
-
-#define IO_SPACE_LIMIT		0xffffffff
-
-#define __io(a)			((void __iomem *)(a))
-#define __mem_pci(a)		(a)
-
-#endif /* __ASM_MACH_IO_H */
diff --git a/arch/arm/mach-spear3xx/include/mach/io.h b/arch/arm/mach-spear3xx/include/mach/io.h
deleted file mode 100644
index 30cff8a..0000000
--- a/arch/arm/mach-spear3xx/include/mach/io.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * arch/arm/mach-spear3xx/include/mach/io.h
- *
- * IO definitions for SPEAr3xx machine family
- *
- * Copyright (C) 2009 ST Microelectronics
- * Viresh Kumar<viresh.kumar@st.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __MACH_IO_H
-#define __MACH_IO_H
-
-#include <plat/io.h>
-
-#endif /* __MACH_IO_H */
diff --git a/arch/arm/mach-spear6xx/include/mach/io.h b/arch/arm/mach-spear6xx/include/mach/io.h
deleted file mode 100644
index fb7c106..0000000
--- a/arch/arm/mach-spear6xx/include/mach/io.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- * arch/arm/mach-spear6xx/include/mach/io.h
- *
- * IO definitions for SPEAr6xx machine family
- *
- * Copyright (C) 2009 ST Microelectronics
- * Rajeev Kumar Kumar<rajeev-dlh.kumar@st.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __MACH_IO_H
-#define __MACH_IO_H
-
-#include <plat/io.h>
-
-#endif	/* __MACH_IO_H */
-
diff --git a/arch/arm/mach-u300/include/mach/io.h b/arch/arm/mach-u300/include/mach/io.h
deleted file mode 100644
index 5d6b4c1..0000000
--- a/arch/arm/mach-u300/include/mach/io.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- *
- * arch/arm/mach-u300/include/mach/io.h
- *
- *
- * Copyright (C) 2006-2009 ST-Ericsson AB
- * License terms: GNU General Public License (GPL) version 2
- * Dummy IO map for being able to use writew()/readw(),
- * writel()/readw() and similar accessor functions.
- * Author: Linus Walleij <linus.walleij@stericsson.com>
- */
-#ifndef __MACH_IO_H
-#define __MACH_IO_H
-
-#define IO_SPACE_LIMIT 0xffffffff
-
-#define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
-#endif
diff --git a/arch/arm/mach-ux500/include/mach/io.h b/arch/arm/mach-ux500/include/mach/io.h
deleted file mode 100644
index 1cf3f44..0000000
--- a/arch/arm/mach-ux500/include/mach/io.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * arch/arm/mach-u8500/include/mach/io.h
- *
- * Copyright (C) 1997-1999 Russell King
- *
- * Modifications:
- *  06-12-1997	RMK	Created.
- *  07-04-1999	RMK	Major cleanup
- */
-#ifndef __ASM_ARM_ARCH_IO_H
-#define __ASM_ARM_ARCH_IO_H
-
-#define IO_SPACE_LIMIT 0xffffffff
-
-/*
- * We don't actually have real ISA nor PCI buses, but there is so many
- * drivers out there that might just work if we fake them...
- */
-#define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
-#endif
diff --git a/arch/arm/mach-versatile/include/mach/io.h b/arch/arm/mach-versatile/include/mach/io.h
deleted file mode 100644
index f067c14..0000000
--- a/arch/arm/mach-versatile/include/mach/io.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- *  arch/arm/mach-versatile/include/mach/io.h
- *
- *  Copyright (C) 2003 ARM Limited
- *
- * This program is free software; you can redistribute it and/or modify
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
- */
-#ifndef __ASM_ARM_ARCH_IO_H
-#define __ASM_ARM_ARCH_IO_H
-
-#define IO_SPACE_LIMIT 0xffffffff
-
-#define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
-#endif
diff --git a/arch/arm/mach-vexpress/include/mach/io.h b/arch/arm/mach-vexpress/include/mach/io.h
deleted file mode 100644
index 13522d8..0000000
--- a/arch/arm/mach-vexpress/include/mach/io.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- *  arch/arm/mach-vexpress/include/mach/io.h
- *
- *  Copyright (C) 2003 ARM Limited
- *
- * This program is free software; you can redistribute it and/or modify
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
- */
-#ifndef __ASM_ARM_ARCH_IO_H
-#define __ASM_ARM_ARCH_IO_H
-
-#define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
-#endif
diff --git a/arch/arm/mach-w90x900/include/mach/io.h b/arch/arm/mach-w90x900/include/mach/io.h
deleted file mode 100644
index d96ab99..0000000
--- a/arch/arm/mach-w90x900/include/mach/io.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * arch/arm/mach-w90x900/include/mach/io.h
- *
- * Copyright (c) 2008 Nuvoton technology corporation
- * All rights reserved.
- *
- * Wan ZongShun <mcuos.com@gmail.com>
- *
- * Based on arch/arm/mach-s3c2410/include/mach/io.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- */
-
-#ifndef __ASM_ARM_ARCH_IO_H
-#define __ASM_ARM_ARCH_IO_H
-
-#define IO_SPACE_LIMIT	0xffffffff
-
-/*
- * 1:1 mapping for ioremapped regions.
- */
-
-#define __mem_pci(a)	(a)
-#define __io(a)		__typesafe_io(a)
-
-#endif
diff --git a/arch/arm/mach-zynq/include/mach/io.h b/arch/arm/mach-zynq/include/mach/io.h
deleted file mode 100644
index 39d9885..0000000
--- a/arch/arm/mach-zynq/include/mach/io.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/* arch/arm/mach-zynq/include/mach/io.h
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
- */
-
-#ifndef __MACH_IO_H__
-#define __MACH_IO_H__
-
-/* Allow IO space to be anywhere in the memory */
-
-#define IO_SPACE_LIMIT 0xffff
-
-/* IO address mapping macros, nothing special at this time but required */
-
-#ifdef __ASSEMBLER__
-#define IOMEM(x)		(x)
-#else
-#define IOMEM(x)		((void __force __iomem *)(x))
-#endif
-
-#define __io(a)			__typesafe_io(a)
-#define __mem_pci(a)		(a)
-
-#endif
diff --git a/arch/arm/plat-mxc/include/mach/io.h b/arch/arm/plat-mxc/include/mach/io.h
deleted file mode 100644
index ea9d95e..0000000
--- a/arch/arm/plat-mxc/include/mach/io.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- *  Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
- */
-
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ASM_ARCH_MXC_IO_H__
-#define __ASM_ARCH_MXC_IO_H__
-
-/* Allow IO space to be anywhere in the memory */
-#define IO_SPACE_LIMIT 0xffffffff
-
-/* io address mapping macro */
-#define __io(a)		__typesafe_io(a)
-
-#define __mem_pci(a)	(a)
-
-#endif
diff --git a/arch/arm/plat-spear/include/plat/io.h b/arch/arm/plat-spear/include/plat/io.h
deleted file mode 100644
index 4d4ba82..0000000
--- a/arch/arm/plat-spear/include/plat/io.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * arch/arm/plat-spear/include/plat/io.h
- *
- * IO definitions for SPEAr platform
- *
- * Copyright (C) 2009 ST Microelectronics
- * Viresh Kumar<viresh.kumar@st.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __PLAT_IO_H
-#define __PLAT_IO_H
-
-#define IO_SPACE_LIMIT		0xFFFFFFFF
-
-#define __io(a)			__typesafe_io(a)
-#define __mem_pci(a)		(a)
-
-#endif /* __PLAT_IO_H */
-- 
1.7.5.4
