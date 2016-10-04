From: mylene.josserand@free-electrons.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Tue,  4 Oct 2016 11:46:22 +0200
Subject: [PATCH 09/14] dt-bindings: sound: Add sun8i codec documentation
In-Reply-To: <cover.1475569400.git.mylene.josserand@free-electrons.com>
References: <cover.1475569400.git.mylene.josserand@free-electrons.com>
Message-ID: <a5b0bdc6b50dfcc2dc0145d00edd08fee3ce7764.1475571575.git.mylene.josserand@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the documentation for dt-binding of the digital audio codec driver
for sun8i SoC.

Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
---
 .../devicetree/bindings/sound/sun8i-codec.txt      | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/sun8i-codec.txt

diff --git a/Documentation/devicetree/bindings/sound/sun8i-codec.txt b/Documentation/devicetree/bindings/sound/sun8i-codec.txt
new file mode 100644
index 0000000..1808869
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/sun8i-codec.txt
@@ -0,0 +1,24 @@
+* Allwinner A23/A33 Codec
+
+Required properties:
+- compatible: must be either "allwinner,sun4i-a23-codec" or
+  "allwinner,sun7i-a33-codec"
+- reg: must contain the registers location and length
+- interrupts: must contain the codec interrupt
+- clocks: a list of phandle + clock-specifer pairs, one for each entry
+  in clock-names.
+- clock-names: should contain followings:
+   - "apb": the parent APB clock for this controller
+   - "codec": the parent module clock
+
+Example:
+codec: codec at 01c22e00 {
+	#sound-dai-cells = <0>;
+	compatible = "allwinner,sun8i-a33-codec";
+	reg = <0x01c22e00 0x400>; /* SUNXI_AUDIO_PBASE + 0x200 */
+	reg-names = "audio";
+	interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;
+	clock-names = "apb", "codec";
+	status = "disabled";
+};
-- 
2.9.3
