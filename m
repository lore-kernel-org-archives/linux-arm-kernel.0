From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 23:30:17 -0400
Subject: [PATCH 33/37] ARM: mach-shark: remove mach/memory.h
In-Reply-To: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309923021-23487-33-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/Kconfig                          |    1 +
 arch/arm/mach-shark/include/mach/memory.h |   20 --------------------
 2 files changed, 1 insertions(+), 20 deletions(-)
 delete mode 100644 arch/arm/mach-shark/include/mach/memory.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d6b8c92..8e0763b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -820,6 +820,7 @@ config ARCH_SHARK
 	select ZONE_DMA
 	select PCI
 	select ARCH_USES_GETTIMEOFFSET
+	select NO_MACH_MEMORY_H
 	help
 	  Support for the StrongARM based Digital DNARD machine, also known
 	  as "Shark" (<http://www.shark-linux.de/shark.html>).
diff --git a/arch/arm/mach-shark/include/mach/memory.h b/arch/arm/mach-shark/include/mach/memory.h
deleted file mode 100644
index e19df6f..0000000
--- a/arch/arm/mach-shark/include/mach/memory.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- * arch/arm/mach-shark/include/mach/memory.h
- *
- * by Alexander Schulz
- *
- * derived from:
- * arch/arm/mach-ebsa110/include/mach/memory.h
- * Copyright (c) 1996-1999 Russell King.
- */
-#ifndef __ASM_ARCH_MEMORY_H
-#define __ASM_ARCH_MEMORY_H
-
-#include <asm/sizes.h>
-
-/*
- * Physical DRAM offset.
- */
-#define PLAT_PHYS_OFFSET     UL(0x08000000)
-
-#endif
-- 
1.7.4
