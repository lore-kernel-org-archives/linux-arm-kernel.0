From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 28 Jan 2014 18:20:20 +0000
Subject: [PATCH V2 1/2] ARM: multi_v7_defconfig: update for v3.13-rc1
In-Reply-To: <1390871129-4838-1-git-send-email-jason@lakedaemon.net>
References: <1390871129-4838-1-git-send-email-jason@lakedaemon.net>
Message-ID: <14397edee7978df1d80e048d7cd02c826a91af56.1390932990.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just the output of:

  make ARCH=arm multi_v7_defconfig
  make savedefconfig
  mv defconfig arch/arm/configs/multi_v7_defconfig

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
v1 -> v2:
 - broke out updating the defconfig as a separate patch.

 arch/arm/configs/multi_v7_defconfig | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 4a5903e04827..1e37e862baea 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -34,7 +34,6 @@ CONFIG_ARCH_TEGRA=y
 CONFIG_ARCH_TEGRA_2x_SOC=y
 CONFIG_ARCH_TEGRA_3x_SOC=y
 CONFIG_ARCH_TEGRA_114_SOC=y
-CONFIG_TEGRA_PCI=y
 CONFIG_TEGRA_EMC_SCALING_ENABLE=y
 CONFIG_ARCH_U8500=y
 CONFIG_MACH_HREFV60=y
@@ -68,7 +67,6 @@ CONFIG_NET_CALXEDA_XGMAC=y
 CONFIG_KS8851=y
 CONFIG_SMSC911X=y
 CONFIG_STMMAC_ETH=y
-CONFIG_MDIO_SUN4I=y
 CONFIG_KEYBOARD_SPEAR=y
 CONFIG_SERIO_AMBAKMI=y
 CONFIG_SERIAL_8250=y
@@ -102,14 +100,13 @@ CONFIG_SPI_TEGRA20_SLINK=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_GPIO_GENERIC_PLATFORM=y
 CONFIG_GPIO_TWL4030=y
-CONFIG_REGULATOR_GPIO=y
 CONFIG_REGULATOR_AB8500=y
+CONFIG_REGULATOR_GPIO=y
 CONFIG_REGULATOR_TPS51632=y
 CONFIG_REGULATOR_TPS62360=y
 CONFIG_REGULATOR_TWL4030=y
 CONFIG_REGULATOR_VEXPRESS=y
 CONFIG_DRM=y
-CONFIG_TEGRA_HOST1X=y
 CONFIG_DRM_TEGRA=y
 CONFIG_FB_ARMCLCD=y
 CONFIG_FB_WM8505=y
@@ -124,8 +121,6 @@ CONFIG_USB_STORAGE=y
 CONFIG_USB_CHIPIDEA=y
 CONFIG_USB_CHIPIDEA_HOST=y
 CONFIG_AB8500_USB=y
-CONFIG_NOP_USB_XCEIV=y
-CONFIG_OMAP_USB2=y
 CONFIG_OMAP_USB3=y
 CONFIG_SAMSUNG_USB2PHY=y
 CONFIG_SAMSUNG_USB3PHY=y
@@ -155,7 +150,6 @@ CONFIG_DW_DMAC=y
 CONFIG_TEGRA20_APB_DMA=y
 CONFIG_STE_DMA40=y
 CONFIG_SIRF_DMA=y
-CONFIG_TI_EDMA=y
 CONFIG_PL330_DMA=y
 CONFIG_IMX_SDMA=y
 CONFIG_IMX_DMA=y
@@ -163,6 +157,7 @@ CONFIG_MXS_DMA=y
 CONFIG_DMA_OMAP=y
 CONFIG_PWM=y
 CONFIG_PWM_VT8500=y
+CONFIG_OMAP_USB2=y
 CONFIG_EXT4_FS=y
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
-- 
1.8.5.3
