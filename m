From: jbrunet@baylibre.com (Jerome Brunet)
Date: Sun, 26 Mar 2017 19:19:22 +0200
Subject: [PATCH v2 7/8] ARM64: dts: meson-gxl: add i2s output pins
In-Reply-To: <20170326171923.19269-1-jbrunet@baylibre.com>
References: <20170326171923.19269-1-jbrunet@baylibre.com>
Message-ID: <20170326171923.19269-8-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add EE and AO domains pins for the i2s output clocks and data the gxl
device tree

Acked-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 62 ++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 269458b05fd4..3dde55856234 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -160,6 +160,20 @@
 				function = "pwm_ao_b";
 			};
 		};
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
 
@@ -385,6 +399,54 @@
 				function = "hdmi_i2c";
 			};
 		};
+
+		i2s_am_clk_pins: i2s_am_clk {
+			mux {
+				groups = "i2s_am_clk";
+				function = "i2s_out";
+			};
+		};
+
+		i2s_out_ao_clk_pins: i2s_out_ao_clk {
+			mux {
+				groups = "i2s_out_ao_clk";
+				function = "i2s_out";
+			};
+		};
+
+		i2s_out_lr_clk_pins: i2s_out_lr_clk {
+			mux {
+				groups = "i2s_out_lr_clk";
+				function = "i2s_out";
+			};
+		};
+
+		i2s_out_ch01_pins: i2s_out_ch01 {
+			mux {
+				groups = "i2s_out_ch01";
+				function = "i2s_out";
+			};
+		};
+		i2sout_ch23_z_pins: i2sout_ch23_z {
+			mux {
+				groups = "i2sout_ch23_z";
+				function = "i2s_out";
+			};
+		};
+
+		i2sout_ch45_z_pins: i2sout_ch45_z {
+			mux {
+				groups = "i2sout_ch45_z";
+				function = "i2s_out";
+			};
+		};
+
+		i2sout_ch67_z_pins: i2sout_ch67_z {
+			mux {
+				groups = "i2sout_ch67_z";
+				function = "i2s_out";
+			};
+		};
 	};
 
 	eth-phy-mux {
-- 
2.9.3
