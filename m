From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Mon, 29 Feb 2016 11:26:17 +0100
Subject: [PATCH v2 1/2] ARM: imx_v4_v5_defconfig: Cleanup imx_v4_v5_defconfig
Message-ID: <1456741578-3202-1-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jan Luebbe <jlu@pengutronix.de>

Regenerate imx_v4_v5_defconfig by running:
make imx_v4_v5_defconfig
- Manually disable EXT2_FS and EXT3_FS
make savedefconfig
mv defconfig arch/arm/configs/imx_v4_v5_defconfig

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
v2: Disabled EXT2_FS and EXT3_FS instead of EXT4_FS

 arch/arm/configs/imx_v4_v5_defconfig | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index d3a8018..c5d36c2 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -24,14 +24,12 @@ CONFIG_ARCH_MXC=y
 CONFIG_MACH_SCB9328=y
 CONFIG_MACH_APF9328=y
 CONFIG_MACH_MX21ADS=y
-CONFIG_MACH_EUKREA_CPUIMX25SD=y
-CONFIG_SOC_IMX25=y
 CONFIG_MACH_MX27ADS=y
 CONFIG_MACH_MX27_3DS=y
 CONFIG_MACH_IMX27_VISSTRIM_M10=y
 CONFIG_MACH_PCA100=y
-CONFIG_MACH_MXT_TD60=y
 CONFIG_MACH_IMX27_DT=y
+CONFIG_SOC_IMX25=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
@@ -169,11 +167,9 @@ CONFIG_RTC_DRV_IMXDI=y
 CONFIG_RTC_DRV_MC13XXX=y
 CONFIG_RTC_DRV_MXC=y
 CONFIG_DMADEVICES=y
-CONFIG_IMX_SDMA=y
 CONFIG_IMX_DMA=y
+CONFIG_IMX_SDMA=y
 # CONFIG_IOMMU_SUPPORT is not set
-CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
 CONFIG_EXT4_FS=y
 # CONFIG_DNOTIFY is not set
 CONFIG_VFAT_FS=y
@@ -187,6 +183,5 @@ CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_CODEPAGE_850=m
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_15=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_FONTS=y
 CONFIG_FONT_8x8=y
-- 
2.7.0
