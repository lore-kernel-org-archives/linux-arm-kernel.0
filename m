From: jagan@amarulasolutions.com (Jagan Teki)
Date: Thu, 27 Sep 2018 17:18:47 +0530
Subject: [PATCH 09/12] dt-bindings: panel: Add Bananapi S070WV20-CT16 MIPI-DSI
 panel bindings
In-Reply-To: <20180927114850.24565-1-jagan@amarulasolutions.com>
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
Message-ID: <20180927114850.24565-10-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bananapi S070WV20-CT16 is 800x480, 4-lane MIPI-DSI panel, the
same panel PCB comes with parallel RBG which is supported via
panel-simple with "bananapi,s070wv20-ct16" compatible.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../panel/bananapi,s070wv20-ct16-dsi.txt      | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16-dsi.txt

diff --git a/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16-dsi.txt b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16-dsi.txt
new file mode 100644
index 000000000000..c477163f7999
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16-dsi.txt
@@ -0,0 +1,21 @@
+Bananapi S070WV20 CT16 MIPI-DSI panel
+
+Required properties:
+- compatible: must be "bananapi,s070wv20-ct16-dsi"
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
+	compatible = "bananapi,s070wv20-ct16-dsi";
+	reg = <0>;
+	avdd-supply = <&reg_dc1sw>;
+	dvdd-supply = <&reg_dldo1>;
+	reset-gpios = <&pio 3 6 GPIO_ACTIVE_HIGH>; /* PD6 */
+	backlight = <&backlight_dsi>;
+};
-- 
2.18.0.321.gffc6fa0e3
