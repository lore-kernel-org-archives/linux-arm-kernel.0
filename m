From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 23:30:20 -0400
Subject: [PATCH 36/37] ARM: mach-ixp4xx: remove mach/memory.h
In-Reply-To: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309923021-23487-36-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/Kconfig                           |    1 +
 arch/arm/mach-ixp4xx/include/mach/memory.h |   17 -----------------
 2 files changed, 1 insertions(+), 17 deletions(-)
 delete mode 100644 arch/arm/mach-ixp4xx/include/mach/memory.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e105da4..46d4c84 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -491,6 +491,7 @@ config ARCH_IXP4XX
 	select HAVE_SCHED_CLOCK
 	select MIGHT_HAVE_PCI
 	select DMABOUNCE if PCI
+	select NO_MACH_MEMORY_H
 	help
 	  Support for Intel's IXP4XX (XScale) family of processors.
 
diff --git a/arch/arm/mach-ixp4xx/include/mach/memory.h b/arch/arm/mach-ixp4xx/include/mach/memory.h
deleted file mode 100644
index 4caf176..0000000
--- a/arch/arm/mach-ixp4xx/include/mach/memory.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- * arch/arm/mach-ixp4xx/include/mach/memory.h
- *
- * Copyright (c) 2001-2004 MontaVista Software, Inc.
- */
-
-#ifndef __ASM_ARCH_MEMORY_H
-#define __ASM_ARCH_MEMORY_H
-
-#include <asm/sizes.h>
-
-/*
- * Physical DRAM offset.
- */
-#define PLAT_PHYS_OFFSET	UL(0x00000000)
-
-#endif
-- 
1.7.4
