From: Li.Xiubo@freescale.com (Xiubo Li)
Date: Thu, 17 Oct 2013 17:01:17 +0800
Subject: [PATCHv1 8/8] Documentation: Add device tree bindings for Freescale
 VF610 sound.
In-Reply-To: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <1382000477-17304-9-git-send-email-Li.Xiubo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the Document for Freescale VF610 sound driver under
Documentation/devicetree/bindings/sound/.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 .../devicetree/bindings/sound/fsl-sgtl5000.txt     | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl-sgtl5000.txt

diff --git a/Documentation/devicetree/bindings/sound/fsl-sgtl5000.txt b/Documentation/devicetree/bindings/sound/fsl-sgtl5000.txt
new file mode 100644
index 0000000..43e350f
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl-sgtl5000.txt
@@ -0,0 +1,52 @@
+Freescale VF610 audio complex with SGTL5000 codec
+
+Required properties:
+- compatible: "fsl,vf610-sgtl5000"
+- model: The user-visible name of this sound complex.
+- saif-controllers: The phandle list of the SAI controller.
+- audio-codec: The phandle of the SGTL5000 audio codec.
+- audio-routing : A list of the connections between audio components.
+  Each entry is a pair of strings, the first being the connection's sink,
+  the second being the connection's source. Valid names could be power
+  supplies, SGTL5000 pins, and the jacks on the board:
+
+  -- Power supplies:
+     * Mic Bias
+
+  -- SGTL5000 pins:
+     * MIC_IN
+     * LINE_IN
+     * HP_OUT
+     * LINE_OUT
+
+  -- Board connectors:
+     * Mic Jack
+     * Line In Jack
+     * Headphone Jack
+     * Line Out Jack
+     * Ext Spk
+
+Example:
+
+sound {
+	compatible = "fsl,vf610-sgtl5000";
+	model = "vf610-sgtl5000";
+	saif-controller = <&sai2>;
+	audio-codec = <&codec>;
+	audio-routing =
+		"MIC_IN", "Mic Jack",
+		"Mic Jack", "Mic Bias",
+		"LINE_IN", "Line In Jack",
+		"Headphone Jack", "HP_OUT",
+		"Ext Spk", "LINE_OUT";
+};
+
+&i2c0 {
+	...
+
+	codec: sgtl5000 at 0a {
+	       compatible = "fsl,sgtl5000";
+	       reg = <0x0a>;
+	       clocks = <&clks VF610_CLK_SAI2>;
+       };
+};
-- 
1.8.0
