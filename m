From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Fri, 15 Jun 2012 11:12:45 +0200
Subject: [PATCH v2 6/7] ARM: at91: remove mach/irqs.h
In-Reply-To: <1339751352-24296-1-git-send-email-ludovic.desroches@atmel.com>
References: <1339751352-24296-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1339751565-24429-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mach/irqs only defines FIQ_START which doesn't appear to be used anywhere
so remove it.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/mach-at91/include/mach/irqs.h |   31 -------------------------------
 arch/arm/mach-at91/irq.c               |    2 +-
 2 files changed, 1 insertions(+), 32 deletions(-)
 delete mode 100644 arch/arm/mach-at91/include/mach/irqs.h

diff --git a/arch/arm/mach-at91/include/mach/irqs.h b/arch/arm/mach-at91/include/mach/irqs.h
deleted file mode 100644
index 9223a1e..0000000
--- a/arch/arm/mach-at91/include/mach/irqs.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/*
- * arch/arm/mach-at91/include/mach/irqs.h
- *
- *  Copyright (C) 2004 SAN People
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
-#include <linux/io.h>
-#include <mach/at91_aic.h>
-
-
-/* FIQ is AIC source 0. */
-#define FIQ_START AT91_ID_FIQ
-
-#endif
diff --git a/arch/arm/mach-at91/irq.c b/arch/arm/mach-at91/irq.c
index b0f83e2..a0b9dca 100644
--- a/arch/arm/mach-at91/irq.c
+++ b/arch/arm/mach-at91/irq.c
@@ -32,7 +32,7 @@
 #include <linux/err.h>
 
 #include <mach/hardware.h>
-#include <mach/irqs.h>
+#include <mach/at91_aic.h>
 #include <asm/irq.h>
 #include <asm/setup.h>
 
-- 
1.7.5.4
