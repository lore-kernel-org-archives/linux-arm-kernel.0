From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 24 Mar 2016 17:50:07 +0100
Subject: [PATCH v3 10/18] dt-bindings: Add PLX Technology OXNAS Standard
 Clocks bindings
In-Reply-To: <1458838215-23314-1-git-send-email-narmstrong@baylibre.com>
References: <1458838215-23314-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1458838215-23314-11-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../devicetree/bindings/clock/plxtech,stdclk.txt   | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/plxtech,stdclk.txt

diff --git a/Documentation/devicetree/bindings/clock/plxtech,stdclk.txt b/Documentation/devicetree/bindings/clock/plxtech,stdclk.txt
new file mode 100644
index 0000000..c60b459
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/plxtech,stdclk.txt
@@ -0,0 +1,35 @@
+PLX Technology OXNAS SoC Family Standard Clocks
+================================================
+
+Please also refer to clock-bindings.txt in this directory for common clock
+bindings usage.
+
+Required properties:
+- compatible: Should be "oxsemi,ox810se-stdclk"
+- #clock-cells: 1, see below
+
+Parent node should have the following properties :
+- compatible: Should be "oxsemi,ox810se-sys-ctrl", "syscon", "simple-mfd"
+
+For OX810SE, the clock indices are :
+ - 0: LEON
+ - 1: DMA_SGDMA
+ - 2: CIPHER
+ - 3: SATA
+ - 4: AUDIO
+ - 5: USBMPH
+ - 6: ETHA
+ - 7: PCIA
+ - 8: NAND
+
+example:
+
+sys: sys-ctrl at 000000 {
+	compatible = "oxsemi,ox810se-sys-ctrl", "syscon", "simple-mfd";
+	reg = <0x000000 0x100000>;
+
+	stdclk: stdclk {
+		compatible = "oxsemi,ox810se-stdclk";
+		#clock-cells = <1>;
+	};
+};
-- 
1.9.1
