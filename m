From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 16 Apr 2014 15:03:11 +0900
Subject: [PATCH 6/7] ARM: shmobile: Enable VSP1 in shmobile_defconfig
In-Reply-To: <cover.1397627278.git.horms+renesas@verge.net.au>
References: <cover.1397627278.git.horms+renesas@verge.net.au>
Message-ID: <e4224fe8bfd955d1aea5f89f2f3ac38dc4a590fc.1397627278.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Both r8a7790 and r8a7791 have multiple on-chip VSP1 devices, so
enable the VSP1 driver by default in the shmobile_defconfig.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index b73a038..8fb30b0 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -92,10 +92,14 @@ CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_GPIO=y
 CONFIG_MEDIA_SUPPORT=y
 CONFIG_MEDIA_CAMERA_SUPPORT=y
+CONFIG_MEDIA_CONTROLLER=y
+CONFIG_VIDEO_V4L2_SUBDEV_API=y
 CONFIG_V4L_PLATFORM_DRIVERS=y
 CONFIG_SOC_CAMERA=y
 CONFIG_SOC_CAMERA_PLATFORM=y
 CONFIG_VIDEO_RCAR_VIN=y
+CONFIG_V4L_MEM2MEM_DRIVERS=y
+CONFIG_VIDEO_RENESAS_VSP1=y
 # CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
 CONFIG_VIDEO_ADV7180=y
 CONFIG_DRM=y
-- 
1.8.5.2
