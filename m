From: krishna.md@samsung.com (Krishna Mohan Dani)
Date: Mon, 27 Oct 2014 11:41:08 +0530
Subject: [PATCH 1/4] ASoC: ALC5631: Add device tree binding documentation
In-Reply-To: <1414390271-25040-1-git-send-email-krishna.md@samsung.com>
References: <1414390271-25040-1-git-send-email-krishna.md@samsung.com>
Message-ID: <1414390271-25040-2-git-send-email-krishna.md@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the device tree binding for the ALC5631 codec and update vendor
specific prefix for the Realtek.

Signed-off-by: Krishna Mohan Dani <krishna.md@samsung.com>
---
 Documentation/devicetree/bindings/sound/rt5631.txt |   41 ++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rt5631.txt

diff --git a/Documentation/devicetree/bindings/sound/rt5631.txt b/Documentation/devicetree/bindings/sound/rt5631.txt
new file mode 100644
index 0000000..9e68c4d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rt5631.txt
@@ -0,0 +1,41 @@
+ALC5631 audio CODEC
+
+This device supports I2C only.
+
+Required properties:
+
+  - compatible : "realtek,alc5631"
+
+  - reg : the I2C address of the device.
+
+Pins on the device (for linking into audio routes):
+
+  * SPK_OUT_R_P
+  * SPK_OUT_R_N
+  * SPK_OUT_L_P
+  * SPK_OUT_L_N
+  * HP_OUT_L
+  * HP_OUT_R
+  * AUX_OUT2_LP
+  * AUX_OUT2_RN
+  * AUX_OUT1_LP
+  * AUX_OUT1_RN
+  * AUX_IN_L_JD
+  * AUX_IN_R_JD
+  * MONO_IN_P
+  * MONO_IN_N
+  * MIC1_P
+  * MIC1_N
+  * MIC2_P
+  * MIC2_N
+  * MONO_OUT_P
+  * MONO_OUT_N
+  * MICBIAS1
+  * MICBIAS2
+
+Example:
+
+alc5631: alc5631 at 1e {
+	compatible = "realtek,alc5631";
+	reg = <0x1a>;
+};
-- 
1.7.9.5
