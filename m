From: jagan@amarulasolutions.com (Jagan Teki)
Date: Tue, 13 Nov 2018 16:46:27 +0530
Subject: [PATCH v4 20/26] dt-bindings: panel: Add Techstar TS8550B MIPI-DSI
 panel
In-Reply-To: <20181113111633.20189-1-jagan@amarulasolutions.com>
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
Message-ID: <20181113111633.20189-21-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Techstar TS8550B MIPI DSI panel is 480x854, 2-lane MIPI DSI
LCD panel. Add dt-bingings for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../display/panel/techstar,ts8550b.txt        | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/techstar,ts8550b.txt

diff --git a/Documentation/devicetree/bindings/display/panel/techstar,ts8550b.txt b/Documentation/devicetree/bindings/display/panel/techstar,ts8550b.txt
new file mode 100644
index 000000000000..9d3056dd8bf9
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/techstar,ts8550b.txt
@@ -0,0 +1,22 @@
+Techstar TS8550B MIPI-DSI LCD Panel
+
+Techstar TS8550B MIPI DSI panel is 480x854, 2-lane MIPI DSI LCD panel.
+
+Required properties:
+- compatible: must be "techstar,ts8550b"
+- reg: DSI virtual channel used by that screen
+- avdd-supply: analog regulator dc1 switch
+- dvdd-supply: 3v3 digital regulator
+- reset-gpios: a GPIO phandle for the reset pin
+
+Optional properties:
+- backlight: phandle for the backlight control.
+
+panel at 0 {
+	compatible = "techstar,ts8550b";
+	reg = <0>;
+	avdd-supply = <&reg_dc1sw>;
+	dvdd-supply = <&reg_dldo2>;
+	reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
+	backlight = <&backlight>;
+};
-- 
2.18.0.321.gffc6fa0e3
