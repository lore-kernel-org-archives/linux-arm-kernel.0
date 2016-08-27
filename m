From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 27 Aug 2016 16:12:32 -0700
Subject: [PATCH] ARM: multi_v7_defconfig: Enable BCM47xx/BCM5301x drivers
Message-ID: <1472339552-9960-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a bunch of required drivers and subsystems:

- BCMA is the on-chip discoverable bus which registers a bunch of
  peripherals
- Enable the BCM47xx watchdog driver to get working system reboot
- Enable the BCM47xx NVRAM/SPROM drivers to be able to fetch MAC
  addresses and other variables needed for system operation
- Make BGMAC (built-in Ethernet adapter) a module

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/configs/multi_v7_defconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 2c8665cd9dc5..958ff2932f32 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -170,6 +170,11 @@ CONFIG_CAN_RCAR=m
 CONFIG_CAN_XILINXCAN=y
 CONFIG_CAN_MCP251X=y
 CONFIG_NET_DSA_BCM_SF2=m
+CONFIG_B53=m
+CONFIG_B53_SPI_DRIVER=m
+CONFIG_B53_MDIO_DRIVER=m
+CONFIG_B53_MMAP_DRIVER=m
+CONFIG_B53_SRAB_DRIVER=m
 CONFIG_CAN_SUN4I=y
 CONFIG_BT=m
 CONFIG_BT_MRVL=m
@@ -231,6 +236,7 @@ CONFIG_HIX5HD2_GMAC=y
 CONFIG_SUN4I_EMAC=y
 CONFIG_MACB=y
 CONFIG_BCMGENET=m
+CONFIG_BGMAC_BCMA=y
 CONFIG_SYSTEMPORT=m
 CONFIG_NET_CALXEDA_XGMAC=y
 CONFIG_GIANFAR=y
@@ -463,6 +469,7 @@ CONFIG_MESON_WATCHDOG=y
 CONFIG_DW_WATCHDOG=y
 CONFIG_DIGICOLOR_WATCHDOG=y
 CONFIG_BCM2835_WDT=y
+CONFIG_BCM47XX_WATCHDOG=y
 CONFIG_BCM7038_WDT=m
 CONFIG_BCM_KONA_WDT=y
 CONFIG_MFD_ACT8945A=y
@@ -791,6 +798,10 @@ CONFIG_KEYBOARD_NVEC=y
 CONFIG_SERIO_NVEC_PS2=y
 CONFIG_NVEC_POWER=y
 CONFIG_NVEC_PAZ00=y
+CONFIG_BCMA=y
+CONFIG_BCMA_HOST_SOC=y
+CONFIG_BCMA_DRIVER_GMAC_CMN=y
+CONFIG_BCMA_DRIVER_GPIO=y
 CONFIG_QCOM_GSBI=y
 CONFIG_QCOM_PM=y
 CONFIG_QCOM_SMEM=y
@@ -867,6 +878,8 @@ CONFIG_NVMEM=y
 CONFIG_NVMEM_SUNXI_SID=y
 CONFIG_BCM2835_MBOX=y
 CONFIG_RASPBERRYPI_FIRMWARE=y
+CONFIG_CONFIG_BCM47XX_NVRAM=y
+CONFIG_BCM47XX_SPROM=y
 CONFIG_EXT4_FS=y
 CONFIG_AUTOFS4_FS=y
 CONFIG_MSDOS_FS=y
-- 
2.7.4
