From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 22 Jan 2011 18:30:38 +0000
Subject: [PATCH] Realview: name configuration options after actual board names
Message-ID: <20110122183038.GA11960@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As no one seems to really know which configuration options tie up with
which boards, I thought I'd do some investigation and try to work it
out.  After discussion with some folk in linaro, I think I have this
nailed.

The names are updated to use the name on the front of the appropriate
board user guide for the various baseboards, which I've taken to be
the official name for each board.

I haven't significantly updated the descriptions for the tiles as that
is even less clear - as far as I can see on ARMs website, there is no
Cortex-A9 tile for Realview EB - only ARM11MPCore, ARM1156T2F-S,
ARM1176TZF-S and Cortex-R4F.  So exactly what this 'Multicore Cortex-A9
Tile' is...

diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index e219459..b9a9805 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -2,53 +2,57 @@ menu "RealView platform type"
 	depends on ARCH_REALVIEW
 
 config MACH_REALVIEW_EB
-	bool "Support RealView/EB platform"
+	bool "Support RealView(R) Emulation Baseboard"
 	select ARM_GIC
 	help
-	  Include support for the ARM(R) RealView Emulation Baseboard platform.
+	  Include support for the ARM(R) RealView(R) Emulation Baseboard
+	  platform.
 
 config REALVIEW_EB_A9MP
-	bool "Support Multicore Cortex-A9"
+	bool "Support Multicore Cortex-A9 Tile"
 	depends on MACH_REALVIEW_EB
 	select CPU_V7
 	help
-	  Enable support for the Cortex-A9MPCore tile on the Realview platform.
+	  Enable support for the Cortex-A9MPCore tile fitted to the
+	  Realview(R) Emulation Baseboard platform.
 
 config REALVIEW_EB_ARM11MP
-	bool "Support ARM11MPCore tile"
+	bool "Support ARM11MPCore Tile"
 	depends on MACH_REALVIEW_EB
 	select CPU_V6K
 	select ARCH_HAS_BARRIERS if SMP
 	help
-	  Enable support for the ARM11MPCore tile on the Realview platform.
+	  Enable support for the ARM11MPCore tile fitted to the Realview(R)
+	  Emulation Baseboard platform.
 
 config REALVIEW_EB_ARM11MP_REVB
-	bool "Support ARM11MPCore RevB tile"
+	bool "Support ARM11MPCore RevB Tile"
 	depends on REALVIEW_EB_ARM11MP
 	help
-	  Enable support for the ARM11MPCore RevB tile on the Realview
-	  platform. Since there are device address differences, a
-	  kernel built with this option enabled is not compatible with
-	  other revisions of the ARM11MPCore tile.
+	  Enable support for the ARM11MPCore Revision B tile on the
+	  Realview(R) Emulation Baseboard platform. Since there are device
+	  address differences, a kernel built with this option enabled is
+	  not compatible with other revisions of the ARM11MPCore tile.
 
 config MACH_REALVIEW_PB11MP
-	bool "Support RealView/PB11MPCore platform"
+	bool "Support RealView(R) Platform Baseboard for ARM11MPCore"
 	select CPU_V6K
 	select ARM_GIC
 	select HAVE_PATA_PLATFORM
 	select ARCH_HAS_BARRIERS if SMP
 	help
-	  Include support for the ARM(R) RealView MPCore Platform Baseboard.
-	  PB11MPCore is a platform with an on-board ARM11MPCore and has
+	  Include support for the ARM(R) RealView(R) Platform Baseboard for
+	  the ARM11MPCore.  This platform has an on-board ARM11MPCore and has
 	  support for PCI-E and Compact Flash.
 
 # ARMv6 CPU without K extensions, but does have the new exclusive ops
 config MACH_REALVIEW_PB1176
-	bool "Support RealView/PB1176 platform"
+	bool "Support RealView(R) Platform Baseboard for ARM1176JZF-S"
 	select CPU_V6
 	select ARM_GIC
 	help
-	  Include support for the ARM(R) RealView ARM1176 Platform Baseboard.
+	  Include support for the ARM(R) RealView(R) Platform Baseboard for
+	  ARM1176JZF-S.
 
 config REALVIEW_PB1176_SECURE_FLASH
 	bool "Allow access to the secure flash memory block"
@@ -60,23 +64,24 @@ config REALVIEW_PB1176_SECURE_FLASH
 	  block (64MB @ 0x3c000000) is required.
 
 config MACH_REALVIEW_PBA8
-	bool "Support RealView/PB-A8 platform"
+	bool "Support RealView(R) Platform Baseboard for Cortex(tm)-A8 platform"
 	select CPU_V7
 	select ARM_GIC
 	select HAVE_PATA_PLATFORM
 	help
-	  Include support for the ARM(R) RealView Cortex-A8 Platform Baseboard.
-	  PB-A8 is a platform with an on-board Cortex-A8 and has support for
-	  PCI-E and Compact Flash.
+	  Include support for the ARM(R) RealView Platform Baseboard for
+	  Cortex(tm)-A8.  This platform has an on-board Cortex-A8 and has
+	  support for PCI-E and Compact Flash.
 
 config MACH_REALVIEW_PBX
-	bool "Support RealView/PBX platform"
+	bool "Support RealView(R) Platform Baseboard Explore"
 	select ARM_GIC
 	select HAVE_PATA_PLATFORM
 	select ARCH_SPARSEMEM_ENABLE if CPU_V7 && !REALVIEW_HIGH_PHYS_OFFSET
 	select ZONE_DMA if SPARSEMEM
 	help
-	  Include support for the ARM(R) RealView PBX platform.
+	  Include support for the ARM(R) RealView(R) Platform Baseboard
+	  Explore.
 
 config REALVIEW_HIGH_PHYS_OFFSET
 	bool "High physical base address for the RealView platform"
