From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 24 Jun 2016 09:10:13 -0400
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Enable vivid driver as a module
In-Reply-To: <1466773813-14647-1-git-send-email-javier@osg.samsung.com>
References: <1466773813-14647-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1466773813-14647-2-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Virtual Video Test Driver can be used to emulate video capture and
output devices so it's very useful for testing. Since is not necessary
to boot, can be enabled as module to avoid increasing the kernel size.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index e78469216378..45265ff3cdcb 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -555,6 +555,7 @@ CONFIG_VIDEO_SAMSUNG_S5P_JPEG=m
 CONFIG_VIDEO_SAMSUNG_S5P_MFC=m
 CONFIG_VIDEO_RENESAS_JPU=m
 CONFIG_VIDEO_RENESAS_VSP1=m
+CONFIG_V4L_TEST_DRIVERS=y
 # CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
 CONFIG_VIDEO_ADV7180=m
 CONFIG_VIDEO_ML86V7667=m
@@ -906,6 +907,7 @@ CONFIG_CRYPTO_GHASH_ARM_CE=m
 CONFIG_CRYPTO_DEV_ATMEL_AES=m
 CONFIG_CRYPTO_DEV_ATMEL_TDES=m
 CONFIG_CRYPTO_DEV_ATMEL_SHA=m
+CONFIG_VIDEO_VIVID=m
 CONFIG_VIRTIO=y
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_PCI_LEGACY=y
-- 
2.5.5
