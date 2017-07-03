From: hugues.fruchet@st.com (Hugues Fruchet)
Date: Mon, 3 Jul 2017 11:16:02 +0200
Subject: [PATCH v2 1/7] DT bindings: add bindings for ov965x camera module
In-Reply-To: <1499073368-31905-1-git-send-email-hugues.fruchet@st.com>
References: <1499073368-31905-1-git-send-email-hugues.fruchet@st.com>
Message-ID: <1499073368-31905-2-git-send-email-hugues.fruchet@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "H. Nikolaus Schaller" <hns@goldelico.com>

This adds documentation of device tree bindings
for the OV965X family camera sensor module.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
---
 .../devicetree/bindings/media/i2c/ov965x.txt       | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ov965x.txt

diff --git a/Documentation/devicetree/bindings/media/i2c/ov965x.txt b/Documentation/devicetree/bindings/media/i2c/ov965x.txt
new file mode 100644
index 0000000..4ceb727
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/ov965x.txt
@@ -0,0 +1,45 @@
+* Omnivision OV9650/9652/9655 CMOS sensor
+
+The Omnivision OV965x sensor support multiple resolutions output, such as
+CIF, SVGA, UXGA. It also can support YUV422/420, RGB565/555 or raw RGB
+output format.
+
+Required Properties:
+- compatible: should be one of
+	"ovti,ov9650"
+	"ovti,ov9652"
+	"ovti,ov9655"
+- clocks: reference to the mclk input clock.
+
+Optional Properties:
+- resetb-gpios: reference to the GPIO connected to the RESETB pin, if any,
+		polarity is active low.
+- pwdn-gpios: reference to the GPIO connected to the PWDN pin, if any,
+		polarity is active high.
+- avdd-supply: reference to the analog power supply regulator connected
+		to the AVDD pin, if any.
+- dvdd-supply: reference to the digital power supply regulator connected
+		to the DVDD pin, if any.
+- dovdd-supply: reference to the digital I/O power supply regulator
+		connected to the DOVDD pin, if any.
+
+The device node must contain one 'port' child node for its digital output
+video port, in accordance with the video interface bindings defined in
+Documentation/devicetree/bindings/media/video-interfaces.txt.
+
+Example:
+
+&i2c2 {
+	ov9655: camera at 30 {
+		compatible = "ovti,ov9655";
+		reg = <0x30>;
+		pwdn-gpios = <&gpioh 13 GPIO_ACTIVE_HIGH>;
+		clocks = <&clk_ext_camera>;
+
+		port {
+			ov9655: endpoint {
+				remote-endpoint = <&dcmi_0>;
+			};
+		};
+	};
+};
-- 
1.9.1
