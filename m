From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Fri, 3 Mar 2017 21:56:22 +0800
Subject: [PATCH v5 1/4] dt-bindings: leds: Add document bindings for
 leds-mt6323
In-Reply-To: <1488549385-19899-1-git-send-email-sean.wang@mediatek.com>
References: <1488549385-19899-1-git-send-email-sean.wang@mediatek.com>
Message-ID: <1488549385-19899-2-git-send-email-sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

This patch adds documentation for devicetree bindings
for LED support on MT6323 PMIC

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../devicetree/bindings/leds/leds-mt6323.txt       | 63 ++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-mt6323.txt

diff --git a/Documentation/devicetree/bindings/leds/leds-mt6323.txt b/Documentation/devicetree/bindings/leds/leds-mt6323.txt
new file mode 100644
index 0000000..135c441
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-mt6323.txt
@@ -0,0 +1,63 @@
+Device Tree Bindings for LED support on MT6323 PMIC
+
+MT6323 LED controller is subfunction provided by
+MT6323 PMIC, so the LED controllers are defined as
+the subnode of the function node provided by MT6323
+PMIC controller that is being defined as one kind of
+Muti-Function Device (MFD) using shared bus called
+PMIC wrapper for each subfunction to access remote
+MT6323 PMIC hardware.
+
+For MT6323 MFD bindings see:
+Documentation/devicetree/bindings/mfd/mt6397.txt
+For MediaTek PMIC wrapper bindings see:
+Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
+
+There's sub-node for the LED controller that describes
+the initial behavior for each LED physically and currently
+only four LED sub-nodes can be supported.
+
+Required properties:
+- compatible : Must be "mediatek,mt6323-led"
+- address-cells : Must be 1
+- size-cells : Must be 0
+
+LED sub-node properties:
+- reg : LED channel number (0..3)
+- label : (optional)
+  see Documentation/devicetree/bindings/leds/common.txt
+- linux,default-trigger : (optional)
+  see Documentation/devicetree/bindings/leds/common.txt
+- default-state: (optional) The initial state of the LED
+  see Documentation/devicetree/bindings/leds/common.txt
+
+Example:
+
+	pmic: mt6323 {
+		compatible = "mediatek,mt6323";
+
+		...
+
+		mt6323led: leds {
+			compatible = "mediatek,mt6323-led";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			led at 0 {
+				reg = <0>;
+				label = "LED0";
+				linux,default-trigger = "timer";
+				default-state = "on";
+			};
+			led at 1 {
+				reg = <1>;
+				label = "LED1";
+				default-state = "off";
+			};
+			led at 2 {
+				reg = <2>;
+				label = "LED2";
+				default-state = "on";
+			};
+		};
+	};
-- 
1.9.1
