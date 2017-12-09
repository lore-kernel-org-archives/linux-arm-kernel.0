From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Sat, 9 Dec 2017 16:45:34 +0800
Subject: [PATCH 5/7] dt-bindings: usb: mtk-xhci: add USB wakeup properties
In-Reply-To: <1512809136-2779-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1512809136-2779-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1512809136-2779-6-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modify the properties of usb wakeup, and use the new way of mtu_wakeup
which is extracted from SSUSB controller dirver as a new one.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 .../devicetree/bindings/usb/mediatek,mtk-xhci.txt         | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
index 3059596..88984d8 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
@@ -35,10 +35,17 @@ Required properties:
  - phys : a list of phandle + phy specifier pairs
 
 Optional properties:
- - mediatek,wakeup-src : 1: ip sleep wakeup mode; 2: line state wakeup
-	mode;
- - mediatek,syscon-wakeup : phandle to syscon used to access USB wakeup
-	control register, it depends on "mediatek,wakeup-src".
+ - mediatek,uwks : a phandle to USB-Wakeup node to control the type of
+	wakeup, it's used to replace the old way which is realized by the
+	property of "mediatek,wakeup-src" and "mediatek,syscon-wakeup",
+	see: Documentation/devicetree/bindings/soc/mediatek/usb-wakeup.txt
+ - wakeup-source : Decides if the new way of USB wakeup is supported or
+	not, it depends on "mediatek,uwks" property.
+ - mediatek,wakeup-src : (deprecated) 1: ip sleep wakeup mode; 2: line
+	state wakeup mode; only supports mt8173 platform, use the property
+	of "mediatek,uwks" instead on other SoCs.
+ - mediatek,syscon-wakeup : (deprecated) phandle to syscon used to access
+	USB wakeup control register, depends on "mediatek,wakeup-src".
  - mediatek,u3p-dis-msk : mask to disable u3ports, bit0 for u3port0,
 	bit1 for u3port1, ... etc;
  - vbus-supply : reference to the VBUS regulator;
-- 
1.9.1
