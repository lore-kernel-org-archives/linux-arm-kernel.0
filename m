From: mylene.josserand@free-electrons.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Tue,  4 Oct 2016 11:46:21 +0200
Subject: [PATCH 08/14] dt-bindings: sound: Add sun8i analog codec documentation
In-Reply-To: <cover.1475569400.git.mylene.josserand@free-electrons.com>
References: <cover.1475569400.git.mylene.josserand@free-electrons.com>
Message-ID: <06ea14939405c3eb0fb9be655d26ee564a04a53d.1475571575.git.mylene.josserand@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the documentation for dt-binding of the analog audiocodec
driver for SUN8I SoC.

Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
---
 .../devicetree/bindings/sound/sun8i-codec-analog.txt | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt

diff --git a/Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt b/Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt
new file mode 100644
index 0000000..a03ec20
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt
@@ -0,0 +1,20 @@
+* Allwinner A23/A33 Analog Codec
+
+This codec must be handled as a PRCM subnode.
+
+Required properties:
+- compatible: must be either "allwinner,sun8i-codec-analog"
+- interrupts: must contain the codec interrupt
+- clocks: a list of phandle + clock-specifer pairs, one for each entry
+  in clock-names.
+- clock-names: should contain followings:
+   - "apb": the parent APB clock for this controller
+   - "codec": the parent module clock
+
+Example, in your prcm subnode:
+codec_analog: codec_analog {
+	compatible = "allwinner,sun8i-codec-analog";
+	interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;
+	clock-names = "apb", "codec";
+};
-- 
2.9.3
