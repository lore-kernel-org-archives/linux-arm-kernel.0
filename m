From: arnaud.pouliquen@st.com (Arnaud Pouliquen)
Date: Tue, 28 Nov 2017 16:05:49 +0100
Subject: [PATCH v5 05/13] IIO: Add DT bindings for sigma delta adc modulator
In-Reply-To: <1511881557-28596-1-git-send-email-arnaud.pouliquen@st.com>
References: <1511881557-28596-1-git-send-email-arnaud.pouliquen@st.com>
Message-ID: <1511881557-28596-6-git-send-email-arnaud.pouliquen@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation of device tree bindings to support
sigma delta modulator in IIO framework.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/iio/adc/sigma-delta-modulator.txt   | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
new file mode 100644
index 0000000..e9ebb8a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
@@ -0,0 +1,13 @@
+Device-Tree bindings for sigma delta modulator
+
+Required properties:
+- compatible: should be "ads1201", "sd-modulator". "sd-modulator" can be use
+	as a generic SD modulator if modulator not specified in compatible list.
+- #io-channel-cells = <1>: See the IIO bindings section "IIO consumers".
+
+Example node:
+
+	ads1202: adc at 0 {
+		compatible = "sd-modulator";
+		#io-channel-cells = <1>;
+	};
-- 
2.7.4
