From: jbrunet@baylibre.com (Jerome Brunet)
Date: Sun, 26 Mar 2017 19:19:23 +0200
Subject: [PATCH v2 8/8] ARM64: dts: meson-gxl: add spdif output pins
In-Reply-To: <20170326171923.19269-1-jbrunet@baylibre.com>
References: <20170326171923.19269-1-jbrunet@baylibre.com>
Message-ID: <20170326171923.19269-9-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add EE and AO domains pins for the spdif output to the gxl device tree.

Acked-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 3dde55856234..8a08ad552e7a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -174,6 +174,20 @@
 				function = "i2s_out_ao";
 			};
 		};
+
+		spdif_out_ao_6_pins: spdif_out_ao_6 {
+			mux {
+				groups = "spdif_out_ao_6";
+				function = "spdif_out_ao";
+			};
+		};
+
+		spdif_out_ao_9_pins: spdif_out_ao_9 {
+			mux {
+				groups = "spdif_out_ao_9";
+				function = "spdif_out_ao";
+			};
+		};
 	};
 };
 
@@ -447,6 +461,13 @@
 				function = "i2s_out";
 			};
 		};
+
+		spdif_out_h_pins: spdif_out_ao_h {
+			mux {
+				groups = "spdif_out_h";
+				function = "spdif_out";
+			};
+		};
 	};
 
 	eth-phy-mux {
-- 
2.9.3
