From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sat, 13 Oct 2018 09:53:24 -0700
Subject: [PATCH v2 4/9] ASoC: dt-binding: Add bindings for Allwinner A64
 codec's analog path controls
In-Reply-To: <20181013165329.13363-1-anarsoul@gmail.com>
References: <20181013165329.13363-1-anarsoul@gmail.com>
Message-ID: <20181013165329.13363-5-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The internal codec on Allwinner A64 is split into 2 parts. The
analog path controls are routed through an embedded custom register
bus accessed through the PRCM block just as on A23/A33/H3.

Add a binding for this hardware.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 .../bindings/sound/sun50i-codec-analog.txt           | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt

diff --git a/Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt b/Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt
new file mode 100644
index 000000000000..4f8ad0e04d20
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt
@@ -0,0 +1,12 @@
+* Allwinner A64 Codec Analog Controls
+
+Required properties:
+- compatible: must be one of the following compatibles:
+		- "allwinner,sun50i-a64-codec-analog"
+- reg: must contain the registers location and length
+
+Example:
+	codec_analog: codec-analog at 1f015c0 {
+		compatible = "allwinner,sun50i-a64-codec-analog";
+		reg = <0x01f015c0 0x4>;
+	};
-- 
2.19.0
