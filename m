From: hongzhou.yang@mediatek.com (Hongzhou Yang)
Date: Mon, 18 May 2015 23:11:12 -0700
Subject: [PATCH v2 01/11] dt-bindings: mediatek: Modify pinctrl bindings for
 mt6397.
In-Reply-To: <1432015882-8646-1-git-send-email-hongzhou.yang@mediatek.com>
References: <1432015882-8646-1-git-send-email-hongzhou.yang@mediatek.com>
Message-ID: <1432015882-8646-2-git-send-email-hongzhou.yang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 6397 is no need to support interrupt controller,
moving interrupt controller relate property to optional list.
Also adding mt8173 and mt8127 to bindings.

Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
---
 .../devicetree/bindings/pinctrl/pinctrl-mt65xx.txt |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt
index 5868a0f..0480bc3 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt
@@ -3,9 +3,11 @@
 The Mediatek's Pin controller is used to control SoC pins.
 
 Required properties:
-- compatible: value should be either of the following.
+- compatible: value should be one of the following.
     (a) "mediatek,mt8135-pinctrl", compatible with mt8135 pinctrl.
-- mediatek,pctl-regmap: Should be a phandle of the syscfg node.
+    (b) "mediatek,mt8173-pinctrl", compatible with mt8173 pinctrl.
+    (c) "mediatek,mt6397-pinctrl", compatible with mt6397 pinctrl.
+    (d) "mediatek,mt8127-pinctrl", compatible with mt8127 pinctrl.
 - pins-are-numbered: Specify the subnodes are using numbered pinmux to
   specify pins.
 - gpio-controller : Marks the device node as a gpio controller.
@@ -24,6 +26,9 @@ Required properties:
             Only the following flags are supported:
             0 - GPIO_ACTIVE_HIGH
             1 - GPIO_ACTIVE_LOW
+
+Optional properties:
+- mediatek,pctl-regmap: Should be a phandle of the syscfg node.
 - reg: physicall address base for EINT registers
 - interrupt-controller: Marks the device node as an interrupt controller
 - #interrupt-cells: Should be two.
-- 
1.7.9.5
