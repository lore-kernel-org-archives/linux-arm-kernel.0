From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 17:32:23 +0100
Subject: [PATCH 10/10] ARM: realview: clean up header files
In-Reply-To: <1448469143-447355-1-git-send-email-arnd@arndb.de>
References: <1448469143-447355-1-git-send-email-arnd@arndb.de>
Message-ID: <1448469143-447355-11-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This contains multiple trivial cleanups to the realview headers:

- removing the file names from the introductory comment
- removing the uncompress.h header that is unused
- removing the irqs.h header and NR_IRQS logic that is
  obsoleted by sparse IRQs

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-realview/board-eb.h        |  2 -
 arch/arm/mach-realview/board-pb1176.h    |  2 -
 arch/arm/mach-realview/board-pb11mp.h    |  2 -
 arch/arm/mach-realview/board-pba8.h      |  2 -
 arch/arm/mach-realview/board-pbx.h       |  2 -
 arch/arm/mach-realview/core.h            |  2 -
 arch/arm/mach-realview/hardware.h        |  2 -
 arch/arm/mach-realview/irqs-eb.h         | 20 +--------
 arch/arm/mach-realview/irqs-pb1176.h     | 21 ---------
 arch/arm/mach-realview/irqs-pb11mp.h     | 27 +----------
 arch/arm/mach-realview/irqs-pba8.h       | 23 ----------
 arch/arm/mach-realview/irqs-pbx.h        | 24 +---------
 arch/arm/mach-realview/irqs.h            | 40 -----------------
 arch/arm/mach-realview/platform.h        |  2 -
 arch/arm/mach-realview/realview-dt.c     |  1 -
 arch/arm/mach-realview/realview_eb.c     |  2 +-
 arch/arm/mach-realview/realview_pb1176.c |  2 +-
 arch/arm/mach-realview/realview_pb11mp.c |  2 +-
 arch/arm/mach-realview/realview_pba8.c   |  2 +-
 arch/arm/mach-realview/realview_pbx.c    |  2 +-
 arch/arm/mach-realview/uncompress.h      | 77 --------------------------------
 21 files changed, 8 insertions(+), 251 deletions(-)
 delete mode 100644 arch/arm/mach-realview/irqs.h
 delete mode 100644 arch/arm/mach-realview/uncompress.h

diff --git a/arch/arm/mach-realview/board-eb.h b/arch/arm/mach-realview/board-eb.h
index ac9c98f9a971..a850ae6945b0 100644
--- a/arch/arm/mach-realview/board-eb.h
+++ b/arch/arm/mach-realview/board-eb.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-realview/include/mach/board-eb.h
- *
  * Copyright (C) 2007 ARM Limited
  *
  * This program is free software; you can redistribute it and/or modify
diff --git a/arch/arm/mach-realview/board-pb1176.h b/arch/arm/mach-realview/board-pb1176.h
index 836433dc789c..29c04a9e1344 100644
--- a/arch/arm/mach-realview/board-pb1176.h
+++ b/arch/arm/mach-realview/board-pb1176.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-realview/include/mach/board-pb1176.h
- *
  * Copyright (C) 2008 ARM Limited
  *
  * This program is free software; you can redistribute it and/or modify
diff --git a/arch/arm/mach-realview/board-pb11mp.h b/arch/arm/mach-realview/board-pb11mp.h
index e3a758b147ab..b16e6e85e92d 100644
--- a/arch/arm/mach-realview/board-pb11mp.h
+++ b/arch/arm/mach-realview/board-pb11mp.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-realview/include/mach/board-pb11mp.h
- *
  * Copyright (C) 2008 ARM Limited
  *
  * This program is free software; you can redistribute it and/or modify
diff --git a/arch/arm/mach-realview/board-pba8.h b/arch/arm/mach-realview/board-pba8.h
index 84232fe942d2..6a1391f50373 100644
--- a/arch/arm/mach-realview/board-pba8.h
+++ b/arch/arm/mach-realview/board-pba8.h
@@ -1,6 +1,4 @@
 /*
- * include/asm-arm/arch-realview/board-pba8.h
- *
  * Copyright (C) 2008 ARM Limited
  *
  * This program is free software; you can redistribute it and/or modify
diff --git a/arch/arm/mach-realview/board-pbx.h b/arch/arm/mach-realview/board-pbx.h
index 3dab54fa9e97..5cda480b12bb 100644
--- a/arch/arm/mach-realview/board-pbx.h
+++ b/arch/arm/mach-realview/board-pbx.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-realview/include/mach/board-pbx.h
- *
  * Copyright (C) 2009 ARM Limited
  *
  * This program is free software; you can redistribute it and/or modify
diff --git a/arch/arm/mach-realview/core.h b/arch/arm/mach-realview/core.h
index 868ece221978..e1640b2f4350 100644
--- a/arch/arm/mach-realview/core.h
+++ b/arch/arm/mach-realview/core.h
@@ -1,6 +1,4 @@
 /*
- *  linux/arch/arm/mach-realview/core.h
- *
  *  Copyright (C) 2004 ARM Limited
  *  Copyright (C) 2000 Deep Blue Solutions Ltd
  *
diff --git a/arch/arm/mach-realview/hardware.h b/arch/arm/mach-realview/hardware.h
index 281e71c97525..957a230aadf4 100644
--- a/arch/arm/mach-realview/hardware.h
+++ b/arch/arm/mach-realview/hardware.h
@@ -1,6 +1,4 @@
 /*
- *  arch/arm/mach-realview/include/mach/hardware.h
- *
  *  This file contains the hardware definitions of the RealView boards.
  *
  *  Copyright (C) 2003 ARM Limited.
diff --git a/arch/arm/mach-realview/irqs-eb.h b/arch/arm/mach-realview/irqs-eb.h
index 44754230fdcc..61e31680a749 100644
--- a/arch/arm/mach-realview/irqs-eb.h
+++ b/arch/arm/mach-realview/irqs-eb.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-realview/include/mach/irqs-eb.h
- *
  * Copyright (C) 2007 ARM Limited
  *
  * This program is free software; you can redistribute it and/or modify
@@ -21,6 +19,7 @@
 #ifndef __MACH_IRQS_EB_H
 #define __MACH_IRQS_EB_H
 
+#define IRQ_LOCALTIMER		29
 #define IRQ_EB_GIC_START	32
 
 /*
@@ -112,21 +111,4 @@
 
 #define NR_GIC_EB11MP		2
 
-/*
- * Only define NR_IRQS if less than NR_IRQS_EB
- */
-#define NR_IRQS_EB		(IRQ_EB_GIC_START + 128)
-
-#if defined(CONFIG_MACH_REALVIEW_EB) \
-	&& (!defined(NR_IRQS) || (NR_IRQS < NR_IRQS_EB))
-#undef NR_IRQS
-#define NR_IRQS			NR_IRQS_EB
-#endif
-
-#if defined(CONFIG_REALVIEW_EB_ARM11MP) || defined(CONFIG_REALVIEW_EB_A9MP) \
-	&& (!defined(MAX_GIC_NR) || (MAX_GIC_NR < NR_GIC_EB11MP))
-#undef MAX_GIC_NR
-#define MAX_GIC_NR		NR_GIC_EB11MP
-#endif
-
 #endif	/* __MACH_IRQS_EB_H */
diff --git a/arch/arm/mach-realview/irqs-pb1176.h b/arch/arm/mach-realview/irqs-pb1176.h
index 708f84156f2c..e96c63e4ac72 100644
--- a/arch/arm/mach-realview/irqs-pb1176.h
+++ b/arch/arm/mach-realview/irqs-pb1176.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-realview/include/mach/irqs-pb1176.h
- *
  * Copyright (C) 2008 ARM Limited
  *
  * This program is free software; you can redistribute it and/or modify
@@ -76,25 +74,6 @@
 
 #define IRQ_PB1176_SCTL		-1
 
-#define NR_GIC_PB1176		2
-
-/*
- * Only define NR_IRQS if less than NR_IRQS_PB1176
- */
-#define NR_IRQS_PB1176		(IRQ_DC1176_GIC_START + 96)
-
-#if defined(CONFIG_MACH_REALVIEW_PB1176)
-
-#if !defined(NR_IRQS) || (NR_IRQS < NR_IRQS_PB1176)
-#undef NR_IRQS
-#define NR_IRQS			NR_IRQS_PB1176
-#endif
-
-#if !defined(MAX_GIC_NR) || (MAX_GIC_NR < NR_GIC_PB1176)
-#undef MAX_GIC_NR
-#define MAX_GIC_NR		NR_GIC_PB1176
-#endif
-
 #endif	/* CONFIG_MACH_REALVIEW_PB1176 */
 
 #endif	/* __MACH_IRQS_PB1176_H */
diff --git a/arch/arm/mach-realview/irqs-pb11mp.h b/arch/arm/mach-realview/irqs-pb11mp.h
index 34e255add21e..938898a3df9f 100644
--- a/arch/arm/mach-realview/irqs-pb11mp.h
+++ b/arch/arm/mach-realview/irqs-pb11mp.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-realview/include/mach/irqs-pb11mp.h
- *
  * Copyright (C) 2008 ARM Limited
  *
  * This program is free software; you can redistribute it and/or modify
@@ -21,6 +19,7 @@
 #ifndef __MACH_IRQS_PB11MP_H
 #define __MACH_IRQS_PB11MP_H
 
+#define IRQ_LOCALTIMER				29
 #define IRQ_TC11MP_GIC_START			32
 #define IRQ_PB11MP_GIC_START			64
 
@@ -95,28 +94,4 @@
 #define IRQ_PB11MP_TSPEN	(IRQ_PB11MP_GIC_START + 30)	/* Touchscreen pen */
 #define IRQ_PB11MP_TSKPAD	(IRQ_PB11MP_GIC_START + 31)	/* Touchscreen keypad */
 
-#define IRQ_PB11MP_SMC		-1
-#define IRQ_PB11MP_SCTL		-1
-
-#define NR_GIC_PB11MP		2
-
-/*
- * Only define NR_IRQS if less than NR_IRQS_PB11MP
- */
-#define NR_IRQS_PB11MP		(IRQ_TC11MP_GIC_START + 96)
-
-#if defined(CONFIG_MACH_REALVIEW_PB11MP)
-
-#if !defined(NR_IRQS) || (NR_IRQS < NR_IRQS_PB11MP)
-#undef NR_IRQS
-#define NR_IRQS			NR_IRQS_PB11MP
-#endif
-
-#if !defined(MAX_GIC_NR) || (MAX_GIC_NR < NR_GIC_PB11MP)
-#undef MAX_GIC_NR
-#define MAX_GIC_NR		NR_GIC_PB11MP
-#endif
-
-#endif	/* CONFIG_MACH_REALVIEW_PB11MP */
-
 #endif	/* __MACH_IRQS_PB11MP_H */
diff --git a/arch/arm/mach-realview/irqs-pba8.h b/arch/arm/mach-realview/irqs-pba8.h
index 4a88a4edb651..262e321938b8 100644
--- a/arch/arm/mach-realview/irqs-pba8.h
+++ b/arch/arm/mach-realview/irqs-pba8.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-realview/include/mach/irqs-pba8.h
- *
  * Copyright (C) 2008 ARM Limited
  *
  * This program is free software; you can redistribute it and/or modify
@@ -70,25 +68,4 @@
 #define IRQ_PBA8_SMC		-1
 #define IRQ_PBA8_SCTL		-1
 
-#define NR_GIC_PBA8		1
-
-/*
- * Only define NR_IRQS if less than NR_IRQS_PBA8
- */
-#define NR_IRQS_PBA8		(IRQ_PBA8_GIC_START + 64)
-
-#if defined(CONFIG_MACH_REALVIEW_PBA8)
-
-#if !defined(NR_IRQS) || (NR_IRQS < NR_IRQS_PBA8)
-#undef NR_IRQS
-#define NR_IRQS			NR_IRQS_PBA8
-#endif
-
-#if !defined(MAX_GIC_NR) || (MAX_GIC_NR < NR_GIC_PBA8)
-#undef MAX_GIC_NR
-#define MAX_GIC_NR		NR_GIC_PBA8
-#endif
-
-#endif	/* CONFIG_MACH_REALVIEW_PBA8 */
-
 #endif	/* __MACH_IRQS_PBA8_H */
diff --git a/arch/arm/mach-realview/irqs-pbx.h b/arch/arm/mach-realview/irqs-pbx.h
index 206a3001f46b..4ef0567dec32 100644
--- a/arch/arm/mach-realview/irqs-pbx.h
+++ b/arch/arm/mach-realview/irqs-pbx.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-realview/include/mach/irqs-pbx.h
- *
  * Copyright (C) 2009 ARM Limited
  *
  * This program is free software; you can redistribute it and/or modify
@@ -20,6 +18,7 @@
 #ifndef __MACH_IRQS_PBX_H
 #define __MACH_IRQS_PBX_H
 
+#define IRQ_LOCALTIMER				29
 #define IRQ_PBX_GIC_START			32
 
 /*
@@ -85,25 +84,4 @@
 #define IRQ_PBX_SMC		-1
 #define IRQ_PBX_SCTL		-1
 
-#define NR_GIC_PBX		1
-
-/*
- * Only define NR_IRQS if less than NR_IRQS_PBX
- */
-#define NR_IRQS_PBX		(IRQ_PBX_GIC_START + 96)
-
-#if defined(CONFIG_MACH_REALVIEW_PBX)
-
-#if !defined(NR_IRQS) || (NR_IRQS < NR_IRQS_PBX)
-#undef NR_IRQS
-#define NR_IRQS			NR_IRQS_PBX
-#endif
-
-#if !defined(MAX_GIC_NR) || (MAX_GIC_NR < NR_GIC_PBX)
-#undef MAX_GIC_NR
-#define MAX_GIC_NR		NR_GIC_PBX
-#endif
-
-#endif	/* CONFIG_MACH_REALVIEW_PBX */
-
 #endif	/* __MACH_IRQS_PBX_H */
diff --git a/arch/arm/mach-realview/irqs.h b/arch/arm/mach-realview/irqs.h
deleted file mode 100644
index 1bd8a9a00337..000000000000
--- a/arch/arm/mach-realview/irqs.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/*
- *  arch/arm/mach-realview/include/mach/irqs.h
- *
- *  Copyright (C) 2003 ARM Limited
- *  Copyright (C) 2000 Deep Blue Solutions Ltd.
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
-#ifndef __ASM_ARCH_IRQS_H
-#define __ASM_ARCH_IRQS_H
-
-#include "irqs-eb.h"
-#include "irqs-pb11mp.h"
-#include "irqs-pb1176.h"
-#include "irqs-pba8.h"
-#include "irqs-pbx.h"
-
-#define IRQ_LOCALTIMER		29
-#define IRQ_LOCALWDOG		30
-
-#define IRQ_GIC_START		32
-
-#ifndef NR_IRQS
-#error "NR_IRQS not defined by the board-specific files"
-#endif
-
-#endif
diff --git a/arch/arm/mach-realview/platform.h b/arch/arm/mach-realview/platform.h
index 1b77a27badaf..11121739d371 100644
--- a/arch/arm/mach-realview/platform.h
+++ b/arch/arm/mach-realview/platform.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-realview/include/mach/platform.h
- *
  * Copyright (c) ARM Limited 2003.  All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify
diff --git a/arch/arm/mach-realview/realview-dt.c b/arch/arm/mach-realview/realview-dt.c
index 382cc1b90519..88b67247945e 100644
--- a/arch/arm/mach-realview/realview-dt.c
+++ b/arch/arm/mach-realview/realview-dt.c
@@ -11,7 +11,6 @@
 #include <linux/of_platform.h>
 #include <asm/mach/arch.h>
 #include <asm/hardware/cache-l2x0.h>
-#include "core.h"
 
 static const char *const realview_dt_platform_compat[] __initconst = {
 	"arm,realview-eb",
diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index 8059fee79974..09a774624e26 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -44,7 +44,7 @@
 #include <asm/mach/time.h>
 
 #include "board-eb.h"
-#include "irqs.h"
+#include "irqs-eb.h"
 
 #include "core.h"
 
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index e5fd1ce9051f..537f3878d501 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -46,7 +46,7 @@
 #include <asm/mach/time.h>
 
 #include "board-pb1176.h"
-#include "irqs.h"
+#include "irqs-pb1176.h"
 
 #include "core.h"
 
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index 10b16961f7e1..cc7578949f48 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -44,7 +44,7 @@
 #include <asm/mach/time.h>
 
 #include "board-pb11mp.h"
-#include "irqs.h"
+#include "irqs-pb11mp.h"
 
 #include "core.h"
 
diff --git a/arch/arm/mach-realview/realview_pba8.c b/arch/arm/mach-realview/realview_pba8.c
index 263e37391445..ddafb67c2b6f 100644
--- a/arch/arm/mach-realview/realview_pba8.c
+++ b/arch/arm/mach-realview/realview_pba8.c
@@ -41,7 +41,7 @@
 
 #include "hardware.h"
 #include "board-pba8.h"
-#include "irqs.h"
+#include "irqs-pba8.h"
 
 #include "core.h"
 
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index 810b15410bf2..b9f0757787ac 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -43,7 +43,7 @@
 
 #include "hardware.h"
 #include "board-pbx.h"
-#include "irqs.h"
+#include "irqs-pbx.h"
 
 #include "core.h"
 
diff --git a/arch/arm/mach-realview/uncompress.h b/arch/arm/mach-realview/uncompress.h
deleted file mode 100644
index f8ac3e723628..000000000000
--- a/arch/arm/mach-realview/uncompress.h
+++ /dev/null
@@ -1,77 +0,0 @@
-/*
- *  arch/arm/mach-realview/include/mach/uncompress.h
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
-#include "hardware.h"
-#include <asm/mach-types.h>
-
-#include "board-eb.h"
-#include "board-pb11mp.h"
-#include "board-pb1176.h"
-#include "board-pba8.h"
-#include "board-pbx.h"
-
-#define AMBA_UART_DR(base)	(*(volatile unsigned char *)((base) + 0x00))
-#define AMBA_UART_LCRH(base)	(*(volatile unsigned char *)((base) + 0x2c))
-#define AMBA_UART_CR(base)	(*(volatile unsigned char *)((base) + 0x30))
-#define AMBA_UART_FR(base)	(*(volatile unsigned char *)((base) + 0x18))
-
-/*
- * Return the UART base address
- */
-static inline unsigned long get_uart_base(void)
-{
-	if (machine_is_realview_eb())
-		return REALVIEW_EB_UART0_BASE;
-	else if (machine_is_realview_pb11mp())
-		return REALVIEW_PB11MP_UART0_BASE;
-	else if (machine_is_realview_pb1176())
-		return REALVIEW_PB1176_UART0_BASE;
-	else if (machine_is_realview_pba8())
-		return REALVIEW_PBA8_UART0_BASE;
-	else if (machine_is_realview_pbx())
-		return REALVIEW_PBX_UART0_BASE;
-	else
-		return 0;
-}
-
-/*
- * This does not append a newline
- */
-static inline void putc(int c)
-{
-	unsigned long base = get_uart_base();
-
-	while (AMBA_UART_FR(base) & (1 << 5))
-		barrier();
-
-	AMBA_UART_DR(base) = c;
-}
-
-static inline void flush(void)
-{
-	unsigned long base = get_uart_base();
-
-	while (AMBA_UART_FR(base) & (1 << 3))
-		barrier();
-}
-
-/*
- * nothing to do
- */
-#define arch_decomp_setup()
-- 
2.1.0.rc2
