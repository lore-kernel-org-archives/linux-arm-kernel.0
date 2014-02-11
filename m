From: robherring2@gmail.com (Rob Herring)
Date: Tue, 11 Feb 2014 15:11:53 -0600
Subject: [PATCH 3/9] ARM: select MIGHT_HAVE_CACHE_L2X0 for V7 multi-platform
In-Reply-To: <1392153119-23248-1-git-send-email-robherring2@gmail.com>
References: <1392153119-23248-1-git-send-email-robherring2@gmail.com>
Message-ID: <1392153119-23248-4-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

Many V7 platforms have an L2x0 cache, so make CONFIG_MIGHT_HAVE_CACHE_L2X0
visible for V7 multi-platform builds.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/Kconfig               | 1 +
 arch/arm/mach-cns3xxx/Kconfig  | 1 -
 arch/arm/mach-imx/Kconfig      | 1 -
 arch/arm/mach-prima2/Kconfig   | 1 -
 arch/arm/mach-shmobile/Kconfig | 1 -
 arch/arm/mach-spear/Kconfig    | 1 -
 arch/arm/mach-sti/Kconfig      | 1 -
 arch/arm/mach-tegra/Kconfig    | 1 -
 arch/arm/mach-ux500/Kconfig    | 1 -
 arch/arm/mach-vexpress/Kconfig | 1 -
 arch/arm/mach-zynq/Kconfig     | 1 -
 11 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a1f36e7..7560be4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -921,6 +921,7 @@ config ARCH_MULTI_V7
 
 config ARCH_MULTI_V6_V7
 	bool
+	select MIGHT_HAVE_CACHE_L2X0
 
 config ARCH_MULTI_CPU_AUTO
 	def_bool !(ARCH_MULTI_V4 || ARCH_MULTI_V4T || ARCH_MULTI_V6_V7)
diff --git a/arch/arm/mach-cns3xxx/Kconfig b/arch/arm/mach-cns3xxx/Kconfig
index e346688..c6f58a1 100644
--- a/arch/arm/mach-cns3xxx/Kconfig
+++ b/arch/arm/mach-cns3xxx/Kconfig
@@ -2,7 +2,6 @@ config ARCH_CNS3XXX
 	bool "Cavium Networks CNS3XXX family" if ARCH_MULTI_V6
 	select ARM_GIC
 	select CPU_V6K
-	select MIGHT_HAVE_CACHE_L2X0
 	select MIGHT_HAVE_PCI
 	select PCI_DOMAINS if PCI
 	help
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 1a6a843..ff24473 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -5,7 +5,6 @@ config ARCH_MXC
 	select CLKSRC_MMIO
 	select GENERIC_ALLOCATOR
 	select GENERIC_IRQ_CHIP
-	select MIGHT_HAVE_CACHE_L2X0 if ARCH_MULTI_V6_V7
 	select PINCTRL
 	select SOC_BUS
 	help
diff --git a/arch/arm/mach-prima2/Kconfig b/arch/arm/mach-prima2/Kconfig
index 59aa3ea..2c726b4 100644
--- a/arch/arm/mach-prima2/Kconfig
+++ b/arch/arm/mach-prima2/Kconfig
@@ -2,7 +2,6 @@ config ARCH_SIRF
 	bool "CSR SiRF" if ARCH_MULTI_V7
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_IRQ_CHIP
-	select MIGHT_HAVE_CACHE_L2X0
 	select NO_IOPORT
 	select PINCTRL
 	select PINCTRL_SIRF
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 99f181d..8a685ed 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -8,7 +8,6 @@ config ARCH_SHMOBILE_MULTI
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select ARM_GIC
-	select MIGHT_HAVE_CACHE_L2X0
 	select MIGHT_HAVE_PCI
 	select NO_IOPORT
 	select PINCTRL
diff --git a/arch/arm/mach-spear/Kconfig b/arch/arm/mach-spear/Kconfig
index 601b8d8..5c57262 100644
--- a/arch/arm/mach-spear/Kconfig
+++ b/arch/arm/mach-spear/Kconfig
@@ -19,7 +19,6 @@ config ARCH_SPEAR13XX
 	select GPIO_SPEAR_SPICS
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
-	select MIGHT_HAVE_CACHE_L2X0
 	select PINCTRL
 	help
 	  Supports for ARM's SPEAR13XX family
diff --git a/arch/arm/mach-sti/Kconfig b/arch/arm/mach-sti/Kconfig
index c3fdcee..d2c13ba 100644
--- a/arch/arm/mach-sti/Kconfig
+++ b/arch/arm/mach-sti/Kconfig
@@ -5,7 +5,6 @@ menuconfig ARCH_STI
 	select PINCTRL
 	select PINCTRL_ST
 	select MFD_SYSCON
-	select MIGHT_HAVE_CACHE_L2X0
 	select HAVE_ARM_SCU if SMP
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_ERRATA_754322
diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index e596739..f61cd5b 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -7,7 +7,6 @@ config ARCH_TEGRA
 	select CLKSRC_MMIO
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
-	select MIGHT_HAVE_CACHE_L2X0
 	select MIGHT_HAVE_PCI
 	select PINCTRL
 	select ARCH_HAS_RESET_CONTROLLER
diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 731b919..8052bd5 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -13,7 +13,6 @@ config ARCH_U8500
 	select CLKSRC_NOMADIK_MTU
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
-	select MIGHT_HAVE_CACHE_L2X0
 	select PINCTRL
 	select PINCTRL_ABX500
 	select PINCTRL_NOMADIK
diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 6cbddb8..80b4be3 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -10,7 +10,6 @@ config ARCH_VEXPRESS
 	select HAVE_ARM_TWD if SMP
 	select HAVE_PATA_PLATFORM
 	select ICST
-	select MIGHT_HAVE_CACHE_L2X0
 	select NO_IOPORT
 	select PLAT_VERSATILE
 	select PLAT_VERSATILE_CLCD
diff --git a/arch/arm/mach-zynq/Kconfig b/arch/arm/mach-zynq/Kconfig
index 70e247d..105d39b 100644
--- a/arch/arm/mach-zynq/Kconfig
+++ b/arch/arm/mach-zynq/Kconfig
@@ -5,7 +5,6 @@ config ARCH_ZYNQ
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select ICST
-	select MIGHT_HAVE_CACHE_L2X0
 	select CADENCE_TTC_TIMER
 	select ARM_GLOBAL_TIMER
 	help
-- 
1.8.3.2
