From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 27 Nov 2015 10:55:47 +0900
Subject: [PATCH 2/3] ARM: shmobile: Introduce ARCH_RENESAS
In-Reply-To: <cover.1448585673.git.horms+renesas@verge.net.au>
References: <cover.1448585673.git.horms+renesas@verge.net.au>
Message-ID: <9b5ba0df4ea4f94072f3e0d6064ab59607112e53.1448585673.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The purpose of this patch is to start the process of replacing both
ARCH_SHMOBILE and ARCH_SHMOBILE_MULTI with ARCH_RENESAS.

RENESAS seems to be a more appropriate name than SHMOBILE for the majority
of Renesas 32-bit ARM based SoCs. The name is conveniently also (newer)
ARM64 based SoCs.

This patches only addresses 32-bit ARM based SoCs.  Proposed support for
the ARM64 based r8a7795 SoC already uses ARCH_RENESAS which selects
ARCH_SHMOBILE.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/multi_v7_defconfig |  2 +-
 arch/arm/configs/shmobile_defconfig |  2 +-
 arch/arm/mach-shmobile/Kconfig      | 10 +++++++---
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 69a22fdb52a5..2735bc73b285 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -75,7 +75,7 @@ CONFIG_MACH_SPEAR1340=y
 CONFIG_ARCH_STI=y
 CONFIG_ARCH_EXYNOS=y
 CONFIG_EXYNOS5420_MCPM=y
-CONFIG_ARCH_SHMOBILE_MULTI=y
+CONFIG_ARCH_RENESAS=y
 CONFIG_ARCH_EMEV2=y
 CONFIG_ARCH_R7S72100=y
 CONFIG_ARCH_R8A73A4=y
diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 3aef019c0de7..cc8ece33a7e3 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -9,7 +9,7 @@ CONFIG_SYSCTL_SYSCALL=y
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 CONFIG_SLAB=y
-CONFIG_ARCH_SHMOBILE_MULTI=y
+CONFIG_ARCH_RENESAS=y
 CONFIG_ARCH_EMEV2=y
 CONFIG_ARCH_R7S72100=y
 CONFIG_ARCH_R8A73A4=y
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 88734a5e10ca..4ed72b124235 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -1,6 +1,8 @@
 config ARCH_SHMOBILE
 	bool
-	select ZONE_DMA if ARM_LPAE
+
+config ARCH_SHMOBILE_MULTI
+	bool
 
 config PM_RCAR
 	bool
@@ -29,10 +31,11 @@ config ARCH_RMOBILE
 	select SYS_SUPPORTS_SH_CMT
 	select SYS_SUPPORTS_SH_TMU
 
-menuconfig ARCH_SHMOBILE_MULTI
+menuconfig ARCH_RENESAS
 	bool "Renesas ARM SoCs" if ARCH_MULTI_V7
 	depends on MMU
 	select ARCH_SHMOBILE
+	select ARCH_SHMOBILE_MULTI
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select ARM_GIC
@@ -40,8 +43,9 @@ menuconfig ARCH_SHMOBILE_MULTI
 	select NO_IOPORT_MAP
 	select PINCTRL
 	select ARCH_REQUIRE_GPIOLIB
+	select ZONE_DMA if ARM_LPAE
 
-if ARCH_SHMOBILE_MULTI
+if ARCH_RENESAS
 
 #comment "Renesas ARM SoCs System Type"
 
-- 
2.1.4
