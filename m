From: stefan@agner.ch (Stefan Agner)
Date: Wed, 10 Feb 2016 18:10:52 -0800
Subject: [PATCH] ARM: multi_v7_defconfig: enable useful configurations for
 Vybrid
Message-ID: <1455156652-6950-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable configuration options useful for Vybrid:
- NFC NAND driver
- USB dual-role controller (and Chipidea Gadget support)
- Built-in EDMA DMA driver (to be available at LPUART probe)
- Vybrid ADC driver
- IIO hwmon support (used in i.MX 23/28, patch pending for Vybrid)

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/configs/multi_v7_defconfig | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 314f6be..98ae019 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -182,6 +182,7 @@ CONFIG_MTD_M25P80=y
 CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_ATMEL=y
 CONFIG_MTD_NAND_BRCMNAND=y
+CONFIG_MTD_NAND_VF610_NFC=y
 CONFIG_MTD_NAND_DAVINCI=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_SPI_FSL_QUADSPI=m
@@ -403,6 +404,7 @@ CONFIG_POWER_RESET_KEYSTONE=y
 CONFIG_POWER_RESET_RMOBILE=y
 CONFIG_POWER_AVS=y
 CONFIG_ROCKCHIP_IODOMAIN=y
+CONFIG_SENSORS_IIO_HWMON=y
 CONFIG_SENSORS_LM90=y
 CONFIG_SENSORS_LM95245=y
 CONFIG_SENSORS_NTC_THERMISTOR=m
@@ -594,6 +596,7 @@ CONFIG_USB_STORAGE=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC2=m
 CONFIG_USB_CHIPIDEA=y
+CONFIG_USB_CHIPIDEA_UDC=y
 CONFIG_USB_CHIPIDEA_HOST=y
 CONFIG_AB8500_USB=y
 CONFIG_KEYSTONE_USB_PHY=y
@@ -603,6 +606,7 @@ CONFIG_USB_ISP1301=y
 CONFIG_USB_MSM_OTG=m
 CONFIG_USB_MXS_PHY=y
 CONFIG_USB_GADGET=y
+CONFIG_USB_FSL_USB2=y
 CONFIG_USB_RENESAS_USBHS_UDC=m
 CONFIG_USB_ETH=m
 CONFIG_MMC=y
@@ -690,7 +694,7 @@ CONFIG_DMADEVICES=y
 CONFIG_DW_DMAC=y
 CONFIG_AT_HDMAC=y
 CONFIG_AT_XDMAC=y
-CONFIG_FSL_EDMA=m
+CONFIG_FSL_EDMA=y
 CONFIG_MV_XOR=y
 CONFIG_TEGRA20_APB_DMA=y
 CONFIG_SH_DMAE=y
@@ -749,6 +753,7 @@ CONFIG_IIO=y
 CONFIG_AT91_ADC=m
 CONFIG_BERLIN2_ADC=m
 CONFIG_EXYNOS_ADC=m
+CONFIG_VF610_ADC=m
 CONFIG_XILINX_XADC=y
 CONFIG_AK8975=y
 CONFIG_PWM=y
-- 
2.7.1
