From: festevam@gmail.com (Fabio Estevam)
Date: Tue,  4 Nov 2014 08:28:47 -0200
Subject: [PATCH v2] ARM: imx: Fix the removal of CONFIG_SPI option
Message-ID: <1415096927-4097-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Since 64546e9fe3a5b8c ("ARM: imx_v6_v7_defconfig updates") and commit 
0650f855d2e4b0b9 ("ARM: imx_v4_v5_defconfig: Select CONFIG_IMX_WEIM") CONFIG_SPI
selection was dropped by savedefconfig for imx_v4_v5_defconfig and 
imx_v6_v7_defconfig.

In order to keep the same behaviour as previous kernel versions and avoid 
regressions, let's add CONFIG_SPI option back.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Add commit id's that caused the issue.

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
