From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue,  4 Oct 2016 17:08:23 +0200
Subject: [RFC 05/10] dt-bindings: pinctrl: meson: update gpio dt-bindings
In-Reply-To: <1475593708-10526-1-git-send-email-jbrunet@baylibre.com>
References: <1475593708-10526-1-git-send-email-jbrunet@baylibre.com>
Message-ID: <1475593708-10526-6-git-send-email-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add description for the interrupt-parent property of the gpio sub-node
If provided here, this property must be a phandle to an interrupt
controller suitable for meson pinctrl, like the meson gpio interrupt
controller.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
index fe7fe0b03cfb..39932c4dfb32 100644
--- a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
@@ -23,6 +23,10 @@ Required properties for sub-nodes are:
  - gpio-controller: identifies the node as a gpio controller
  - #gpio-cells: must be 2
 
+Optional property for sub-nodes is:
+ - interrupt-parent: must be a phandle to the meson gpio interrupt controller.
+   if this property is provided, enables gpio ability to generate interrupts
+
 === Other sub-nodes ===
 
 Child nodes without the "gpio-controller" represent some desired
-- 
2.7.4
