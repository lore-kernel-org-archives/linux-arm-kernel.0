From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Thu, 09 Feb 2017 12:18:34 +0000
Subject: [PATCH 1/4] ARM: add CPU_THUMB_CAPABLE to indicate possible Thumb
 support
In-Reply-To: <20170209121756.GC27312@n2100.armlinux.org.uk>
References: <20170209121756.GC27312@n2100.armlinux.org.uk>
Message-ID: <E1cbngI-00025v-UE@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clean up arch/arm/mm/Kconfig a little to provide a symbol which
indicates whether the CPU may support the Thumb instruction set.  This
gets rid of the growing dependencies on ARM_THUMB, and also gives us a
useful Kconfig symbol for choosing the kuser code.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mm/Kconfig | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index f68e8ec29447..d6552ab45ed1 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -29,6 +29,7 @@ config CPU_ARM720T
 	select CPU_COPY_V4WT if MMU
 	select CPU_CP15_MMU
 	select CPU_PABRT_LEGACY
+	select CPU_THUMB_CAPABLE
 	select CPU_TLB_V4WT if MMU
 	help
 	  A 32-bit RISC processor with 8kByte Cache, Write Buffer and
@@ -46,6 +47,7 @@ config CPU_ARM740T
 	select CPU_CACHE_V4
 	select CPU_CP15_MPU
 	select CPU_PABRT_LEGACY
+	select CPU_THUMB_CAPABLE
 	help
 	  A 32-bit RISC processor with 8KB cache or 4KB variants,
 	  write buffer and MPU(Protection Unit) built around
@@ -79,6 +81,7 @@ config CPU_ARM920T
 	select CPU_COPY_V4WB if MMU
 	select CPU_CP15_MMU
 	select CPU_PABRT_LEGACY
+	select CPU_THUMB_CAPABLE
 	select CPU_TLB_V4WBI if MMU
 	help
 	  The ARM920T is licensed to be produced by numerous vendors,
@@ -97,6 +100,7 @@ config CPU_ARM922T
 	select CPU_COPY_V4WB if MMU
 	select CPU_CP15_MMU
 	select CPU_PABRT_LEGACY
+	select CPU_THUMB_CAPABLE
 	select CPU_TLB_V4WBI if MMU
 	help
 	  The ARM922T is a version of the ARM920T, but with smaller
@@ -116,6 +120,7 @@ config CPU_ARM925T
 	select CPU_COPY_V4WB if MMU
 	select CPU_CP15_MMU
 	select CPU_PABRT_LEGACY
+	select CPU_THUMB_CAPABLE
 	select CPU_TLB_V4WBI if MMU
  	help
  	  The ARM925T is a mix between the ARM920T and ARM926T, but with
@@ -134,6 +139,7 @@ config CPU_ARM926T
 	select CPU_COPY_V4WB if MMU
 	select CPU_CP15_MMU
 	select CPU_PABRT_LEGACY
+	select CPU_THUMB_CAPABLE
 	select CPU_TLB_V4WBI if MMU
 	help
 	  This is a variant of the ARM920.  It has slightly different
@@ -170,6 +176,7 @@ config CPU_ARM940T
 	select CPU_CACHE_VIVT
 	select CPU_CP15_MPU
 	select CPU_PABRT_LEGACY
+	select CPU_THUMB_CAPABLE
 	help
 	  ARM940T is a member of the ARM9TDMI family of general-
 	  purpose microprocessors with MPU and separate 4KB
@@ -188,6 +195,7 @@ config CPU_ARM946E
 	select CPU_CACHE_VIVT
 	select CPU_CP15_MPU
 	select CPU_PABRT_LEGACY
+	select CPU_THUMB_CAPABLE
 	help
 	  ARM946E-S is a member of the ARM9E-S family of high-
 	  performance, 32-bit system-on-chip processor solutions.
@@ -206,6 +214,7 @@ config CPU_ARM1020
 	select CPU_COPY_V4WB if MMU
 	select CPU_CP15_MMU
 	select CPU_PABRT_LEGACY
+	select CPU_THUMB_CAPABLE
 	select CPU_TLB_V4WBI if MMU
 	help
 	  The ARM1020 is the 32K cached version of the ARM10 processor,
@@ -225,6 +234,7 @@ config CPU_ARM1020E
 	select CPU_COPY_V4WB if MMU
 	select CPU_CP15_MMU
 	select CPU_PABRT_LEGACY
+	select CPU_THUMB_CAPABLE
 	select CPU_TLB_V4WBI if MMU
 
 # ARM1022E
@@ -236,6 +246,7 @@ config CPU_ARM1022
 	select CPU_COPY_V4WB if MMU # can probably do better
 	select CPU_CP15_MMU
 	select CPU_PABRT_LEGACY
+	select CPU_THUMB_CAPABLE
 	select CPU_TLB_V4WBI if MMU
 	help
 	  The ARM1022E is an implementation of the ARMv5TE architecture
@@ -254,6 +265,7 @@ config CPU_ARM1026
 	select CPU_COPY_V4WB if MMU # can probably do better
 	select CPU_CP15_MMU
 	select CPU_PABRT_LEGACY
+	select CPU_THUMB_CAPABLE
 	select CPU_TLB_V4WBI if MMU
 	help
 	  The ARM1026EJ-S is an implementation of the ARMv5TEJ architecture
@@ -302,6 +314,7 @@ config CPU_XSCALE
 	select CPU_CACHE_VIVT
 	select CPU_CP15_MMU
 	select CPU_PABRT_LEGACY
+	select CPU_THUMB_CAPABLE
 	select CPU_TLB_V4WBI if MMU
 
 # XScale Core Version 3
@@ -312,6 +325,7 @@ config CPU_XSC3
 	select CPU_CACHE_VIVT
 	select CPU_CP15_MMU
 	select CPU_PABRT_LEGACY
+	select CPU_THUMB_CAPABLE
 	select CPU_TLB_V4WBI if MMU
 	select IO_36
 
@@ -324,6 +338,7 @@ config CPU_MOHAWK
 	select CPU_COPY_V4WB if MMU
 	select CPU_CP15_MMU
 	select CPU_PABRT_LEGACY
+	select CPU_THUMB_CAPABLE
 	select CPU_TLB_V4WBI if MMU
 
 # Feroceon
@@ -335,6 +350,7 @@ config CPU_FEROCEON
 	select CPU_COPY_FEROCEON if MMU
 	select CPU_CP15_MMU
 	select CPU_PABRT_LEGACY
+	select CPU_THUMB_CAPABLE
 	select CPU_TLB_FEROCEON if MMU
 
 config CPU_FEROCEON_OLD_ID
@@ -367,6 +383,7 @@ config CPU_V6
 	select CPU_CP15_MMU
 	select CPU_HAS_ASID if MMU
 	select CPU_PABRT_V6
+	select CPU_THUMB_CAPABLE
 	select CPU_TLB_V6 if MMU
 
 # ARMv6k
@@ -381,6 +398,7 @@ config CPU_V6K
 	select CPU_CP15_MMU
 	select CPU_HAS_ASID if MMU
 	select CPU_PABRT_V6
+	select CPU_THUMB_CAPABLE
 	select CPU_TLB_V6 if MMU
 
 # ARMv7
@@ -396,6 +414,7 @@ config CPU_V7
 	select CPU_CP15_MPU if !MMU
 	select CPU_HAS_ASID if MMU
 	select CPU_PABRT_V7
+	select CPU_THUMB_CAPABLE
 	select CPU_TLB_V7 if MMU
 
 # ARMv7M
@@ -410,11 +429,17 @@ config CPU_V7M
 
 config CPU_THUMBONLY
 	bool
+	select CPU_THUMB_CAPABLE
 	# There are no CPUs available with MMU that don't implement an ARM ISA:
 	depends on !MMU
 	help
 	  Select this if your CPU doesn't support the 32 bit ARM instructions.
 
+config CPU_THUMB_CAPABLE
+	bool
+	help
+	  Selected this if your CPU can support Thumb mode
+
 # Figure out what processor architecture version we should be using.
 # This defines the compiler instruction set which depends on the machine type.
 config CPU_32v3
@@ -655,11 +680,7 @@ config ARCH_DMA_ADDR_T_64BIT
 
 config ARM_THUMB
 	bool "Support Thumb user binaries" if !CPU_THUMBONLY
-	depends on CPU_ARM720T || CPU_ARM740T || CPU_ARM920T || CPU_ARM922T || \
-		CPU_ARM925T || CPU_ARM926T || CPU_ARM940T || CPU_ARM946E || \
-		CPU_ARM1020 || CPU_ARM1020E || CPU_ARM1022 || CPU_ARM1026 || \
-		CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_V6 || CPU_V6K || \
-		CPU_V7 || CPU_FEROCEON || CPU_V7M
+	depends on CPU_THUMB_CAPABLE
 	default y
 	help
 	  Say Y if you want to include kernel support for running user space
-- 
2.7.4
