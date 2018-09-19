From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Wed, 19 Sep 2018 23:02:18 +0200
Subject: [PATCH 1/2] dt-bindings: pinctrl: document Broadcom Northstar pin mux
 controller
Message-ID: <20180919210219.21921-1-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

Northstar has mux controller just like Northstar Plus and Northstar2.
It's a bit different though (different registers & pins) so it requires
its own binding.

It's needed to allow other block bindings specify required mux setup.

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
 .../devicetree/bindings/pinctrl/brcm,ns-pinmux.txt | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/brcm,ns-pinmux.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,ns-pinmux.txt b/Documentation/devicetree/bindings/pinctrl/brcm,ns-pinmux.txt
new file mode 100644
index 000000000000..0e913721ae9e
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/brcm,ns-pinmux.txt
@@ -0,0 +1,29 @@
+Broadcom Northstar pins mux controller
+
+Some of Northstar SoCs's pins can be used for various purposes thanks to the mux
+controller. This binding allows describing mux controller and listing available
+functions. They can be referenced later by other bindings to let system
+configure controller correctly.
+
+Required properties:
+- compatible: brcm,ns-pinmux
+- reg: iomem address range of CRU (Central Resource Unit) pin registers
+- reg-names: "cru_pins_control" - the only needed & supported reg right now
+
+List of supported functions and their groups:
+- "spi": "spi_grp"
+
+For documentation of subnodes see:
+Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
+
+Example:
+	pinctrl at 1800c1c0 {
+		compatible = "brcm,ns-pinmux";
+		reg = <0x1800c1c0 0x24>;
+		reg-names = "cru_pins_control";
+
+		spi {
+			function = "spi";
+			groups = "spi_grp";
+		};
+	};
-- 
2.13.7
