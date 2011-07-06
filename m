From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 23:30:11 -0400
Subject: [PATCH 27/37] ARM: mach-cns3xxx: remove mach/memory.h
In-Reply-To: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309923021-23487-27-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/Kconfig                            |    1 +
 arch/arm/mach-cns3xxx/include/mach/memory.h |   26 --------------------------
 2 files changed, 1 insertions(+), 26 deletions(-)
 delete mode 100644 arch/arm/mach-cns3xxx/include/mach/memory.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a3577a2..ab78899 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -341,6 +341,7 @@ config ARCH_CNS3XXX
 	select ARM_GIC
 	select MIGHT_HAVE_PCI
 	select PCI_DOMAINS if PCI
+	select NO_MACH_MEMORY_H
 	help
 	  Support for Cavium Networks CNS3XXX platform.
 
diff --git a/arch/arm/mach-cns3xxx/include/mach/memory.h b/arch/arm/mach-cns3xxx/include/mach/memory.h
deleted file mode 100644
index dc16c5c..0000000
--- a/arch/arm/mach-cns3xxx/include/mach/memory.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * Copyright 2003 ARM Limited
- * Copyright 2008 Cavium Networks
- *
- * This file is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License, Version 2, as
- * published by the Free Software Foundation.
- */
-
-#ifndef __MACH_MEMORY_H
-#define __MACH_MEMORY_H
-
-/*
- * Physical DRAM offset.
- */
-#define PLAT_PHYS_OFFSET		UL(0x00000000)
-
-#define __phys_to_bus(x)	((x) + PHYS_OFFSET)
-#define __bus_to_phys(x)	((x) - PHYS_OFFSET)
-
-#define __virt_to_bus(v)	__phys_to_bus(__virt_to_phys(v))
-#define __bus_to_virt(b)	__phys_to_virt(__bus_to_phys(b))
-#define __pfn_to_bus(p)		__phys_to_bus(__pfn_to_phys(p))
-#define __bus_to_pfn(b)		__phys_to_pfn(__bus_to_phys(b))
-
-#endif
-- 
1.7.4
