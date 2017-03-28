From: yannick.fertre@st.com (Yannick Fertre)
Date: Tue, 28 Mar 2017 11:44:48 +0200
Subject: [PATCH v5 05/10] dt-bindings: Add Ampire AM-480272H3TMQW-T01H panel
In-Reply-To: <1490694293-18358-1-git-send-email-yannick.fertre@st.com>
References: <1490694293-18358-1-git-send-email-yannick.fertre@st.com>
Message-ID: <1490694293-18358-6-git-send-email-yannick.fertre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds documentation of device tree bindings for the WVGA panel
Ampire AM-480272H3TMQW-T01H.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
---
 .../display/panel/ampire,am-480272h3tmqw-t01h.txt  | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt

diff --git a/Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt b/Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt
new file mode 100644
index 0000000..6812280
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt
@@ -0,0 +1,26 @@
+Ampire AM-480272H3TMQW-T01H 4.3" WQVGA TFT LCD panel
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
+
+Required properties:
+- compatible: should be "ampire,am-480272h3tmqw-t01h"
+
+Optional properties:
+- power-supply: regulator to provide the supply voltage
+- enable-gpios: GPIO pin to enable or disable the panel
+- backlight: phandle of the backlight device attached to the panel
+
+Optional nodes:
+- Video port for RGB input.
+
+Example:
+	panel_rgb: panel-rgb {
+		compatible = "ampire,am-480272h3tmqw-t01h";
+		enable-gpios = <&gpioa 8 1>;
+		port {
+			panel_in_rgb: endpoint {
+				remote-endpoint = <&controller_out_rgb>;
+			};
+		};
+	};
-- 
1.9.1
