From: robherring2@gmail.com (Rob Herring)
Date: Tue, 30 Dec 2014 13:28:36 -0600
Subject: [PATCH 7/9] ARM: versatile: move mach includes into mach directory
In-Reply-To: <1419967718-26909-1-git-send-email-robherring2@gmail.com>
References: <1419967718-26909-1-git-send-email-robherring2@gmail.com>
Message-ID: <1419967718-26909-8-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

In preparation for multi-platform support, move platform.h and
hardware.h into mach-versatile directory. Combine them into a single
file in the process.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-versatile/core.c                     |  3 +-
 arch/arm/mach-versatile/include/mach/hardware.h    | 32 ----------------------
 .../mach-versatile/{include/mach => }/platform.h   |  5 ++++
 3 files changed, 6 insertions(+), 34 deletions(-)
 delete mode 100644 arch/arm/mach-versatile/include/mach/hardware.h
 rename arch/arm/mach-versatile/{include/mach => }/platform.h (98%)

diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 566a946..f6b122b 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -34,8 +34,7 @@
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <mach/hardware.h>
-#include <mach/platform.h>
+#include "platform.h"
 
 #include "core.h"
 
diff --git a/arch/arm/mach-versatile/include/mach/hardware.h b/arch/arm/mach-versatile/include/mach/hardware.h
deleted file mode 100644
index 22a1158..0000000
--- a/arch/arm/mach-versatile/include/mach/hardware.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/*
- *  arch/arm/mach-versatile/include/mach/hardware.h
- *
- *  This file contains the hardware definitions of the Versatile boards.
- *
- *  Copyright (C) 2003 ARM Limited.
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
-#ifndef __ASM_ARCH_HARDWARE_H
-#define __ASM_ARCH_HARDWARE_H
-
-#include <asm/sizes.h>
-
-/* macro to get at MMIO space when running virtually */
-#define IO_ADDRESS(x)		(((x) & 0x0fffffff) + (((x) >> 4) & 0x0f000000) + 0xf0000000)
-
-#define __io_address(n)		((void __iomem __force *)IO_ADDRESS(n))
-
-#endif
diff --git a/arch/arm/mach-versatile/include/mach/platform.h b/arch/arm/mach-versatile/platform.h
similarity index 98%
rename from arch/arm/mach-versatile/include/mach/platform.h
rename to arch/arm/mach-versatile/platform.h
index 7fe008b..05deec2 100644
--- a/arch/arm/mach-versatile/include/mach/platform.h
+++ b/arch/arm/mach-versatile/platform.h
@@ -21,6 +21,11 @@
 #ifndef __address_h
 #define __address_h                     1
 
+/* macro to get at MMIO space when running virtually */
+#define IO_ADDRESS(x)		(((x) & 0x0fffffff) + (((x) >> 4) & 0x0f000000) + 0xf0000000)
+
+#define __io_address(n)		((void __iomem __force *)IO_ADDRESS(n))
+
 /*
  * Memory definitions
  */
-- 
2.1.0
