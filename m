From: tony.felice@timesys.com (Anthony Felice)
Date: Fri, 24 Jun 2016 15:44:46 -0400
Subject: [PATCH 4/4] ARM: imx_v6_v7_defconfig: enable useful configurations
 for Vybrid
In-Reply-To: <1466797486-31558-1-git-send-email-tony.felice@timesys.com>
References: <1466797486-31558-1-git-send-email-tony.felice@timesys.com>
Message-ID: <1466797486-31558-5-git-send-email-tony.felice@timesys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable configuration options useful for the Vybrid Tower platform:
- CRTouch Touchscreen support.
- DRM support for Freescale DCU.

Regenerated config using savedefconfig (which removes some configs
which are now enabled by default).

Signed-off-by: Anthony Felice <tony.felice@timesys.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 21339ce..0b9de5c 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -1,6 +1,5 @@
 CONFIG_KERNEL_LZO=y
 CONFIG_SYSVIPC=y
-CONFIG_FHANDLE=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
@@ -72,7 +71,6 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 CONFIG_NETFILTER=y
 CONFIG_CAN=y
 CONFIG_CAN_FLEXCAN=y
@@ -170,6 +168,7 @@ CONFIG_TOUCHSCREEN_TSC2007=y
 CONFIG_TOUCHSCREEN_STMPE=y
 CONFIG_TOUCHSCREEN_SX8654=y
 CONFIG_TOUCHSCREEN_COLIBRI_VF50=y
+CONFIG_TOUCHSCREEN_CRTOUCH=y
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_MMA8450=y
 CONFIG_SERIO_SERPORT=m
@@ -227,12 +226,12 @@ CONFIG_MEDIA_USB_SUPPORT=y
 CONFIG_USB_VIDEO_CLASS=m
 CONFIG_V4L_PLATFORM_DRIVERS=y
 CONFIG_SOC_CAMERA=y
-CONFIG_VIDEO_MX3=y
 CONFIG_V4L_MEM2MEM_DRIVERS=y
 CONFIG_VIDEO_CODA=y
 CONFIG_SOC_CAMERA_OV2640=y
 CONFIG_IMX_IPUV3_CORE=y
 CONFIG_DRM=y
+CONFIG_DRM_FSL_DCU=y
 CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_DRM_DW_HDMI_AHB_AUDIO=m
 CONFIG_DRM_IMX=y
@@ -333,7 +332,6 @@ CONFIG_VF610_ADC=y
 CONFIG_PWM=y
 CONFIG_PWM_FSL_FTM=y
 CONFIG_PWM_IMX=y
-CONFIG_NVMEM=y
 CONFIG_NVMEM_IMX_OCOTP=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
-- 
2.7.4
