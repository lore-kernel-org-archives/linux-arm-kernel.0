From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Tue, 29 Aug 2017 17:20:43 +0800
Subject: [PATCH RESEND v2 3/3] dt-bindings: mt8173-mtu3: add generic
 compatible and rename file
In-Reply-To: <33fa448238c0d95f0cfd6c2be3bd5c4e657a0cd4.1503998338.git.chunfeng.yun@mediatek.com>
References: <33fa448238c0d95f0cfd6c2be3bd5c4e657a0cd4.1503998338.git.chunfeng.yun@mediatek.com>
Message-ID: <61060035e057b13f43d383645c53c8726b7e67ab.1503998339.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mt8173-mtu3.txt actually holds the bindings for all mediatek
SoCs with usb3 DRD IP, so add a generic compatible and change the
name to mediatek,mtu3.txt.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../usb/{mt8173-mtu3.txt => mediatek,mtu3.txt}     |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/usb/{mt8173-mtu3.txt => mediatek,mtu3.txt} (92%)

diff --git a/Documentation/devicetree/bindings/usb/mt8173-mtu3.txt b/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
similarity index 92%
rename from Documentation/devicetree/bindings/usb/mt8173-mtu3.txt
rename to Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
index b8ea394..722a029 100644
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
