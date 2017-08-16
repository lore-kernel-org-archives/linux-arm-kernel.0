From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 16 Aug 2017 14:08:13 +0800
Subject: [PATCH v2 4/4] dt-bindings: mt8173-xhci: add generic compatible and
 rename file
In-Reply-To: <670f9ce1ecaec5859006b6f02b45cfc72c3cca2c.1502854628.git.chunfeng.yun@mediatek.com>
References: <670f9ce1ecaec5859006b6f02b45cfc72c3cca2c.1502854628.git.chunfeng.yun@mediatek.com>
Message-ID: <1926a457a86a1d90b923482179bf76dd1c74f3c1.1502854628.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mt8173-xhci.txt actually holds the bindings for all mediatek
SoCs with xHCI controller, so add a generic compatible and change
the name to mediatek,mtk-xhci.txt to reflect that.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 .../usb/{mt8173-xhci.txt => mediatek,mtk-xhci.txt} |   14 +++++++++++---
 .../devicetree/bindings/usb/mediatek,mtu3.txt      |    2 +-
 2 files changed, 12 insertions(+), 4 deletions(-)
 rename Documentation/devicetree/bindings/usb/{mt8173-xhci.txt => mediatek,mtk-xhci.txt} (85%)

diff --git a/Documentation/devicetree/bindings/usb/mt8173-xhci.txt b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
similarity index 85%
rename from Documentation/devicetree/bindings/usb/mt8173-xhci.txt
rename to Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
index 0acfc8a..ff21135 100644
--- a/Documentation/devicetree/bindings/usb/mt8173-xhci.txt
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
@@ -11,7 +11,11 @@ into two parts.
 ------------------------------------------------------------------------
 
 Required properties:
- - compatible : should contain "mediatek,mt8173-xhci"
+ - compatible : should be "mediatek,soc-model-xhci", "mediatek,mtk-xhci",
+	soc-model is the name of SoC, such as mt8173, mt2712 etc, when using
+	"mediatek,mtk-xhci" compatible string, you need SoC specific ones in
+	addition, one of:
+	- "mediatek,mt8173-xhci"
  - reg : specifies physical base address and size of the registers
  - reg-names: should be "mac" for xHCI MAC and "ippc" for IP port control
  - interrupts : interrupt used by the controller
@@ -68,10 +72,14 @@ usb30: usb at 11270000 {
 
 In the case, xhci is added as subnode to mtu3. An example and the DT binding
 details of mtu3 can be found in:
-Documentation/devicetree/bindings/usb/mt8173-mtu3.txt
+Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
 
 Required properties:
- - compatible : should contain "mediatek,mt8173-xhci"
+ - compatible : should be "mediatek,soc-model-xhci", "mediatek,mtk-xhci",
+	soc-model is the name of SoC, such as mt8173, mt2712 etc, when using
+	"mediatek,mtk-xhci" compatible string, you need SoC specific ones in
+	addition, one of:
+	- "mediatek,mt8173-xhci"
  - reg : specifies physical base address and size of the registers
  - reg-names: should be "mac" for xHCI MAC
  - interrupts : interrupt used by the host controller
diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt b/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
index 545251e..722a029 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
@@ -48,7 +48,7 @@ Optional properties:
 Sub-nodes:
 The xhci should be added as subnode to mtu3 as shown in the following example
 if host mode is enabled. The DT binding details of xhci can be found in:
-Documentation/devicetree/bindings/usb/mt8173-xhci.txt
+Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
 
 Example:
 ssusb: usb at 11271000 {
-- 
1.7.9.5
