From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 23:29:55 -0400
Subject: [PATCH 11/37] ARM: mach-s3c2410: remove memory.h
In-Reply-To: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309923021-23487-11-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This also removes the mach/s3c2400 version which was probably never used
due to the fact that we have this line in arch/arm/Makefile:

machine-$(CONFIG_ARCH_S3C2410)          := s3c2410 s3c2400 [...]

This is later used to construct the search path for:

The compiler would be looking into mach-s3c2410 and picking up this
version first.  Any config that was actually expecting the mach-s3c2400
version was therefore producing a broken kernel binary.  Not relying on
any of them anymore would fix that issue.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/Kconfig                            |    1 +
 arch/arm/mach-s3c2400/include/mach/memory.h |   20 --------------------
 arch/arm/mach-s3c2410/include/mach/memory.h |   16 ----------------
 3 files changed, 1 insertions(+), 36 deletions(-)
 delete mode 100644 arch/arm/mach-s3c2400/include/mach/memory.h
 delete mode 100644 arch/arm/mach-s3c2410/include/mach/memory.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 48b2e88..869c7b6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -704,6 +704,7 @@ config ARCH_S3C2410
 	select HAVE_CLK
 	select ARCH_USES_GETTIMEOFFSET
 	select HAVE_S3C2410_I2C if I2C
+	select NO_MACH_MEMORY_H
 	help
 	  Samsung S3C2410X CPU based systems, such as the Simtec Electronics
 	  BAST (<http://www.simtec.co.uk/products/EB110ITX/>), the IPAQ 1940 or
diff --git a/arch/arm/mach-s3c2400/include/mach/memory.h b/arch/arm/mach-s3c2400/include/mach/memory.h
deleted file mode 100644
index 3f33670..0000000
--- a/arch/arm/mach-s3c2400/include/mach/memory.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* arch/arm/mach-s3c2400/include/mach/memory.h
- *  from arch/arm/mach-rpc/include/mach/memory.h
- *
- *  Copyright 2007 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- *  Copyright (C) 1996,1997,1998 Russell King.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_MEMORY_H
-#define __ASM_ARCH_MEMORY_H
-
-#define PLAT_PHYS_OFFSET	UL(0x0C000000)
-
-#endif
diff --git a/arch/arm/mach-s3c2410/include/mach/memory.h b/arch/arm/mach-s3c2410/include/mach/memory.h
deleted file mode 100644
index f92b97b..0000000
--- a/arch/arm/mach-s3c2410/include/mach/memory.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* arch/arm/mach-s3c2410/include/mach/memory.h
- *  from arch/arm/mach-rpc/include/mach/memory.h
- *
- *  Copyright (C) 1996,1997,1998 Russell King.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_MEMORY_H
-#define __ASM_ARCH_MEMORY_H
-
-#define PLAT_PHYS_OFFSET	UL(0x30000000)
-
-#endif
-- 
1.7.4
