From: khilman@baylibre.com (Kevin Hilman)
Date: Fri,  2 Jun 2017 16:43:59 -0700
Subject: [PATCH/RFT 1/3] ARM: dts: da850-evm: VPIF input selction via GPIO hogs
In-Reply-To: <20170602234401.24721-1-khilman@baylibre.com>
References: <20170602234401.24721-1-khilman@baylibre.com>
Message-ID: <20170602234401.24721-2-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Force VPIF input selection to use composite video input.
---
 arch/arm/boot/dts/da850-evm.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index 67e72bc72e80..cbbf2c0d0269 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -302,3 +302,27 @@
 	pinctrl-0 = <&vpif_capture_pins>, <&vpif_display_pins>;
 	status = "okay";
 };
+
+/* UI board: VPIF input selection */
+&tca6416 {
+	 status = "okay";
+
+	 sel_a {
+		gpio-hog;
+		gpios = <7 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "ADC_ENn";
+	 };
+	 sel_b {
+		gpio-hog;
+		gpios = <6 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "CAMERA_ENn";
+	 };
+	 sel_c {
+		gpio-hog;
+		gpios = <5 GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "VIDEO_IN_ENn";
+	 };
+};
-- 
2.9.3
