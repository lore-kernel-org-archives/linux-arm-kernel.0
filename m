From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 22 Nov 2016 11:45:49 -0800
Subject: [PATCH 2/4] ARM: dts: davinci: da850: add VPIF
In-Reply-To: <20161122194551.3420-1-khilman@baylibre.com>
References: <20161122194551.3420-1-khilman@baylibre.com>
Message-ID: <20161122194551.3420-3-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add VPIF and VPIF capture nodes to da850.  VPIF capture has two input
channels describe using the standard DT ports and enpoints.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/arm/boot/dts/da850.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 6205917b4f59..e05e2bb834e8 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -453,7 +453,35 @@
 			interrupts = <52>;
 			status = "disabled";
 		};
+
+		vpif: video at 0x00217000 {
+			compatible = "ti,da850-vpif";
+			reg = <0x00217000 0x1000>;
+			status = "disabled";
+		};
+
+		vpif_capture: video-capture at 0x00217000 {
+			compatible = "ti,da850-vpif-capture";
+			reg = <0x00217000 0x1000>;
+			interrupts = <92>;
+			status = "disabled";
+
+			/* VPIF capture: input channels */
+			port {
+				vpif_ch0: endpoint at 0 {
+					  reg = <0>;
+					  bus-width = <8>;
+				};
+
+				vpif_ch1: endpoint at 1 {
+					  reg = <1>;
+					  bus-width = <8>;
+					  data-shift = <8>;
+				};
+			};
+		};
 	};
+
 	aemif: aemif at 68000000 {
 		compatible = "ti,da850-aemif";
 		#address-cells = <2>;
-- 
2.9.3
