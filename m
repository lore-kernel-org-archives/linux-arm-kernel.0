From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 23:30:08 -0400
Subject: [PATCH 24/37] ARM: spear: remove mach/memory.h and plat/memory.h
In-Reply-To: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309923021-23487-24-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/Kconfig                             |    1 +
 arch/arm/mach-spear3xx/include/mach/memory.h |   19 -------------------
 arch/arm/mach-spear6xx/include/mach/memory.h |   19 -------------------
 arch/arm/plat-spear/include/plat/memory.h    |   20 --------------------
 4 files changed, 1 insertions(+), 58 deletions(-)
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/memory.h
 delete mode 100644 arch/arm/mach-spear6xx/include/mach/memory.h
 delete mode 100644 arch/arm/plat-spear/include/plat/memory.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 44e8fdd..755a85d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -899,6 +899,7 @@ config PLAT_SPEAR
 	select CLKSRC_MMIO
 	select GENERIC_CLOCKEVENTS
 	select HAVE_CLK
+	select NO_MACH_MEMORY_H
 	help
 	  Support for ST's SPEAr platform (SPEAr3xx, SPEAr6xx and SPEAr13xx).
 
diff --git a/arch/arm/mach-spear3xx/include/mach/memory.h b/arch/arm/mach-spear3xx/include/mach/memory.h
deleted file mode 100644
index 5173522..0000000
--- a/arch/arm/mach-spear3xx/include/mach/memory.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * arch/arm/mach-spear3xx/include/mach/memory.h
- *
- * Memory map for SPEAr3xx machine family
- *
- * Copyright (C) 2009 ST Microelectronics
- * Viresh Kumar<viresh.kumar@st.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __MACH_MEMORY_H
-#define __MACH_MEMORY_H
-
-#include <plat/memory.h>
-
-#endif /* __MACH_MEMORY_H */
diff --git a/arch/arm/mach-spear6xx/include/mach/memory.h b/arch/arm/mach-spear6xx/include/mach/memory.h
deleted file mode 100644
index 781f088..0000000
--- a/arch/arm/mach-spear6xx/include/mach/memory.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * arch/arm/mach-spear6xx/include/mach/memory.h
- *
- * Memory map for SPEAr6xx machine family
- *
- * Copyright (C) 2009 ST Microelectronics
- * Rajeev Kumar<rajeev-dlh.kumar@st.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __MACH_MEMORY_H
-#define __MACH_MEMORY_H
-
-#include <plat/memory.h>
-
-#endif	/* __MACH_MEMORY_H */
diff --git a/arch/arm/plat-spear/include/plat/memory.h b/arch/arm/plat-spear/include/plat/memory.h
deleted file mode 100644
index 7e3599e..0000000
--- a/arch/arm/plat-spear/include/plat/memory.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- * arch/arm/plat-spear/include/plat/memory.h
- *
- * Memory map for SPEAr platform
- *
- * Copyright (C) 2009 ST Microelectronics
- * Viresh Kumar<viresh.kumar@st.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __PLAT_MEMORY_H
-#define __PLAT_MEMORY_H
-
-/* Physical DRAM offset */
-#define PLAT_PHYS_OFFSET		UL(0x00000000)
-
-#endif /* __PLAT_MEMORY_H */
-- 
1.7.4
