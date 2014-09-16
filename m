From: lkundrak@v3.sk (Lubomir Rintel)
Date: Tue, 16 Sep 2014 16:40:35 +0200
Subject: [PATCH] ARM: bcm2835: Enable USB_DWC2_HOST in bcm2835_defconfig
Message-ID: <1410878435-12499-1-git-send-email-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It broke when host was moved into a separate module, in [47a1685f1].

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
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
1.9.3
