From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 16 Aug 2017 14:08:12 +0800
Subject: [PATCH v2 3/4] dt-bindings: mt8173-mtu3: add generic compatible and
 rename file
In-Reply-To: <670f9ce1ecaec5859006b6f02b45cfc72c3cca2c.1502854628.git.chunfeng.yun@mediatek.com>
References: <670f9ce1ecaec5859006b6f02b45cfc72c3cca2c.1502854628.git.chunfeng.yun@mediatek.com>
Message-ID: <2e43d8152c222264eb6c9d8299a824378c35a5a6.1502854628.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mt8173-mtu3.txt actually holds the bindings for all mediatek
SoCs with usb3 DRD IP, so add a generic compatible and change the
name to mediatek,mtu3.txt.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 .../usb/{mt8173-mtu3.txt => mediatek,mtu3.txt}     |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/usb/{mt8173-mtu3.txt => mediatek,mtu3.txt} (92%)

diff --git a/Documentation/devicetree/bindings/usb/mt8173-mtu3.txt b/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
similarity index 92%
rename from Documentation/devicetree/bindings/usb/mt8173-mtu3.txt
rename to Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
index 1d7c3bc..545251e 100644
--- a/Documentation/devicetree/bindings/usb/mt8173-mtu3.txt
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
@@ -1,7 +1,11 @@
 The device node for Mediatek USB3.0 DRD controller
 
 Required properties:
- - compatible : should be "mediatek,mt8173-mtu3"
+ - compatible : should be "mediatek,soc-model-mtu3", "mediatek,mtu3",
+	soc-model is the name of SoC, such as mt8173, mt2712 etc,
+	when using "mediatek,mtu3" compatible string, you need SoC specific
+	ones in addition, one of:
+	- "mediatek,mt8173-mtu3"
  - reg : specifies physical base address and size of the registers
  - reg-names: should be "mac" for device IP and "ippc" for IP port control
  - interrupts : interrupt used by the device IP
-- 
1.7.9.5
