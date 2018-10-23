From: jagan@amarulasolutions.com (Jagan Teki)
Date: Tue, 23 Oct 2018 21:20:30 +0530
Subject: [PATCH v2 10/15] dt-bindings: panel: Add Bananapi S070WV20-CT16
 ICN6211 MIPI-DSI to RGB bridge
In-Reply-To: <20181023155035.9101-1-jagan@amarulasolutions.com>
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
Message-ID: <20181023155035.9101-11-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bananapi S070WV20-CT16 ICN6211 is 800x480, 4-lane MIPI-DSI to RGB bridge panel,
the same panel PCB comes with parallel RBG which is supported via
panel-simple driver with "bananapi,s070wv20-ct16" compatible.

But this binding is specific for MIPI DSI to RGB bridge panels,
which usually accessed using MIPI DSI controller driver.

for information:
- "bananapi,s070wv20-ct16" compatible for parallel RGB panels
- "bananapi,s070wv20-ct16-icn6211" compatible for MIPI-DSI to RGB
bridge panels

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- Add detailed commit message
- Update the bindings as MIPI-DSI to RGB bridge

 .../panel/bananapi,s070wv20-ct16-icn6211.txt  | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16-icn6211.txt

diff --git a/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16-icn6211.txt b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16-icn6211.txt
new file mode 100644
index 000000000000..68a89b6feaee
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16-icn6211.txt
@@ -0,0 +1,21 @@
+Bananapi S070WV20-CT16 ICN6211 MIPI-DSI to RGB bridge
+
+Required properties:
+- compatible: must be "bananapi,s070wv20-ct16-icn6211"
+- reg: DSI virtual channel used by that screen
+- avdd-supply: analog regulator dc1 switch
+- dvdd-supply: 3v3 digital regulator
+- reset-gpios: a GPIO phandle for the reset pin
+
+Optional properties:
+- backlight: phandle for the backlight control.
+
+Example:
+panel at 0 {
+	compatible = "bananapi,s070wv20-ct16-icn6211";
+	reg = <0>;
+	avdd-supply = <&reg_dc1sw>;
+	dvdd-supply = <&reg_dldo1>;
+	reset-gpios = <&pio 3 6 GPIO_ACTIVE_HIGH>; /* PD6 */
+	backlight = <&backlight_dsi>;
+};
-- 
2.18.0.321.gffc6fa0e3
