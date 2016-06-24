From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 24 Jun 2016 09:10:12 -0400
Subject: [PATCH 1/2] ARM: exynos_defconfig: Enable vivid driver as a module
Message-ID: <1466773813-14647-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Virtual Video Test Driver can be used to emulate video capture and
output devices so it's very useful for testing. Since is not necessary
to boot, can be enabled as module to avoid increasing the kernel size.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/configs/exynos_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index daf9762ec794..a5aa44c56bfe 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -152,6 +152,7 @@ CONFIG_VIDEO_EXYNOS4_FIMC_IS=m
 CONFIG_V4L_MEM2MEM_DRIVERS=y
 CONFIG_VIDEO_SAMSUNG_S5P_JPEG=m
 CONFIG_VIDEO_SAMSUNG_S5P_MFC=m
+CONFIG_V4L_TEST_DRIVERS=y
 CONFIG_DRM=y
 CONFIG_DRM_EXYNOS=y
 CONFIG_DRM_EXYNOS_FIMD=y
@@ -263,3 +264,4 @@ CONFIG_CRYPTO_AES_ARM_BS=m
 CONFIG_CRC_CCITT=y
 CONFIG_FONTS=y
 CONFIG_FONT_7x14=y
+CONFIG_VIDEO_VIVID=m
-- 
2.5.5
