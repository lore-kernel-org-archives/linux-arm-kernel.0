From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Tue, 8 Aug 2017 13:42:51 +0800
Subject: [PATCH 3/4] dt-bindings: mt8173-mtu3: add generic compatible and
 rename file
In-Reply-To: <8f0cb0047b2aa195d818ad686cbbceabb3ad91a0.1502170518.git.chunfeng.yun@mediatek.com>
References: <8f0cb0047b2aa195d818ad686cbbceabb3ad91a0.1502170518.git.chunfeng.yun@mediatek.com>
Message-ID: <121eaec8845c62383701d4fdfe9649335937f025.1502170518.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mt8173-mtu3.txt actually holds the bindings for all mediatek
SoCs with usb3 DRD IP, so add a generic compatible and change the
name to mtu3.txt.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 .../bindings/usb/{mt8173-mtu3.txt => mtu3.txt}     |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/usb/{mt8173-mtu3.txt => mtu3.txt} (95%)

diff --git a/Documentation/devicetree/bindings/usb/mt8173-mtu3.txt b/Documentation/devicetree/bindings/usb/mtu3.txt
similarity index 95%
rename from Documentation/devicetree/bindings/usb/mt8173-mtu3.txt
rename to Documentation/devicetree/bindings/usb/mtu3.txt
index 1d7c3bc..832741d 100644
--- a/Documentation/devicetree/bindings/usb/mt8173-mtu3.txt
+++ b/Documentation/devicetree/bindings/usb/mtu3.txt
@@ -1,7 +1,9 @@
 The device node for Mediatek USB3.0 DRD controller
 
 Required properties:
- - compatible : should be "mediatek,mt8173-mtu3"
+ - compatible : should be one of
+	"mediatek,mt8173-mtu3" (deprecated, use "mediatek,mtu3" instead),
+	"mediatek,mtu3"
  - reg : specifies physical base address and size of the registers
  - reg-names: should be "mac" for device IP and "ippc" for IP port control
  - interrupts : interrupt used by the device IP
@@ -44,7 +46,7 @@ Optional properties:
 Sub-nodes:
 The xhci should be added as subnode to mtu3 as shown in the following example
 if host mode is enabled. The DT binding details of xhci can be found in:
-Documentation/devicetree/bindings/usb/mt8173-xhci.txt
+Documentation/devicetree/bindings/usb/xhci-mtk.txt
 
 Example:
 ssusb: usb at 11271000 {
-- 
1.7.9.5
