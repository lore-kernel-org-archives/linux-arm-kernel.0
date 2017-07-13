From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 13 Jul 2017 16:13:09 +0200
Subject: [PATCH 14/18] dt-bindings: panel: Add Huarui LHR050H41 panel
 documentation
In-Reply-To: <cover.a5e7407c191c66e264164d017f64582039c56acb.1499955058.git-series.maxime.ripard@free-electrons.com>
References: <cover.a5e7407c191c66e264164d017f64582039c56acb.1499955058.git-series.maxime.ripard@free-electrons.com>
Message-ID: <5c1df0e5171fd2fb0e4536e88363eeb8c8382b80.1499955058.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LHR050H41 is a 1280x700 4-lanes DSI panel.

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
