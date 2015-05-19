From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 19 May 2015 11:20:27 +0100
Subject: [PATCH 2/2] ARM: allow Integrator to be selected for noMMU builds
In-Reply-To: <20150519101939.GB2067@n2100.arm.linux.org.uk>
References: <20150519101939.GB2067@n2100.arm.linux.org.uk>
Message-ID: <E1YuedP-0003tv-IF@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow Integrator to be selected from the top level choice table again
for noMMU builds.  The Integrator platform can have ARM940 and ARM946
CPU tiles attached, which are MPU-based CPUs, and the recent conversion
of Integrator overlooked these.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig                 | 4 ++++
 arch/arm/mach-integrator/Kconfig | 3 +--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ef25d453da94..398d19106d99 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -329,6 +329,10 @@ config ARCH_MULTIPLATFORM
 	select SPARSE_IRQ
 	select USE_OF
 
+config ARM_SINGLE_INTEGRATOR
+	bool "ARM Ltd. Integrator family (noMMU)"
+	depends on !MMU
+
 config ARCH_REALVIEW
 	bool "ARM Ltd. RealView family"
 	select ARCH_WANT_OPTIONAL_GPIOLIB
diff --git a/arch/arm/mach-integrator/Kconfig b/arch/arm/mach-integrator/Kconfig
index 02d083489a26..c86f156ac21a 100644
--- a/arch/arm/mach-integrator/Kconfig
+++ b/arch/arm/mach-integrator/Kconfig
@@ -1,8 +1,7 @@
 config ARCH_INTEGRATOR
 	bool "ARM Ltd. Integrator family" if (ARCH_MULTI_V4T || ARCH_MULTI_V5 || ARCH_MULTI_V6)
+	default y if ARM_SINGLE_INTEGRATOR
 	select ARM_AMBA
-	select ARM_PATCH_PHYS_VIRT if MMU
-	select AUTO_ZRELADDR
 	select COMMON_CLK
 	select COMMON_CLK_VERSATILE
 	select GENERIC_CLOCKEVENTS
-- 
2.1.0
