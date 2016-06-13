From: hramrach@gmail.com (Michal Suchanek)
Date: 13 Jun 2016 17:46:53 -0000
Subject: [PATCH v3 12/13] spi: sunxi: remove CONFIG_SPI_SUN6I
In-Reply-To: <cover.1465490774.git.hramrach@gmail.com>
References: <cover.1465490774.git.hramrach@gmail.com>
Message-ID: <93f3906ca5457c8619f8f5e8541900b9f12a29c9.1465490774.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is no longer used.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 -
 arch/arm/configs/sunxi_defconfig    | 1 -
 drivers/spi/Kconfig                 | 6 ------
 3 files changed, 8 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 2823490..3196f04 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -362,7 +362,6 @@ CONFIG_SPI_SH_MSIOF=m
 CONFIG_SPI_SH_HSPI=y
 CONFIG_SPI_SIRF=y
 CONFIG_SPI_SUN4I=y
-CONFIG_SPI_SUN6I=y
 CONFIG_SPI_TEGRA114=y
 CONFIG_SPI_TEGRA20_SFLASH=y
 CONFIG_SPI_TEGRA20_SLINK=y
diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 81a1b92..6d0c650 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -78,7 +78,6 @@ CONFIG_I2C_MV64XXX=y
 CONFIG_I2C_SUN6I_P2WI=y
 CONFIG_SPI=y
 CONFIG_SPI_SUN4I=y
-CONFIG_SPI_SUN6I=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_POWER_SUPPLY=y
 CONFIG_AXP20X_POWER=y
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 1b5045b..52e588f 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -581,12 +581,6 @@ config SPI_SUN4I
 	help
 	  SPI driver for Allwinner sun4i, sun5i and sun7i SoCs
 
-config SPI_SUN6I
-	tristate "Allwinner A31 SPI controller (deprecated compatibility option)"
-	depends on ARCH_SUNXI || COMPILE_TEST
-	depends on RESET_CONTROLLER
-	select SPI_SUN4I
-
 config SPI_MXS
 	tristate "Freescale MXS SPI controller"
 	depends on ARCH_MXS
-- 
2.8.1
