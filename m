From: lars.persson@axis.com (Lars Persson)
Date: Thu, 11 Feb 2016 15:04:35 +0100
Subject: [PATCH v2 1/8] clk: add device tree binding for artpec-6 pll1 clock
In-Reply-To: <cover.1455198819.git.larper@axis.com>
References: <cover.1455198819.git.larper@axis.com>
Message-ID: <2686b3bbb9ec1c86828b365645bd7f997a9780b4.1455198819.git.larper@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree documentation for the main PLL in the Artpec-6 SoC.

Signed-off-by: Lars Persson <larper@axis.com>
---
 Documentation/devicetree/bindings/clock/artpec6.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/artpec6.txt

diff --git a/Documentation/devicetree/bindings/clock/artpec6.txt b/Documentation/devicetree/bindings/clock/artpec6.txt
new file mode 100644
index 0000000..521fec8
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/artpec6.txt
@@ -0,0 +1,16 @@
+* Clock bindings for Axis ARTPEC-6 chip
+
+Required properties:
+- #clock-cells: Should be <0>
+- compatible: Should be "axis,artpec6-pll1-clock"
+- reg: Address and length of the DEVSTAT register.
+- clocks: The PLL's input clock.
+
+Examples:
+
+pll1_clk: pll1_clk {
+	#clock-cells = <0>;
+	compatible = "axis,artpec6-pll1-clock";
+	reg = <0xf8000000 4>;
+	clocks = <&ext_clk>;
+};
-- 
2.1.4
