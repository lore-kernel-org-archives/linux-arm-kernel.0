From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 25 Jun 2010 15:44:31 +0800
Subject: [PATCH 4/4] [ARM] Make pxa and mmp to USE_DEFAULT_IO_H
In-Reply-To: <1277451871-15319-1-git-send-email-eric.y.miao@gmail.com>
References: <1277451871-15319-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1277451871-15319-5-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Miao <eric.miao@canonical.com>

Signed-off-by: Eric Miao <eric.miao@canonical.com>
---
 arch/arm/Kconfig                    |    2 ++
 arch/arm/mach-mmp/include/mach/io.h |   21 ---------------------
 arch/arm/mach-pxa/include/mach/io.h |   18 ------------------
 3 files changed, 2 insertions(+), 39 deletions(-)
 delete mode 100644 arch/arm/mach-mmp/include/mach/io.h
 delete mode 100644 arch/arm/mach-pxa/include/mach/io.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 46c00a1..f2da68a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -517,6 +517,7 @@ config ARCH_MMP
 	select GENERIC_CLOCKEVENTS
 	select TICK_ONESHOT
 	select PLAT_PXA
+	select USE_DEFAULT_IO_H
 	help
 	  Support for Marvell's PXA168/PXA910(MMP) and MMP2 processor line.
 
@@ -582,6 +583,7 @@ config ARCH_PXA
 	select GENERIC_CLOCKEVENTS
 	select TICK_ONESHOT
 	select PLAT_PXA
+	select USE_DEFAULT_IO_H
 	help
 	  Support for Intel/Marvell's PXA2xx/PXA3xx processor line.
 
diff --git a/arch/arm/mach-mmp/include/mach/io.h b/arch/arm/mach-mmp/include/mach/io.h
deleted file mode 100644
index e7adf3d..0000000
--- a/arch/arm/mach-mmp/include/mach/io.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * linux/arch/arm/mach-mmp/include/mach/io.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ASM_MACH_IO_H
-#define __ASM_MACH_IO_H
-
-#define IO_SPACE_LIMIT 0xffffffff
-
-/*
- * We don't actually have real ISA nor PCI buses, but there is so many
- * drivers out there that might just work if we fake them...
- */
-#define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
-#endif /* __ASM_MACH_IO_H */
diff --git a/arch/arm/mach-pxa/include/mach/io.h b/arch/arm/mach-pxa/include/mach/io.h
deleted file mode 100644
index 262691f..0000000
--- a/arch/arm/mach-pxa/include/mach/io.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * arch/arm/mach-pxa/include/mach/io.h
- *
- * Copied from asm/arch/sa1100/io.h
- */
-#ifndef __ASM_ARM_ARCH_IO_H
-#define __ASM_ARM_ARCH_IO_H
-
-#define IO_SPACE_LIMIT 0xffffffff
-
-/*
- * We don't actually have real ISA nor PCI buses, but there is so many
- * drivers out there that might just work if we fake them...
- */
-#define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
-#endif
-- 
1.7.1
