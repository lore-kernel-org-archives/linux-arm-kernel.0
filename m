From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri,  3 Jun 2016 13:14:01 +0100
Subject: [PATCH] ARM: multi_v7_defconfig: Enable ASIX based usb networking
 adapters
Message-ID: <1464956041-8163-1-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ASIX usb adapters are very common, and is the recommended
96boards usb ethernet adapter. Enable this driver by default
for multi_v7_defconfig to allow easy NFS rootfs on armv7 based
boards which don't have onboard NIC.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index fbfc11a..6591f2c 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -251,6 +251,7 @@ CONFIG_USB_RTL8152=m
 CONFIG_USB_USBNET=y
 CONFIG_USB_NET_SMSC75XX=y
 CONFIG_USB_NET_SMSC95XX=y
+CONFIG_USB_NET_AX8817X=y
 CONFIG_BRCMFMAC=m
 CONFIG_RT2X00=m
 CONFIG_RT2800USB=m
-- 
1.9.1
