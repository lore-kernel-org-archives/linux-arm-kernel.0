From: festevam@gmail.com (Fabio Estevam)
Date: Fri,  7 Jul 2017 12:06:45 -0300
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Select the coda driver as module
Message-ID: <1499440005-8067-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

The coda driver may be probed prior to the rootfs being available, leading
to firmware loading failure.

To avoid such problem, select the coda driver as module.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index e74de69..621910a 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -234,7 +234,7 @@ CONFIG_USB_VIDEO_CLASS=m
 CONFIG_V4L_PLATFORM_DRIVERS=y
 CONFIG_SOC_CAMERA=y
 CONFIG_V4L_MEM2MEM_DRIVERS=y
-CONFIG_VIDEO_CODA=y
+CONFIG_VIDEO_CODA=m
 CONFIG_SOC_CAMERA_OV2640=y
 CONFIG_IMX_IPUV3_CORE=y
 CONFIG_DRM=y
-- 
2.7.4
