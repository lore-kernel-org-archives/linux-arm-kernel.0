From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Wed, 2 Jun 2010 16:50:27 +0400
Subject: [PATCH] ARM: Small cleanup for 'config PCI'
Message-ID: <20100602125027.GA28977@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simply introduce ARCH_HAS_PCI to avoid the very long 'if' condition
for PCI Kconfig symbol.

Suggested-by: Ben Dooks <ben@simtec.co.uk>
Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---

Note that this is on top of the cns3xxx pull request.

 arch/arm/Kconfig                 |   11 ++++++++++-
 arch/arm/mach-integrator/Kconfig |    1 +
 arch/arm/mach-pxa/Kconfig        |    1 +
 arch/arm/mach-versatile/Kconfig  |    1 +
 4 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fab2ddd..63cb0a2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -301,6 +301,7 @@ config ARCH_CNS3XXX
 	select CPU_V6
 	select GENERIC_CLOCKEVENTS
 	select ARM_GIC
+	select ARCH_HAS_PCI
 	select PCI_DOMAINS if PCI
 	help
 	  Support for Cavium Networks CNS3XXX platform.
@@ -436,6 +437,7 @@ config ARCH_IXP4XX
 	select CPU_XSCALE
 	select GENERIC_GPIO
 	select GENERIC_CLOCKEVENTS
+	select ARCH_HAS_PCI
 	select DMABOUNCE if PCI
 	help
 	  Support for Intel's IXP4XX (XScale) family of processors.
@@ -523,6 +525,7 @@ config ARCH_KS8695
 	select CPU_ARM922T
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_USES_GETTIMEOFFSET
+	select ARCH_HAS_PCI
 	help
 	  Support for Micrel/Kendin KS8695 "Centaur" (ARM922T) based
 	  System-on-Chip devices.
@@ -1059,8 +1062,14 @@ config ISA_DMA
 config ISA_DMA_API
 	bool
 
+config ARCH_HAS_PCI
+	bool
+	help
+	  Architectures should select this option if they want to give
+	  user a choice to enable PCI support.
+
 config PCI
-	bool "PCI support" if ARCH_INTEGRATOR_AP || ARCH_VERSATILE_PB || ARCH_IXP4XX || ARCH_KS8695 || MACH_ARMCORE || ARCH_CNS3XXX
+	bool "PCI support" if ARCH_HAS_PCI
 	help
 	  Find out whether you have a PCI motherboard. PCI is the name of a
 	  bus system, i.e. the way the CPU talks to the other stuff inside
diff --git a/arch/arm/mach-integrator/Kconfig b/arch/arm/mach-integrator/Kconfig
index 27db275..6116308 100644
--- a/arch/arm/mach-integrator/Kconfig
+++ b/arch/arm/mach-integrator/Kconfig
@@ -4,6 +4,7 @@ menu "Integrator Options"
 
 config ARCH_INTEGRATOR_AP
 	bool "Support Integrator/AP and Integrator/PP2 platforms"
+	select ARCH_HAS_PCI
 	help
 	  Include support for the ARM(R) Integrator/AP and
 	  Integrator/PP2 platforms.
diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 3b51741..67907f0 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -96,6 +96,7 @@ config MACH_ARMCORE
 	select PXA27x
 	select IWMMXT
 	select PXA25x
+	select ARCH_HAS_PCI
 
 config MACH_EM_X270
 	bool "CompuLab EM-x270 platform"
diff --git a/arch/arm/mach-versatile/Kconfig b/arch/arm/mach-versatile/Kconfig
index c781f30..2dd4c12 100644
--- a/arch/arm/mach-versatile/Kconfig
+++ b/arch/arm/mach-versatile/Kconfig
@@ -4,6 +4,7 @@ menu "Versatile platform type"
 config ARCH_VERSATILE_PB
 	bool "Support Versatile/PB platform"
 	select CPU_ARM926T
+	select ARCH_HAS_PCI
 	default y
 	help
 	  Include support for the ARM(R) Versatile/PB platform.
-- 
1.7.0.5
