From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 14 Nov 2018 22:11:04 +0100
Subject: [PATCH] ARM: bcm2835_defconfig: Enable BCM2835 MMAL-based V4L2 camera
 driver
Message-ID: <1542229864-27695-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the bcm2835-camera driver, which depends on bcm2835-vchiq.
After that we gain more test coverage (e.g. Kernel CI).

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/configs/bcm2835_defconfig | 3 +++
 1 file changed, 3 insertions(+)

Hi, i will submit a patch series to address those probing issues. But this is
independent from this patch.

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index bb6a35f..bd55a2b 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -91,6 +91,8 @@ CONFIG_THERMAL=y
 CONFIG_BCM2835_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_BCM2835_WDT=y
+CONFIG_MEDIA_SUPPORT=y
+CONFIG_MEDIA_CAMERA_SUPPORT=y
 CONFIG_DRM=y
 CONFIG_DRM_VC4=y
 CONFIG_FB_SIMPLE=y
@@ -129,6 +131,7 @@ CONFIG_DMADEVICES=y
 CONFIG_DMA_BCM2835=y
 CONFIG_STAGING=y
 CONFIG_SND_BCM2835=m
+CONFIG_VIDEO_BCM2835=m
 CONFIG_MAILBOX=y
 CONFIG_BCM2835_MBOX=y
 # CONFIG_IOMMU_SUPPORT is not set
-- 
2.7.4
