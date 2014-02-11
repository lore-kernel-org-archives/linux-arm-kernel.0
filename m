From: robherring2@gmail.com (Rob Herring)
Date: Tue, 11 Feb 2014 15:11:52 -0600
Subject: [PATCH 2/9] ARM: select HAVE_SMP for V7 multi-platform
In-Reply-To: <1392153119-23248-1-git-send-email-robherring2@gmail.com>
References: <1392153119-23248-1-git-send-email-robherring2@gmail.com>
Message-ID: <1392153119-23248-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

All V7 platforms can run SMP kernels, so make CONFIG_SMP visible for V7
multi-platform builds.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/Kconfig               | 1 +
 arch/arm/mach-berlin/Kconfig   | 1 -
 arch/arm/mach-highbank/Kconfig | 1 -
 arch/arm/mach-hisi/Kconfig     | 1 -
 arch/arm/mach-imx/Kconfig      | 1 -
 arch/arm/mach-keystone/Kconfig | 1 -
 arch/arm/mach-mvebu/Kconfig    | 1 -
 arch/arm/mach-omap2/Kconfig    | 2 --
 arch/arm/mach-prima2/Kconfig   | 1 -
 arch/arm/mach-rockchip/Kconfig | 1 -
 arch/arm/mach-shmobile/Kconfig | 1 -
 arch/arm/mach-socfpga/Kconfig  | 1 -
 arch/arm/mach-spear/Kconfig    | 1 -
 arch/arm/mach-sti/Kconfig      | 1 -
 arch/arm/mach-sunxi/Kconfig    | 1 -
 arch/arm/mach-tegra/Kconfig    | 1 -
 arch/arm/mach-ux500/Kconfig    | 1 -
 arch/arm/mach-vexpress/Kconfig | 1 -
 arch/arm/mach-zynq/Kconfig     | 1 -
 19 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 72d5571..a1f36e7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -917,6 +917,7 @@ config ARCH_MULTI_V7
 	default y
 	select ARCH_MULTI_V6_V7
 	select CPU_V7
+	select HAVE_SMP
 
 config ARCH_MULTI_V6_V7
 	bool
diff --git a/arch/arm/mach-berlin/Kconfig b/arch/arm/mach-berlin/Kconfig
index b346f59..b0cb072 100644
--- a/arch/arm/mach-berlin/Kconfig
+++ b/arch/arm/mach-berlin/Kconfig
@@ -14,7 +14,6 @@ config MACH_BERLIN_BG2
 	select CACHE_L2X0
 	select CPU_PJ4B
 	select HAVE_ARM_TWD if SMP
-	select HAVE_SMP
 
 config MACH_BERLIN_BG2CD
 	bool "Marvell Armada 1500-mini (BG2CD)"
diff --git a/arch/arm/mach-highbank/Kconfig b/arch/arm/mach-highbank/Kconfig
index 59274a7..830b76e 100644
--- a/arch/arm/mach-highbank/Kconfig
+++ b/arch/arm/mach-highbank/Kconfig
@@ -15,7 +15,6 @@ config ARCH_HIGHBANK
 	select CACHE_L2X0
 	select HAVE_ARM_SCU
 	select HAVE_ARM_TWD if SMP
-	select HAVE_SMP
 	select MAILBOX
 	select PL320_MBOX
 	select ZONE_DMA if ARM_LPAE
diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
index 95492d7..9d0a87b 100644
--- a/arch/arm/mach-hisi/Kconfig
+++ b/arch/arm/mach-hisi/Kconfig
@@ -6,7 +6,6 @@ config ARCH_HI3xxx
 	select CACHE_L2X0
 	select HAVE_ARM_SCU
 	select HAVE_ARM_TWD if SMP
-	select HAVE_SMP
 	select PINCTRL
 	select PINCTRL_SINGLE
 	help
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 3dd2c60..1a6a843 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -791,7 +791,6 @@ config SOC_IMX6Q
 	select HAVE_IMX_GPC
 	select HAVE_IMX_MMDC
 	select HAVE_IMX_SRC
-	select HAVE_SMP
 	select MFD_SYSCON
 	select MIGHT_HAVE_PCI
 	select PCI_DOMAINS if PCI
diff --git a/arch/arm/mach-keystone/Kconfig b/arch/arm/mach-keystone/Kconfig
index 00ed744..f50bc93 100644
--- a/arch/arm/mach-keystone/Kconfig
+++ b/arch/arm/mach-keystone/Kconfig
@@ -3,7 +3,6 @@ config ARCH_KEYSTONE
 	depends on ARCH_MULTI_V7
 	select ARM_GIC
 	select HAVE_ARM_ARCH_TIMER
-	select HAVE_SMP
 	select CLKSRC_MMIO
 	select ARM_ERRATA_798181 if SMP
 	select COMMON_CLK_KEYSTONE
diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index d581e84..875a352 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -19,7 +19,6 @@ menu "Marvell SOC with device tree"
 config MACH_ARMADA_370_XP
 	bool
 	select ARMADA_370_XP_TIMER
-	select HAVE_SMP
 	select CACHE_L2X0
 	select CPU_PJ4B
 
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index d4eb5e9..922cbd8 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -32,7 +32,6 @@ config ARCH_OMAP4
 	select CACHE_L2X0
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
-	select HAVE_SMP
 	select OMAP_INTERCONNECT
 	select PL310_ERRATA_588369
 	select PL310_ERRATA_727915
@@ -50,7 +49,6 @@ config SOC_OMAP5
 	select ARM_GIC
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
-	select HAVE_SMP
 	select HAVE_ARM_ARCH_TIMER
 	select ARM_ERRATA_798181 if SMP
 
diff --git a/arch/arm/mach-prima2/Kconfig b/arch/arm/mach-prima2/Kconfig
index 16c2d90..59aa3ea 100644
--- a/arch/arm/mach-prima2/Kconfig
+++ b/arch/arm/mach-prima2/Kconfig
@@ -33,7 +33,6 @@ config ARCH_MARCO
 	default y
 	select ARM_GIC
 	select HAVE_ARM_SCU if SMP
-	select HAVE_SMP
 	select SMP_ON_UP if SMP
 	help
           Support for CSR SiRFSoC ARM Cortex A9 Platform
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 2a695bc..6b2f586 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -6,7 +6,6 @@ config ARCH_ROCKCHIP
 	select ARM_GIC
 	select CACHE_L2X0
 	select HAVE_ARM_TWD if SMP
-	select HAVE_SMP
 	select DW_APB_TIMER_OF
 	select ARM_GLOBAL_TIMER
 	select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 6f24e9e..99f181d 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -7,7 +7,6 @@ config ARCH_SHMOBILE_MULTI
 	select ARCH_SHMOBILE
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
-	select HAVE_SMP
 	select ARM_GIC
 	select MIGHT_HAVE_CACHE_L2X0
 	select MIGHT_HAVE_PCI
diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index 2249137..b5f8d75 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -7,5 +7,4 @@ config ARCH_SOCFPGA
 	select GPIO_PL061 if GPIOLIB
 	select HAVE_ARM_SCU
 	select HAVE_ARM_TWD if SMP
-	select HAVE_SMP
 	select MFD_SYSCON
diff --git a/arch/arm/mach-spear/Kconfig b/arch/arm/mach-spear/Kconfig
index a7a28ea..601b8d8 100644
--- a/arch/arm/mach-spear/Kconfig
+++ b/arch/arm/mach-spear/Kconfig
@@ -19,7 +19,6 @@ config ARCH_SPEAR13XX
 	select GPIO_SPEAR_SPICS
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
-	select HAVE_SMP
 	select MIGHT_HAVE_CACHE_L2X0
 	select PINCTRL
 	help
diff --git a/arch/arm/mach-sti/Kconfig b/arch/arm/mach-sti/Kconfig
index 9c6dda8..c3fdcee 100644
--- a/arch/arm/mach-sti/Kconfig
+++ b/arch/arm/mach-sti/Kconfig
@@ -6,7 +6,6 @@ menuconfig ARCH_STI
 	select PINCTRL_ST
 	select MFD_SYSCON
 	select MIGHT_HAVE_CACHE_L2X0
-	select HAVE_SMP
 	select HAVE_ARM_SCU if SMP
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_ERRATA_754322
diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 201ef9b..9de27cf 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -6,7 +6,6 @@ config ARCH_SUNXI
 	select ARM_PSCI
 	select CLKSRC_MMIO
 	select GENERIC_IRQ_CHIP
-	select HAVE_SMP
 	select PINCTRL
 	select PINCTRL_SUNXI
 	select RESET_CONTROLLER
diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 5dc3e38..e596739 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -7,7 +7,6 @@ config ARCH_TEGRA
 	select CLKSRC_MMIO
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
-	select HAVE_SMP
 	select MIGHT_HAVE_CACHE_L2X0
 	select MIGHT_HAVE_PCI
 	select PINCTRL
diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 5d71c82..731b919 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -13,7 +13,6 @@ config ARCH_U8500
 	select CLKSRC_NOMADIK_MTU
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
-	select HAVE_SMP
 	select MIGHT_HAVE_CACHE_L2X0
 	select PINCTRL
 	select PINCTRL_ABX500
diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index fa29222..6cbddb8 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -9,7 +9,6 @@ config ARCH_VEXPRESS
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select HAVE_PATA_PLATFORM
-	select HAVE_SMP
 	select ICST
 	select MIGHT_HAVE_CACHE_L2X0
 	select NO_IOPORT
diff --git a/arch/arm/mach-zynq/Kconfig b/arch/arm/mach-zynq/Kconfig
index 85d1805..70e247d 100644
--- a/arch/arm/mach-zynq/Kconfig
+++ b/arch/arm/mach-zynq/Kconfig
@@ -6,7 +6,6 @@ config ARCH_ZYNQ
 	select HAVE_ARM_TWD if SMP
 	select ICST
 	select MIGHT_HAVE_CACHE_L2X0
-	select HAVE_SMP
 	select CADENCE_TTC_TIMER
 	select ARM_GLOBAL_TIMER
 	help
-- 
1.8.3.2
