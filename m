From: narmstrong@baylibre.com (Neil Armstrong)
Date: Sun, 18 Nov 2018 14:53:10 +0100
Subject: [PATCH v3 1/3] dt-bindings: amlogic: Add Internal Clock Measurer
 bindings
In-Reply-To: <20181118135024.30720-1-narmstrong@baylibre.com>
References: <20181118135024.30720-1-narmstrong@baylibre.com>
Message-ID: <20181118135310.31458-1-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Amlogic Meson SoCs embeds a clock measurer IP to measure the internal
clock paths frequencies.

Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
Rob,

I didn't take your v2 Reviewed-by since I changed the compatible list,
tell me if i can still keep the tag.
 
Thanks,
Neil

 .../bindings/soc/amlogic/clk-measure.txt       | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt

diff --git a/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt b/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
new file mode 100644
index 000000000000..205a54bcd7c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
@@ -0,0 +1,18 @@
+Amlogic Internal Clock Measurer
+===============================
+
+The Amlogic SoCs contains an IP to measure the internal clocks.
+The precision is multiple of MHz, useful to debug the clock states.
+
+Required properties:
+- compatible: Shall contain one of the following :
+			"amlogic,meson-gx-clk-measure" for GX SoCs
+			"amlogic,meson8-clk-measure" for Meson8 SoCs
+			"amlogic,meson8b-clk-measure" for Meson8b SoCs
+- reg: base address and size of the Clock Measurer register space.
+
+Example:
+	clock-measure at 8758 {
+		compatible = "amlogic,meson-gx-clk-measure";
+		reg = <0x0 0x8758 0x0 0x10>;
+	};
-- 
2.19.1
