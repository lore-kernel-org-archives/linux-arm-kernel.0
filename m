From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Tue, 24 Apr 2018 10:52:50 +0800
Subject: [PATCH 5/5] usb: mtu3: make USB_MTU3_DUAL_ROLE depend on EXTCON but
 not USB_MTU3
In-Reply-To: <3b0c7ca576fee8220d63c9914483b70b0fbc8783.1524537854.git.chunfeng.yun@mediatek.com>
References: <3b0c7ca576fee8220d63c9914483b70b0fbc8783.1524537854.git.chunfeng.yun@mediatek.com>
Message-ID: <9d0d09a973c6a7d76088f6cf557bb052d02dd440.1524537854.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In fact the driver depends on EXTCON only when it's configed as
USB_MTU3_DUAL_ROLE, so make USB_MTU3_DUAL_ROLE depend on EXTCON but
not USB_MTU3.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/mtu3/Kconfig b/drivers/usb/mtu3/Kconfig
index 25cd619..8daf277 100644
--- a/drivers/usb/mtu3/Kconfig
+++ b/drivers/usb/mtu3/Kconfig
@@ -2,7 +2,7 @@
 
 config USB_MTU3
 	tristate "MediaTek USB3 Dual Role controller"
-	depends on EXTCON && (USB || USB_GADGET) && HAS_DMA
+	depends on (USB || USB_GADGET) && HAS_DMA
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	select USB_XHCI_MTK if USB_SUPPORT && USB_XHCI_HCD
 	help
@@ -40,6 +40,7 @@ config USB_MTU3_GADGET
 config USB_MTU3_DUAL_ROLE
 	bool "Dual Role mode"
 	depends on ((USB=y || USB=USB_MTU3) && (USB_GADGET=y || USB_GADGET=USB_MTU3))
+	depends on (EXTCON=y || EXTCON=USB_MTU3)
 	help
 	  This is the default mode of working of MTU3 controller where
 	  both host and gadget features are enabled.
-- 
1.9.1
