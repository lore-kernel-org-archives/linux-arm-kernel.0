From: jbrunet@baylibre.com (Jerome Brunet)
Date: Sun, 26 Mar 2017 19:19:20 +0200
Subject: [PATCH v2 5/8] ARM64: dts: meson-gxbb: add i2s output pins
In-Reply-To: <20170326171923.19269-1-jbrunet@baylibre.com>
References: <20170326171923.19269-1-jbrunet@baylibre.com>
Message-ID: <20170326171923.19269-6-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add EE and AO domains pins for the i2s output clocks and data to the gxbb
device tree.

Acked-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 63 +++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 34168a3b0dd1..a9cacbd6a1d6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -192,6 +192,48 @@
 				function = "pwm_ao_b";
 			};
 		};
+
+		i2s_am_clk_pins: i2s_am_clk {
+			mux {
+				groups = "i2s_am_clk";
+				function = "i2s_out_ao";
+			};
+		};
+
+		i2s_out_ao_clk_pins: i2s_out_ao_clk {
+			mux {
+				groups = "i2s_out_ao_clk";
+				function = "i2s_out_ao";
+			};
+		};
+
+		i2s_out_lr_clk_pins: i2s_out_lr_clk {
+			mux {
+				groups = "i2s_out_lr_clk";
+				function = "i2s_out_ao";
+			};
+		};
+
+		i2s_out_ch01_ao_pins: i2s_out_ch01_ao {
+			mux {
+				groups = "i2s_out_ch01_ao";
+				function = "i2s_out_ao";
+			};
+		};
+
+		i2s_out_ch23_ao_pins: i2s_out_ch23_ao {
+			mux {
+				groups = "i2s_out_ch23_ao";
+				function = "i2s_out_ao";
+			};
+		};
+
+		i2s_out_ch45_ao_pins: i2s_out_ch45_ao {
+			mux {
+				groups = "i2s_out_ch45_ao";
+				function = "i2s_out_ao";
+			};
+		};
 	};
 };
 
@@ -432,6 +474,27 @@
 				function = "hdmi_i2c";
 			};
 		};
+
+		i2sout_ch23_y_pins: i2sout_ch23_y {
+			mux {
+				groups = "i2sout_ch23_y";
+				function = "i2s_out";
+			};
+		};
+
+		i2sout_ch45_y_pins: i2sout_ch45_y {
+			mux {
+				groups = "i2sout_ch45_y";
+				function = "i2s_out";
+			};
+		};
+
+		i2sout_ch67_y_pins: i2sout_ch67_y {
+			mux {
+				groups = "i2sout_ch67_y";
+				function = "i2s_out";
+			};
+		};
 	};
 };
 
-- 
2.9.3
