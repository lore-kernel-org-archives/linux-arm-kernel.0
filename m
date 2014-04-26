From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 26 Apr 2014 18:16:54 +0200
Subject: [PATCH 2/2] ARM: Enable the new Allwinner SoCs support options
In-Reply-To: <1398529014-1152-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1398529014-1152-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1398529014-1152-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the new Kconfig option related to SoC support in multi_v7 and sunxi
defconfigs.

While we're at it, also enable the missing Allwinnner SPI options.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/configs/multi_v7_defconfig | 6 ++++++
 arch/arm/configs/sunxi_defconfig    | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index d4e8a47a2f7c..f5fcfc142691 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -48,6 +48,10 @@ CONFIG_MACH_SPEAR1310=y
 CONFIG_MACH_SPEAR1340=y
 CONFIG_ARCH_STI=y
 CONFIG_ARCH_SUNXI=y
+CONFIG_MACH_SUN4I=y
+CONFIG_MACH_SUN5I=y
+CONFIG_MACH_SUN6I=y
+CONFIG_MACH_SUN7I=y
 CONFIG_ARCH_SIRF=y
 CONFIG_ARCH_TEGRA=y
 CONFIG_ARCH_TEGRA_2x_SOC=y
@@ -184,6 +188,8 @@ CONFIG_SPI_OMAP24XX=y
 CONFIG_SPI_ORION=y
 CONFIG_SPI_PL022=y
 CONFIG_SPI_SIRF=y
+CONFIG_SPI_SUN4I=y
+CONFIG_SPI_SUN6I=y
 CONFIG_SPI_TEGRA114=y
 CONFIG_SPI_TEGRA20_SFLASH=y
 CONFIG_SPI_TEGRA20_SLINK=y
diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index b5df4a511b0a..78732ed10d0e 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -2,6 +2,10 @@ CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_ARCH_SUNXI=y
+CONFIG_MACH_SUN4I=y
+CONFIG_MACH_SUN5I=y
+CONFIG_MACH_SUN6I=y
+CONFIG_MACH_SUN7I=y
 CONFIG_SMP=y
 CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
@@ -50,6 +54,7 @@ CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MV64XXX=y
 CONFIG_SPI=y
+CONFIG_SPI_SUN4I=y
 CONFIG_SPI_SUN6I=y
 CONFIG_GPIO_SYSFS=y
 # CONFIG_HWMON is not set
-- 
1.9.1
