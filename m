From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 16 Sep 2014 19:52:04 -0600
Subject: [PATCH] ARM: bcm2835: enable USB_DWC2_HOST in defconfig
Message-ID: <1410918724-22752-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lubomir Rintel <lkundrak@v3.sk>

It broke when host was moved into a separate module, in 47a1685 ("usb:
dwc2/s3c-hsotg: move s3c-hsotg into dwc2 directory"),

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
These two patches are all I expect to have for RPi for 3.18, so I figure
it's easiest to just forward them on to you rather than sending tiny pull
requests.

 arch/arm/configs/bcm2835_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index 0302d29..31cb073 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -98,6 +98,7 @@ CONFIG_LEDS_TRIGGER_TRANSIENT=y
 CONFIG_LEDS_TRIGGER_CAMERA=y
 CONFIG_STAGING=y
 CONFIG_USB_DWC2=y
+CONFIG_USB_DWC2_HOST=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
-- 
1.9.1
