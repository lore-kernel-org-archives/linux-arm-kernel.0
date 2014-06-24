From: denis@eukrea.com (Denis Carikli)
Date: Tue, 24 Jun 2014 16:46:35 +0200
Subject: [PATCH v4 6/6] ARM: imx_v4_v5_defconfig: Add I.MX25 Touchscreen
 controller and ADC support.
In-Reply-To: <1403621195-9622-1-git-send-email-denis@eukrea.com>
References: <1403621195-9622-1-git-send-email-denis@eukrea.com>
Message-ID: <1403621195-9622-6-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
Changelog v3->v4:
- None

Changelog v2->v3:
- Added ADC support, splitting it would be overkill.
---
 arch/arm/configs/imx_v4_v5_defconfig |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index 68abce9..43dd6e9 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -97,6 +97,7 @@ CONFIG_KEYBOARD_IMX=y
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ADS7846=m
+CONFIG_TOUCHSCREEN_MX25=y
 CONFIG_TOUCHSCREEN_MC13783=y
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_8250=m
@@ -117,6 +118,7 @@ CONFIG_HWMON=m
 CONFIG_SENSORS_MC13783_ADC=m
 CONFIG_WATCHDOG=y
 CONFIG_IMX2_WDT=y
+CONFIG_MFD_MX25_TSADC=y
 CONFIG_MFD_MC13XXX_SPI=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
@@ -183,6 +185,8 @@ CONFIG_DMADEVICES=y
 CONFIG_IMX_SDMA=y
 CONFIG_IMX_DMA=y
 # CONFIG_IOMMU_SUPPORT is not set
+CONFIG_IIO=y
+CONFIG_FSL_MX25_ADC=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_EXT4_FS=y
-- 
1.7.9.5
