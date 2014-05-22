From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 22 May 2014 13:55:07 +0200
Subject: [PATCH 1/2] doc: dt bindings: Document Odroid X2/U3 audio subsystem
 bindings
Message-ID: <1400759708-25831-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 .../bindings/sound/samsung,odroidx2-max98090.txt   |   32 ++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/samsung,odroidx2-max98090.txt

diff --git a/Documentation/devicetree/bindings/sound/samsung,odroidx2-max98090.txt b/Documentation/devicetree/bindings/sound/samsung,odroidx2-max98090.txt
new file mode 100644
index 0000000..b37e79a
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/samsung,odroidx2-max98090.txt
@@ -0,0 +1,32 @@
+Odroid X2/U3 audio complex
+
+Required properties:
+- compatible		 : "samsung,odroidx2-audio"
+- samsung,i2s-controller : phandle to the I2S controller
+- samsung,audio-codec	 : phandle to the audio codec
+
+Example:
+
+	i2s0: i2s at 03830000 {
+		...
+		clocks = <&clock_audss EXYNOS_I2S_BUS>,
+			 <&clock_audss EXYNOS_DOUT_AUD_BUS>;
+		clock-names = "iis", "i2s_opclk0";
+		status = "okay";
+	};
+
+	i2c at 13870000 {
+		...
+		max98090: max98090 at 10 {
+			compatible = "maxim,max98090";
+			reg = <0x10>;
+			interrupt-parent = <&gpx0>;
+			interrupts = <1 0>;
+		};
+	};
+
+	sound {
+		compatible = "samsung,odroidx2-audio";
+		samsung,i2s-controller = <&i2s0>;
+		samsung,audio-codec = <&max98090>;
+	};
-- 
1.7.9.5
