From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 Feb 2016 22:08:36 +0100
Subject: [PATCH 2/8] drm: msm: rename module
In-Reply-To: <1456175331-714117-1-git-send-email-arnd@arndb.de>
References: <1456175331-714117-1-git-send-email-arnd@arndb.de>
Message-ID: <1456175331-714117-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

msm.ko is not an appropriate name for a module that drives a specific
device on the msm platform. This changes the name to drm_msm.ko
to have something that won't conflict with any other module name.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/msm/Makefile | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index 9386cfeb55b2..24f6fd2b9651 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -1,6 +1,6 @@
 ccflags-y := -Iinclude/drm -Idrivers/gpu/drm/msm
 
-msm-y := \
+drm-msm-y := \
 	adreno/adreno_device.o \
 	adreno/adreno_gpu.o \
 	adreno/a3xx_gpu.o \
@@ -34,14 +34,14 @@ msm-y := \
 	msm_rd.o \
 	msm_ringbuffer.o
 
-msm-$(CONFIG_DRM_MSM_DSI) += mdp/mdp4/mdp4_dsi_encoder.o \
-			     mdp/mdp5/mdp5_cmd_encoder.o
+drm-msm-$(CONFIG_DRM_MSM_DSI) += mdp/mdp4/mdp4_dsi_encoder.o \
+				 mdp/mdp5/mdp5_cmd_encoder.o
 
-msm-$(CONFIG_DRM_FBDEV_EMULATION) += msm_fbdev.o
-msm-$(CONFIG_COMMON_CLK) += mdp/mdp4/mdp4_lvds_pll.o
+drm-msm-$(CONFIG_DRM_FBDEV_EMULATION) += msm_fbdev.o
+drm-msm-$(CONFIG_COMMON_CLK) += mdp/mdp4/mdp4_lvds_pll.o
 
 obj-$(CONFIG_DRM_MSM_DSI) += dsi/
 obj-$(CONFIG_DRM_MSM_HDMI) += hdmi/
 obj-$(CONFIG_DRM_MSM_EDP) += edp/
 
-obj-$(CONFIG_DRM_MSM)	+= msm.o
+obj-$(CONFIG_DRM_MSM)	+= drm-msm.o
-- 
2.7.0
