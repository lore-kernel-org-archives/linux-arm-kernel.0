From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 5 Dec 2010 14:54:40 +0000
Subject: [PATCH] Ensure experimental options are so marked
Message-ID: <20101205145440.GG9138@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is kernel-wide policy that options depending on EXPERIMENTAL should
also have '(EXPERIMENTAL)' in their option text, and options with
'(EXPERIMENTAL)' depend on EXPERIMENTAL.

Ensure that all ARM options comply with this.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig              |    7 ++++---
 arch/arm/Kconfig.debug        |    2 +-
 arch/arm/mach-s3c2412/Kconfig |    2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4b67d03..c2ce10b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1319,7 +1319,7 @@ config HZ
 	default 100
 
 config THUMB2_KERNEL
-	bool "Compile the kernel in Thumb-2 mode"
+	bool "Compile the kernel in Thumb-2 mode (EXPERIMENTAL)"
 	depends on CPU_V7 && EXPERIMENTAL
 	select AEABI
 	select ARM_ASM_UNIFIED
@@ -1533,6 +1533,7 @@ config SECCOMP
 
 config CC_STACKPROTECTOR
 	bool "Enable -fstack-protector buffer overflow detection (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
 	help
 	  This option turns on the -fstack-protector GCC feature. This
 	  feature puts, at the beginning of functions, a canary value on
@@ -1729,7 +1730,7 @@ config CPU_FREQ_S3C
 	  Internal configuration node for common cpufreq on Samsung SoC
 
 config CPU_FREQ_S3C24XX
-	bool "CPUfreq driver for Samsung S3C24XX series CPUs"
+	bool "CPUfreq driver for Samsung S3C24XX series CPUs (EXPERIMENTAL)"
 	depends on ARCH_S3C2410 && CPU_FREQ && EXPERIMENTAL
 	select CPU_FREQ_S3C
 	help
@@ -1741,7 +1742,7 @@ config CPU_FREQ_S3C24XX
 	  If in doubt, say N.
 
 config CPU_FREQ_S3C24XX_PLL
-	bool "Support CPUfreq changing of PLL frequency"
+	bool "Support CPUfreq changing of PLL frequency (EXPERIMENTAL)"
 	depends on CPU_FREQ_S3C24XX && EXPERIMENTAL
 	help
 	  Compile in support for changing the PLL frequency from the
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index eac6208..494224a 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -31,7 +31,7 @@ config FRAME_POINTER
 	  reported is severely limited.
 
 config ARM_UNWIND
-	bool "Enable stack unwinding support"
+	bool "Enable stack unwinding support (EXPERIMENTAL)"
 	depends on AEABI && EXPERIMENTAL
 	default y
 	help
diff --git a/arch/arm/mach-s3c2412/Kconfig b/arch/arm/mach-s3c2412/Kconfig
index cef6a65..e824a85 100644
--- a/arch/arm/mach-s3c2412/Kconfig
+++ b/arch/arm/mach-s3c2412/Kconfig
@@ -52,7 +52,7 @@ config MACH_JIVE
 	  Say Y here if you are using the Logitech Jive.
 
 config MACH_JIVE_SHOW_BOOTLOADER
-	bool "Allow access to bootloader partitions in MTD"
+	bool "Allow access to bootloader partitions in MTD (EXPERIMENTAL)"
 	depends on MACH_JIVE && EXPERIMENTAL
 
 config MACH_SMDK2413
