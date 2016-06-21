From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Tue, 21 Jun 2016 10:05:57 +0200
Subject: [PATCH] ARM: imx_v6_v7_defconfig: enable USB FFS gadget
Message-ID: <1466496357-17006-1-git-send-email-gary.bisson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The USB Function FS gadget can be very useful for debugging.

For instance, the adbd daemon can leverage this gadget to
offer an ADB connection to the platform over USB.

Note that adbd is available on many OS/build systems:
- Ubuntu: see android-tools-adbd package [1]
- Yocto: see meta-smartphone android-tools recipe [2]
- Buildroot: see android-tools package [3]

[1] http://packages.ubuntu.com/trusty/android-tools-adbd
[2] https://github.com/shr-distribution/meta-smartphone/tree/shr/meta-android/recipes-android/android-tools
[3] https://git.buildroot.net/buildroot/tree/package/android-tools

Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index eaabae2..89424a7 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -296,6 +296,7 @@ CONFIG_USB_ZERO=m
 CONFIG_USB_ETH=m
 CONFIG_USB_G_NCM=m
 CONFIG_USB_GADGETFS=m
+CONFIG_USB_FUNCTIONFS=m
 CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
 CONFIG_MMC=y
-- 
2.8.1
