From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Tue, 27 Jun 2017 11:11:08 +0900
Subject: [PATCH v3 1/3] dt-bindings: Add support for samsung s6e63j0x03
 panel binding
In-Reply-To: <1498529470-20652-1-git-send-email-hoegeun.kwon@samsung.com>
References: <1498529470-20652-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170627021124epcas5p1715e8cfd3f61c79d424cf1901888fecd@epcas5p1.samsung.com>
Message-ID: <1498529470-20652-2-git-send-email-hoegeun.kwon@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Samsung s6e63j0x03 is a 1.63" 320x320 AMOLED panel connected using
MIPI-DSI interfaces.

Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/display/panel/samsung,s6e63j0x03.txt  | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6e63j0x03.txt

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e63j0x03.txt b/Documentation/devicetree/bindings/display/panel/samsung,s6e63j0x03.txt
new file mode 100644
index 0000000..3f1a839
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e63j0x03.txt
@@ -0,0 +1,24 @@
+Samsung S6E63J0X03 1.63" 320x320 AMOLED panel (interface: MIPI-DSI command mode)
+
+Required properties:
+  - compatible: "samsung,s6e63j0x03"
+  - reg: the virtual channel number of a DSI peripheral
+  - vdd3-supply: I/O voltage supply
+  - vci-supply: voltage supply for analog circuits
+  - reset-gpios: a GPIO spec for the reset pin (active low)
+  - te-gpios: a GPIO spec for the tearing effect synchronization signal
+    gpio pin (active high)
+
+Example:
+&dsi {
+	...
+
+	panel at 0 {
+		compatible = "samsung,s6e63j0x03";
+		reg = <0>;
+		vdd3-supply = <&ldo16_reg>;
+		vci-supply = <&ldo20_reg>;
+		reset-gpios = <&gpe0 1 GPIO_ACTIVE_LOW>;
+		te-gpios = <&gpx0 6 GPIO_ACTIVE_HIGH>;
+	};
+};
-- 
1.9.1
