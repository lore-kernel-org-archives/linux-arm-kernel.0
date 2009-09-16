From: kyungmin.park@samsung.com (Kyungmin Park)
Date: Wed, 16 Sep 2009 14:45:39 +0900
Subject: [PATCH] [S5PC100] Use memory base as 0x30000000
Message-ID: <20090916054539.GA6242@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To work with next SoCs s5pc110, we decide to use 0x3000'0000 as base memory
address
Also we posted u-boot patch for the smdkc100 board,
It set the base memory as 0x3000'0000

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
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
index 9e9f391..4f82430 100644
--- a/arch/arm/mach-s5pc100/include/mach/map.h
+++ b/arch/arm/mach-s5pc100/include/mach/map.h
@@ -54,7 +54,7 @@
 #define S5PC100_PA_IIC		(0xEC100000)
 
 /* ETC */
-#define S5PC100_PA_SDRAM	(0x20000000)
+#define S5PC100_PA_SDRAM	(0x30000000)
 
 /* compatibility defines. */
 #define S3C_PA_UART		S5PC100_PA_UART
diff --git a/arch/arm/mach-s5pc100/include/mach/memory.h b/arch/arm/mach-s5pc100/include/mach/memory.h
index 4b60d18..3f54d30 100644
--- a/arch/arm/mach-s5pc100/include/mach/memory.h
+++ b/arch/arm/mach-s5pc100/include/mach/memory.h
@@ -13,6 +13,6 @@
 #ifndef __ASM_ARCH_MEMORY_H
 #define __ASM_ARCH_MEMORY_H
 
-#define PHYS_OFFSET     	UL(0x20000000)
+#define PHYS_OFFSET		UL(0x30000000)
 
 #endif
