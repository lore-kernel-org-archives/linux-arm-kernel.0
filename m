From: arnaud.pouliquen@st.com (Arnaud Pouliquen)
Date: Mon, 13 Feb 2017 17:38:24 +0100
Subject: [RFC v2 2/7] IIO: Add bindings for simple sigma delta adc
In-Reply-To: <1487003909-11710-1-git-send-email-arnaud.pouliquen@st.com>
References: <1487003909-11710-1-git-send-email-arnaud.pouliquen@st.com>
Message-ID: <1487003909-11710-3-git-send-email-arnaud.pouliquen@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation of device tree bindings to support
sigma delta modulator in IIO framework.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 Documentation/devicetree/bindings/iio/adc/simple_sd_adc.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/simple_sd_adc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/simple_sd_adc.txt b/Documentation/devicetree/bindings/iio/adc/simple_sd_adc.txt
new file mode 100644
index 0000000..2b3968a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/simple_sd_adc.txt
@@ -0,0 +1,13 @@
+Device-Tree bindings for simple sigma delta adc
+
+Required properties:
+- compatible: should be "sd-modulator".
+- #io-channel-cells = <1>: See the IIO bindings section "IIO consumers".
+
+Example node:
+
+	ads1202: simple_sd_adc at 0 {
+		compatible = "sd-modulator";
+		#io-channel-cells = <1>;
+		status = "okay";
+	};
-- 
1.9.1
