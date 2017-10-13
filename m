From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Fri, 13 Oct 2017 16:26:39 +0800
Subject: [PATCH v2 7/9] usb: host: modify description for MTK xHCI config
In-Reply-To: <994382d16d6bdc0f3d7c11b22f1710252e056e34.1507882470.git.chunfeng.yun@mediatek.com>
References: <994382d16d6bdc0f3d7c11b22f1710252e056e34.1507882470.git.chunfeng.yun@mediatek.com>
Message-ID: <37153cd259af6e1fc34b32a2e0dd1a15b8214579.1507882470.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to all MediaTek SoCs with xHCI host controller use this
driver, remove limitation for specific SoCs

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index fa5692d..bc09a2e 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -45,12 +45,12 @@ config USB_XHCI_PLATFORM
 	  If unsure, say N.
 
 config USB_XHCI_MTK
-	tristate "xHCI support for Mediatek MT65xx/MT7621"
+	tristate "xHCI support for MediaTek SoCs"
 	select MFD_SYSCON
 	depends on (MIPS && SOC_MT7621) || ARCH_MEDIATEK || COMPILE_TEST
 	---help---
 	  Say 'Y' to enable the support for the xHCI host controller
-	  found in Mediatek MT65xx SoCs.
+	  found in MediaTek SoCs.
 	  If unsure, say N.
 
 config USB_XHCI_MVEBU
-- 
1.7.9.5
