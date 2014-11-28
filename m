From: josh.wu@atmel.com (Josh Wu)
Date: Fri, 28 Nov 2014 18:28:27 +0800
Subject: [PATCH 4/4] media: ov2640: dt: add the device tree binding document
In-Reply-To: <1417170507-11172-1-git-send-email-josh.wu@atmel.com>
References: <1417170507-11172-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1417170507-11172-5-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the document for ov2640 dt.

Cc: devicetree at vger.kernel.org
Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
 .../devicetree/bindings/media/i2c/ov2640.txt       | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ov2640.txt

diff --git a/Documentation/devicetree/bindings/media/i2c/ov2640.txt b/Documentation/devicetree/bindings/media/i2c/ov2640.txt
new file mode 100644
index 0000000..adec147
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/ov2640.txt
@@ -0,0 +1,43 @@
+* Omnivision ov2640 CMOS sensor
+
+The Omnivision OV2640 sensor support multiple resolutions output, such as
+CIF, SVGA, UXGA. It also can support YUV422/420, RGB565/555 or raw RGB
+output format.
+
+Required Properties :
+- compatible      : Must be "omnivision,ov2640"
+- reset-gpio      : reset pin
+- power-down-gpio : power down pin
+
+Optional Properties:
+- clocks          : reference master clock, if using external fixed clock, you
+                    no need to have such property.
+- clock-names     : Must be "mck", it means the master clock for ov2640.
+
+For further reading of port node refer Documentation/devicetree/bindings/media/
+video-interfaces.txt.
+
+Example:
+
+	i2c1: i2c at f0018000 {
+		ov2640: camera at 0x30 {
+			compatible = "omnivision,ov2640";
+			reg = <0x30>;
+
+			... ...
+
+			reset-gpio = <&pioE 24 GPIO_ACTIVE_HIGH>;
+			power-down-gpio = <&pioE 29 GPIO_ACTIVE_HIGH>;
+
+			/* use pck1 for the master clock of ov2640 */
+			clocks = <&pck1>;
+			clock-names = "mck";
+
+			port {
+				ov2640_0: endpoint {
+					remote-endpoint = <&isi_0>;
+					bus-width = <8>;
+				};
+			};
+		};
+	};
-- 
1.9.1
