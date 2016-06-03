From: peter.chen@nxp.com (Peter Chen)
Date: Fri, 3 Jun 2016 15:12:04 +0800
Subject: [PATCH 1/1] ARM: imx_v6_v7_defconfig: build in usbnet to support NFS
 for non-ethernet board
Message-ID: <1464937924-11683-1-git-send-email-peter.chen@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At some boards, it has no ethernet support. As an alternative, we can use
USB Ethernet card to support NFS (u-boot supports it too). It supports
AXIS cards which are used most frequently.

Signed-off-by: Peter Chen <peter.chen@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 21339ce..eaabae2 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -146,7 +146,7 @@ CONFIG_MICREL_PHY=y
 CONFIG_USB_PEGASUS=m
 CONFIG_USB_RTL8150=m
 CONFIG_USB_RTL8152=m
-CONFIG_USB_USBNET=m
+CONFIG_USB_USBNET=y
 CONFIG_USB_NET_CDC_EEM=m
 CONFIG_BRCMFMAC=m
 CONFIG_WL12XX=m
-- 
1.9.1
