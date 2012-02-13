From: robherring2@gmail.com (Rob Herring)
Date: Mon, 13 Feb 2012 15:43:26 -0600
Subject: [PATCH 13/15] ARM: make mach/io.h include optional
In-Reply-To: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
Message-ID: <1329169408-17253-14-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Add a kconfig option NEED_MACH_IO_H to conditionally include mach/io.h.

Basing this on CONFIG_PCI and CONFIG_ISA doesn't quite work. Most ISA
platforms don't need mach/io.h, but ebsa110 does. Most PCI platforms need
mach/io.h for now, but ks8695 doesn't which means it's broken? omap has a
lot of other stuff in its io.h, so it also needs io.h until it is cleaned
up.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/Kconfig          |   21 +++++++++++++++++++++
 arch/arm/include/asm/io.h |    5 +++++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a48aecc..fce05b8 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -186,6 +186,9 @@ config GENERIC_ISA_DMA
 config FIQ
 	bool
 
+config NEED_MACH_IO_H
+	bool
+
 config ARCH_MTD_XIP
 	bool
 
@@ -265,6 +268,7 @@ config ARCH_INTEGRATOR
 	select GENERIC_CLOCKEVENTS
 	select PLAT_VERSATILE
 	select PLAT_VERSATILE_FPGA_IRQ
+	select NEED_MACH_IO_H
 	select NEED_MACH_MEMORY_H
 	help
 	  Support for ARM's Integrator platform.
@@ -400,6 +404,7 @@ config ARCH_EBSA110
 	select ISA
 	select NO_IOPORT
 	select ARCH_USES_GETTIMEOFFSET
+	select NEED_MACH_IO_H
 	select NEED_MACH_MEMORY_H
 	help
 	  This is an evaluation board for the StrongARM processor available
@@ -426,6 +431,7 @@ config ARCH_FOOTBRIDGE
 	select FOOTBRIDGE
 	select GENERIC_CLOCKEVENTS
 	select HAVE_IDE
+	select NEED_MACH_IO_H
 	select NEED_MACH_MEMORY_H
 	help
 	  Support for systems based on the DC21285 companion chip
@@ -478,6 +484,7 @@ config ARCH_IOP13XX
 	select PCI
 	select ARCH_SUPPORTS_MSI
 	select VMSPLIT_1G
+	select NEED_MACH_IO_H
 	select NEED_MACH_MEMORY_H
 	help
 	  Support for Intel's IOP13XX (XScale) family of processors.
@@ -486,6 +493,7 @@ config ARCH_IOP32X
 	bool "IOP32x-based"
 	depends on MMU
 	select CPU_XSCALE
+	select NEED_MACH_IO_H
 	select PLAT_IOP
 	select PCI
 	select ARCH_REQUIRE_GPIOLIB
@@ -497,6 +505,7 @@ config ARCH_IOP33X
 	bool "IOP33x-based"
 	depends on MMU
 	select CPU_XSCALE
+	select NEED_MACH_IO_H
 	select PLAT_IOP
 	select PCI
 	select ARCH_REQUIRE_GPIOLIB
@@ -509,6 +518,7 @@ config ARCH_IXP23XX
 	select CPU_XSC3
  	select PCI
 	select ARCH_USES_GETTIMEOFFSET
+	select NEED_MACH_IO_H
 	select NEED_MACH_MEMORY_H
 	help
 	  Support for Intel's IXP23xx (XScale) family of processors.
@@ -519,6 +529,7 @@ config ARCH_IXP2000
 	select CPU_XSCALE
 	select PCI
 	select ARCH_USES_GETTIMEOFFSET
+	select NEED_MACH_IO_H
 	select NEED_MACH_MEMORY_H
 	help
 	  Support for Intel's IXP2400/2800 (XScale) family of processors.
@@ -532,6 +543,7 @@ config ARCH_IXP4XX
 	select GENERIC_CLOCKEVENTS
 	select HAVE_SCHED_CLOCK
 	select MIGHT_HAVE_PCI
+	select NEED_MACH_IO_H
 	select DMABOUNCE if PCI
 	help
 	  Support for Intel's IXP4XX (XScale) family of processors.
@@ -542,6 +554,7 @@ config ARCH_DOVE
 	select PCI
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_CLOCKEVENTS
+	select NEED_MACH_IO_H
 	select PLAT_ORION
 	help
 	  Support for the Marvell Dove SoC 88AP510
@@ -552,6 +565,7 @@ config ARCH_KIRKWOOD
 	select PCI
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_CLOCKEVENTS
+	select NEED_MACH_IO_H
 	select PLAT_ORION
 	help
 	  Support for the following Marvell Kirkwood series SoCs:
@@ -576,6 +590,7 @@ config ARCH_MV78XX0
 	select PCI
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_CLOCKEVENTS
+	select NEED_MACH_IO_H
 	select PLAT_ORION
 	help
 	  Support for the following Marvell MV78xx0 series SoCs:
@@ -645,6 +660,7 @@ config ARCH_TEGRA
 	select HAVE_SCHED_CLOCK
 	select HAVE_SMP
 	select MIGHT_HAVE_CACHE_L2X0
+	select NEED_MACH_IO_H if PCI
 	select ARCH_HAS_CPUFREQ
 	help
 	  This enables support for NVIDIA Tegra based systems (Tegra APX,
@@ -739,6 +755,7 @@ config ARCH_RPC
 	select ARCH_SPARSEMEM_ENABLE
 	select ARCH_USES_GETTIMEOFFSET
 	select HAVE_IDE
+	select NEED_MACH_IO_H
 	select NEED_MACH_MEMORY_H
 	help
 	  On the Acorn Risc-PC, Linux can support the internal IDE disk and
@@ -771,6 +788,7 @@ config ARCH_S3C2410
 	select CLKDEV_LOOKUP
 	select ARCH_USES_GETTIMEOFFSET
 	select HAVE_S3C2410_I2C if I2C
+	select NEED_MACH_IO_H
 	help
 	  Samsung S3C2410X CPU based systems, such as the Simtec Electronics
 	  BAST (<http://www.simtec.co.uk/products/EB110ITX/>), the IPAQ 1940 or
@@ -877,6 +895,7 @@ config ARCH_SHARK
 	select PCI
 	select ARCH_USES_GETTIMEOFFSET
 	select NEED_MACH_MEMORY_H
+	select NEED_MACH_IO_H
 	help
 	  Support for the StrongARM based Digital DNARD machine, also known
 	  as "Shark" (<http://www.shark-linux.de/shark.html>).
@@ -946,6 +965,7 @@ config ARCH_OMAP
 	select GENERIC_CLOCKEVENTS
 	select HAVE_SCHED_CLOCK
 	select ARCH_HAS_HOLES_MEMORYMODEL
+	select NEED_MACH_IO_H
 	help
 	  Support for TI's OMAP platform (OMAP1/2/3/4).
 
@@ -968,6 +988,7 @@ config ARCH_VT8500
 	select GENERIC_CLOCKEVENTS
 	select ARCH_REQUIRE_GPIOLIB
 	select HAVE_PWM
+	select NEED_MACH_IO_H
 	help
 	  Support for VIA/WonderMedia VT8500/WM85xx System-on-Chip.
 
diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index f5c6968..5e0ca53 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -109,7 +109,12 @@ static inline void __iomem *__typesafe_io(unsigned long addr)
 /*
  * Now, pick up the machine-defined IO definitions
  */
+#ifdef CONFIG_NEED_MACH_IO_H
 #include <mach/io.h>
+#else
+#define __io(a)		({ (void)(a); __typesafe_io(0); })
+#define __mem_pci(a)	(a)
+#endif
 
 /*
  * This is the limit of PC card/PCI/ISA IO space, which is by default
-- 
1.7.5.4
