From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Fri, 13 Oct 2017 16:26:40 +0800
Subject: [PATCH v2 8/9] dt-bindings: usb: mtk-xhci: add a optional property to
 disable u3ports
In-Reply-To: <994382d16d6bdc0f3d7c11b22f1710252e056e34.1507882470.git.chunfeng.yun@mediatek.com>
References: <994382d16d6bdc0f3d7c11b22f1710252e056e34.1507882470.git.chunfeng.yun@mediatek.com>
Message-ID: <fd8b6099192ddee3b277f5ca3a699c20fb273ffe.1507882470.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new optional property to disable u3ports

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 .../devicetree/bindings/usb/mediatek,mtk-xhci.txt  |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
index 5611a2e..2d9b459 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
@@ -38,6 +38,8 @@ Optional properties:
 	mode;
  - mediatek,syscon-wakeup : phandle to syscon used to access USB wakeup
 	control register, it depends on "mediatek,wakeup-src".
+ - mediatek,u3p-dis-msk : mask to disable u3ports, bit0 for u3port0,
+	bit1 for u3port1, ... etc;
  - vbus-supply : reference to the VBUS regulator;
  - usb3-lpm-capable : supports USB3.0 LPM
  - pinctrl-names : a pinctrl state named "default" must be defined
-- 
1.7.9.5
