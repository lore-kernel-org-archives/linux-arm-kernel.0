From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue,  6 Mar 2018 14:56:01 +0100
Subject: [PATCH v3 4/7] dt-bindings: panel: Add the Ilitek ILI9881c panel
 documentation
In-Reply-To: <cover.14d017af44a2140bea674731b60a0dd7f992f5f6.1520344489.git-series.maxime.ripard@bootlin.com>
References: <cover.14d017af44a2140bea674731b60a0dd7f992f5f6.1520344489.git-series.maxime.ripard@bootlin.com>
Message-ID: <98f6b4c0746a0d244d009263e8b3e20f40ac280f.1520344489.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Ripard <maxime.ripard@free-electrons.com>

The LHR050H41 from BananaPi is a 1280x700 4-lanes DSI panel based on the
ILI9881c from Ilitek.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.txt | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.txt

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.txt b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.txt
new file mode 100644
index 000000000000..df05e8bb4851
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.txt
@@ -0,0 +1,20 @@
+Ilitek ILI9881c based MIPI-DSI panels
+
+Required properties:
+  - compatible: must be "ilitek,ili9881c" and one of:
+    * "bananapi,lhr050h41"
+  - reg: DSI virtual channel used by that screen
+  - power-gpios: a GPIO phandle for the power pin
+  - reset-gpios: a GPIO phandle for the reset pin
+
+Optional properties:
+  - backlight: phandle to the backlight used
+
+Example:
+panel at 0 {
+	compatible = "bananapi,lhr050h41", "ilitek,ili9881c";
+	reg = <0>;
+	power-gpios = <&pio 1 7 GPIO_ACTIVE_HIGH>; /* PB07 */
+	reset-gpios = <&r_pio 0 5 GPIO_ACTIVE_LOW>; /* PL05 */
+	backlight = <&pwm_bl>;
+};
-- 
git-series 0.9.1
