From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 21 Feb 2018 10:20:31 +0100
Subject: [PATCH v2 07/10] dt-bindings: panel: Add Huarui LHR050H41 panel
 documentation
In-Reply-To: <cover.68c39205c8726547449e3df67b549d89380e51a2.1519204731.git-series.maxime.ripard@bootlin.com>
References: <cover.68c39205c8726547449e3df67b549d89380e51a2.1519204731.git-series.maxime.ripard@bootlin.com>
Message-ID: <25495bb5034ae6a00442e10eb08254c26c213dda.1519204731.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Ripard <maxime.ripard@free-electrons.com>

The LHR050H41 is a 1280x700 4-lanes DSI panel.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/devicetree/bindings/display/panel/huarui,lhr050h41.txt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/huarui,lhr050h41.txt

diff --git a/Documentation/devicetree/bindings/display/panel/huarui,lhr050h41.txt b/Documentation/devicetree/bindings/display/panel/huarui,lhr050h41.txt
new file mode 100644
index 000000000000..b254db4d29c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/huarui,lhr050h41.txt
@@ -0,0 +1,19 @@
+Huarui LHR050H41 MIPI-DSI panel
+
+Required properties:
+  - compatible: "huarui,lhr050h41"
+  - reg: DSI virtual channel used by that screen
+  - power-gpios: a GPIO phandle for the power pin
+  - reset-gpios: a GPIO phandle for the reset pin
+
+Optional properties:
+  - backlight: phandle to the backlight used
+
+Example:
+panel at 0 {
+	compatible = "huarui,lhr050h41";
+	reg = <0>;
+	power-gpios = <&pio 1 7 GPIO_ACTIVE_HIGH>; /* PB07 */
+	reset-gpios = <&r_pio 0 5 GPIO_ACTIVE_LOW>; /* PL05 */
+	backlight = <&pwm_bl>;
+};
-- 
git-series 0.9.1
