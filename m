From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Wed, 22 Feb 2017 10:09:51 +0900
Subject: [PATCH v10 1/3] dt-bindings: Add support for samsung s6e3ha2 panel
 binding
In-Reply-To: <CGME20170220071000epcas1p3fbc906fa085931b73b895b6724432cd3@epcas1p3.samsung.com>
References: <1487574582-15746-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170220071000epcas1p3fbc906fa085931b73b895b6724432cd3@epcas1p3.samsung.com>
Message-ID: <8e5109d0-6e6f-8bf8-7f9b-b7a5ddcbcf1e@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Samsung s6e3ha2 is a 5.7" 1440x2560 AMOLED panel connected
using MIPI-DSI interfaces.

Signed-off-by: Donghwa Lee <dh09.lee@samsung.com>
Signed-off-by: Hyungwon Hwang <human.hwang@samsung.com>
Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Acked-by: Rob Herring <robh@kernel.org>
---
  .../bindings/display/panel/samsung,s6e3ha2.txt     | 28 
++++++++++++++++++++++
  1 file changed, 28 insertions(+)
  create mode 100644 
Documentation/devicetree/bindings/display/panel/samsung,s6e3ha2.txt

diff --git 
a/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha2.txt 
b/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha2.txt
new file mode 100644
index 0000000..18854f4
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha2.txt
@@ -0,0 +1,28 @@
+Samsung S6E3HA2 5.7" 1440x2560 AMOLED panel
+
+Required properties:
+  - compatible: "samsung,s6e3ha2"
+  - reg: the virtual channel number of a DSI peripheral
+  - vdd3-supply: I/O voltage supply
+  - vci-supply: voltage supply for analog circuits
+  - reset-gpios: a GPIO spec for the reset pin (active low)
+  - enable-gpios: a GPIO spec for the panel enable pin (active high)
+
+Optional properties:
+  - te-gpios: a GPIO spec for the tearing effect synchronization signal
+    gpio pin (active high)
+
+Example:
+&dsi {
+	...
+
+	panel at 0 {
+		compatible = "samsung,s6e3ha2";
+		reg = <0>;
+		vdd3-supply = <&ldo27_reg>;
+		vci-supply = <&ldo28_reg>;
+		reset-gpios = <&gpg0 0 GPIO_ACTIVE_LOW>;
+		enable-gpios = <&gpf1 5 GPIO_ACTIVE_HIGH>;
+		te-gpios = <&gpf1 3 GPIO_ACTIVE_HIGH>;
+	};
+};
-- 
1.9.1
