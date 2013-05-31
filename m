From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 31 May 2013 11:19:04 +0200
Subject: [PATCH 29/39] ARM: u300: delete remnant machine headers
In-Reply-To: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
References: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1369991954-17406-30-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Two files remain in <mach/*> for U300: timex.h and
uncompress.h. The former is done away with by using
defaults, the latter is unused in multiplatform.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-u300/include/mach/timex.h      | 17 -----------
 arch/arm/mach-u300/include/mach/uncompress.h | 45 ----------------------------
 2 files changed, 62 deletions(-)
 delete mode 100644 arch/arm/mach-u300/include/mach/timex.h
 delete mode 100644 arch/arm/mach-u300/include/mach/uncompress.h

diff --git a/arch/arm/mach-u300/include/mach/timex.h b/arch/arm/mach-u300/include/mach/timex.h
deleted file mode 100644
index f233b72..0000000
--- a/arch/arm/mach-u300/include/mach/timex.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- *
- * arch/arm/mach-u300/include/mach/timex.h
- *
- *
- * Copyright (C) 2006-2009 ST-Ericsson AB
- * License terms: GNU General Public License (GPL) version 2
- * Platform tick rate definition.
- * Author: Linus Walleij <linus.walleij@stericsson.com>
- */
-#ifndef __MACH_TIMEX_H
-#define __MACH_TIMEX_H
-
-/* This is for the APP OS GP1 (General Purpose 1) timer */
-#define CLOCK_TICK_RATE		1000000
-
-#endif
diff --git a/arch/arm/mach-u300/include/mach/uncompress.h b/arch/arm/mach-u300/include/mach/uncompress.h
deleted file mode 100644
index 783e7e6..0000000
--- a/arch/arm/mach-u300/include/mach/uncompress.h
+++ /dev/null
@@ -1,45 +0,0 @@
-/*
- * arch/arm/mach-u300/include/mach/uncompress.h
- *
- * Copyright (C) 2003 ARM Limited
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
-#define AMBA_UART_DR	(*(volatile unsigned char *)0xc0013000)
-#define AMBA_UART_LCRH	(*(volatile unsigned char *)0xc001302C)
-#define AMBA_UART_CR	(*(volatile unsigned char *)0xc0013030)
-#define AMBA_UART_FR	(*(volatile unsigned char *)0xc0013018)
-
-/*
- * This does not append a newline
- */
-static inline void putc(int c)
-{
-	while (AMBA_UART_FR & (1 << 5))
-		barrier();
-
-	AMBA_UART_DR = c;
-}
-
-static inline void flush(void)
-{
-	while (AMBA_UART_FR & (1 << 3))
-		barrier();
-}
-
-/*
- * nothing to do
- */
-#define arch_decomp_setup()
-- 
1.7.11.3
