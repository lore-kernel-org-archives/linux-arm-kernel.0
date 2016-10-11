From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 11 Oct 2016 08:33:56 +0800
Subject: [PATCH 2/5] dt-bindings: add binding for Ilitek ili2139 touchscreen IC
In-Reply-To: <20161011003359.26079-1-icenowy@aosc.xyz>
References: <20161011003359.26079-1-icenowy@aosc.xyz>
Message-ID: <20161011003359.26079-2-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ilitek ili2139 is a touchscreen IC used in several tablet products, for
example, Colorfly E708 Q1.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 .../bindings/input/touchscreen/ilitek_ili2139.txt     | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ilitek_ili2139.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/ilitek_ili2139.txt b/Documentation/devicetree/bindings/input/touchscreen/ilitek_ili2139.txt
new file mode 100644
index 0000000..72d2352
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/ilitek_ili2139.txt
@@ -0,0 +1,19 @@
+* Ilitek ili2139 touchscreen controller
+
+Required properties:
+- compatible		  : "ilitek,ili2139"
+- reg			  : I2C slave address of the chip (0x41)
+- interrupt-parent	  : a phandle pointing to the interrupt controller
+			    serving the interrupt for this chip
+- interrupts		  : interrupt specification for the ili2139 interrupt
+
+Example:
+
+i2c at 00000000 {
+	ili2139: touchscreen at 41 {
+		compatible = "ilitek,ili2139"
+		reg = <0x41>;
+		interrupt-parent = <&pio>;
+		interrupts = <0 3 IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
-- 
2.10.1
