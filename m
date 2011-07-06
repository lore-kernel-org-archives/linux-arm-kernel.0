From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 23:30:06 -0400
Subject: [PATCH 22/37] ARM: mach-gemini: remove mach/memory.h
In-Reply-To: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309923021-23487-22-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/Kconfig                           |    1 +
 arch/arm/mach-gemini/include/mach/memory.h |   19 -------------------
 2 files changed, 1 insertions(+), 19 deletions(-)
 delete mode 100644 arch/arm/mach-gemini/include/mach/memory.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index cecbc51..8495852 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -349,6 +349,7 @@ config ARCH_GEMINI
 	select CPU_FA526
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_USES_GETTIMEOFFSET
+	select NO_MACH_MEMORY_H
 	help
 	  Support for the Cortina Systems Gemini family SoCs
 
diff --git a/arch/arm/mach-gemini/include/mach/memory.h b/arch/arm/mach-gemini/include/mach/memory.h
deleted file mode 100644
index a50915f..0000000
--- a/arch/arm/mach-gemini/include/mach/memory.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- *  Copyright (C) 2001-2006 Storlink, Corp.
- *  Copyright (C) 2008-2009 Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-#ifndef __MACH_MEMORY_H
-#define __MACH_MEMORY_H
-
-#ifdef CONFIG_GEMINI_MEM_SWAP
-# define PLAT_PHYS_OFFSET	UL(0x00000000)
-#else
-# define PLAT_PHYS_OFFSET	UL(0x10000000)
-#endif
-
-#endif /* __MACH_MEMORY_H */
-- 
1.7.4
