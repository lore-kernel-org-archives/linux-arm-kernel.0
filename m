From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 14 Jan 2010 12:29:20 +0100
Subject: [PATCH 02/21] ARM: S5PC100: use 0x30008000 as memory base
In-Reply-To: <1263468579-5732-1-git-send-email-m.szyprowski@samsung.com>
References: <1263468579-5732-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1263468579-5732-3-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

We decided to use 0x3000'0000 as base memory address on S5PC1XX SoCs
(s5pc100 and s5pc110).
A patch to u-boot that configures SMDKC100 board and sets base memory
as 0x3000'0000 has been already posted.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-s5pc100/Makefile.boot         |    4 ++--
 arch/arm/mach-s5pc100/include/mach/map.h    |    2 +-
 arch/arm/mach-s5pc100/include/mach/memory.h |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-s5pc100/Makefile.boot b/arch/arm/mach-s5pc100/Makefile.boot
index ff90aa1..b0909e3 100644
--- a/arch/arm/mach-s5pc100/Makefile.boot
+++ b/arch/arm/mach-s5pc100/Makefile.boot
@@ -1,2 +1,2 @@
-   zreladdr-y	:= 0x20008000
-params_phys-y	:= 0x20000100
+   zreladdr-y	:= 0x30008000
+params_phys-y	:= 0x30000100
diff --git a/arch/arm/mach-s5pc100/include/mach/map.h b/arch/arm/mach-s5pc100/include/mach/map.h
index 4681ebe..f90c033 100644
--- a/arch/arm/mach-s5pc100/include/mach/map.h
+++ b/arch/arm/mach-s5pc100/include/mach/map.h
@@ -113,7 +113,7 @@
 #define S5PC100_PA_TSADC	(0xF3000000)
 
 /* ETC */
-#define S5PC100_PA_SDRAM	(0x20000000)
+#define S5PC100_PA_SDRAM	(0x30000000)
 #define S5PC1XX_PA_SDRAM	S5PC100_PA_SDRAM
 
 /* compatibility defines. */
diff --git a/arch/arm/mach-s5pc100/include/mach/memory.h b/arch/arm/mach-s5pc100/include/mach/memory.h
index 4b60d18..21cc182 100644
--- a/arch/arm/mach-s5pc100/include/mach/memory.h
+++ b/arch/arm/mach-s5pc100/include/mach/memory.h
@@ -13,6 +13,6 @@
 #ifndef __ASM_ARCH_MEMORY_H
 #define __ASM_ARCH_MEMORY_H
 
-#define PHYS_OFFSET     	UL(0x20000000)
+#define PHYS_OFFSET     	UL(0x30000000)
 
 #endif
-- 
1.6.4
