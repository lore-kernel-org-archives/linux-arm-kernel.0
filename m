From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 23:29:52 -0400
Subject: [PATCH 08/37] ARM: mach-omap2: remove mach/memory.h
In-Reply-To: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309923021-23487-8-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-omap2/include/mach/memory.h |    5 ---
 arch/arm/plat-omap/Kconfig                |    1 +
 arch/arm/plat-omap/include/plat/memory.h  |   46 -----------------------------
 3 files changed, 1 insertions(+), 51 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/include/mach/memory.h
 delete mode 100644 arch/arm/plat-omap/include/plat/memory.h

diff --git a/arch/arm/mach-omap2/include/mach/memory.h b/arch/arm/mach-omap2/include/mach/memory.h
deleted file mode 100644
index ca6d32a..0000000
--- a/arch/arm/mach-omap2/include/mach/memory.h
+++ /dev/null
@@ -1,5 +0,0 @@
-/*
- * arch/arm/mach-omap2/include/mach/memory.h
- */
-
-#include <plat/memory.h>
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 49a4c75..db30a1d 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -21,6 +21,7 @@ config ARCH_OMAP2PLUS
 	select CLKDEV_LOOKUP
 	select GENERIC_IRQ_CHIP
 	select OMAP_DM_TIMER
+	select NO_MACH_MEMORY_H
 	help
 	  "Systems based on OMAP2, OMAP3 or OMAP4"
 
diff --git a/arch/arm/plat-omap/include/plat/memory.h b/arch/arm/plat-omap/include/plat/memory.h
deleted file mode 100644
index 5b1a86d..0000000
--- a/arch/arm/plat-omap/include/plat/memory.h
+++ /dev/null
@@ -1,46 +0,0 @@
-/*
- * arch/arm/plat-omap/include/mach/memory.h
- *
- * Memory map for OMAP-1510 and 1610
- *
- * Copyright (C) 2000 RidgeRun, Inc.
- * Author: Greg Lonnon <glonnon@ridgerun.com>
- *
- * This file was derived from arch/arm/mach-intergrator/include/mach/memory.h
- * Copyright (C) 1999 ARM Limited
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
- *
- * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
- * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
- * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
- * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#ifndef __ASM_ARCH_MEMORY_H
-#define __ASM_ARCH_MEMORY_H
-
-/*
- * Physical DRAM offset.
- */
-#if defined(CONFIG_ARCH_OMAP1)
-#error "OMAP1 should not be including this"
-#else
-#define PLAT_PHYS_OFFSET		UL(0x80000000)
-#endif
-
-#endif
-
-- 
1.7.4
