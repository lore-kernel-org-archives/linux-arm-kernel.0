From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 28 Jun 2013 19:49:19 -0300
Subject: [PATCH 2/2] ARM: imx_v6_v7_defconfig: Enable VPU driver
In-Reply-To: <1372459759-10488-1-git-send-email-festevam@gmail.com>
References: <1372459759-10488-1-git-send-email-festevam@gmail.com>
Message-ID: <1372459759-10488-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Let VPU driver be selected by default.

VPU driver requires a SRAM pool, so select CONFIG_SRAM as well.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 2353bde..e16384f 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -88,6 +88,7 @@ CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=65536
+CONFIG_SRAM=y
 CONFIG_EEPROM_AT24=y
 CONFIG_EEPROM_AT25=y
 # CONFIG_SCSI_PROC_FS is not set
@@ -169,6 +170,8 @@ CONFIG_SOC_CAMERA=y
 CONFIG_SOC_CAMERA_OV2640=y
 CONFIG_DRM=y
 CONFIG_VIDEO_MX3=y
+CONFIG_V4L_MEM2MEM_DRIVERS=y
+CONFIG_VIDEO_CODA=y
 CONFIG_FB=y
 CONFIG_LCD_PLATFORM=y
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
-- 
1.8.1.2
