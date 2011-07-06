From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 23:30:05 -0400
Subject: [PATCH 21/37] ARM: mach-lpc32xx: remove mach/memory.h
In-Reply-To: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309923021-23487-21-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/Kconfig                            |    1 +
 arch/arm/mach-lpc32xx/include/mach/memory.h |   27 ---------------------------
 2 files changed, 1 insertions(+), 27 deletions(-)
 delete mode 100644 arch/arm/mach-lpc32xx/include/mach/memory.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 95396dc..cecbc51 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -532,6 +532,7 @@ config ARCH_LPC32XX
 	select CLKDEV_LOOKUP
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
+	select NO_MACH_MEMORY_H
 	help
 	  Support for the NXP LPC32XX family of processors
 
diff --git a/arch/arm/mach-lpc32xx/include/mach/memory.h b/arch/arm/mach-lpc32xx/include/mach/memory.h
deleted file mode 100644
index a647dd6..0000000
--- a/arch/arm/mach-lpc32xx/include/mach/memory.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * arch/arm/mach-lpc32xx/include/mach/memory.h
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
-#ifndef __ASM_ARCH_MEMORY_H
-#define __ASM_ARCH_MEMORY_H
-
-/*
- * Physical DRAM offset of bank 0
- */
-#define PLAT_PHYS_OFFSET	UL(0x80000000)
-
-#endif
-- 
1.7.4
