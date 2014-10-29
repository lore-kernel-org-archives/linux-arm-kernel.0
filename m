From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 29 Oct 2014 19:19:28 -0200
Subject: [PATCH] ARM: imx: Explicitly select CONFIG_SPI
Message-ID: <1414617568-27615-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Since 3.18-rc1 CONFIG_SPI is no longer automatically selected for 
imx_v4_v5_defconfig and imx_v6_v7_defconfig, so in order to keep the same
behaviour as previous kernel versions and avoid regressions, let's explicitly
select CONFIG_SPI.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Shawn,

If possible, please apply this as a bug fix for 3.18.

 arch/arm/configs/imx_v4_v5_defconfig | 1 +
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index e688741..e6b0007 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -97,6 +97,7 @@ CONFIG_SERIAL_IMX_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_IMX=y
+CONFIG_SPI=y
 CONFIG_SPI_IMX=y
 CONFIG_SPI_SPIDEV=y
 CONFIG_GPIO_SYSFS=y
diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 8fca6e2..6790f1b 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -158,6 +158,7 @@ CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_ALGOPCF=m
 CONFIG_I2C_ALGOPCA=m
 CONFIG_I2C_IMX=y
+CONFIG_SPI=y
 CONFIG_SPI_IMX=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_MC9S08DZ60=y
-- 
1.9.1
