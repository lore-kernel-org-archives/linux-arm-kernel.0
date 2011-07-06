From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 23:30:18 -0400
Subject: [PATCH 34/37] ARM: mach-ebsa110: remove mach/memory.h
In-Reply-To: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309923021-23487-34-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/Kconfig                            |    1 +
 arch/arm/mach-ebsa110/include/mach/memory.h |   24 ------------------------
 2 files changed, 1 insertions(+), 24 deletions(-)
 delete mode 100644 arch/arm/mach-ebsa110/include/mach/memory.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 8e0763b..63ac56d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -360,6 +360,7 @@ config ARCH_EBSA110
 	select ISA
 	select NO_IOPORT
 	select ARCH_USES_GETTIMEOFFSET
+	select NO_MACH_MEMORY_H
 	help
 	  This is an evaluation board for the StrongARM processor available
 	  from Digital. It has limited hardware on-board, including an
diff --git a/arch/arm/mach-ebsa110/include/mach/memory.h b/arch/arm/mach-ebsa110/include/mach/memory.h
deleted file mode 100644
index 2af7ec4..0000000
--- a/arch/arm/mach-ebsa110/include/mach/memory.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- *  arch/arm/mach-ebsa110/include/mach/memory.h
- *
- *  Copyright (C) 1996-1999 Russell King.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- *  Changelog:
- *   20-Oct-1996 RMK	Created
- *   31-Dec-1997 RMK	Fixed definitions to reduce warnings
- *   21-Mar-1999 RMK	Renamed to memory.h
- *		 RMK	Moved TASK_SIZE and PAGE_OFFSET here
- */
-#ifndef __ASM_ARCH_MEMORY_H
-#define __ASM_ARCH_MEMORY_H
-
-/*
- * Physical DRAM offset.
- */
-#define PLAT_PHYS_OFFSET	UL(0x00000000)
-
-#endif
-- 
1.7.4
