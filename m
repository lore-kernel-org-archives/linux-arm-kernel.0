From: codrin.ciubotariu@microchip.com (Codrin Ciubotariu)
Date: Mon, 6 Aug 2018 14:19:46 +0300
Subject: [PATCH v7 1/3] ARM: dts: at91: sama5d2: add I2S clock muxing nodes
In-Reply-To: <20180806111948.4522-1-codrin.ciubotariu@microchip.com>
References: <20180806111948.4522-1-codrin.ciubotariu@microchip.com>
Message-ID: <20180806111948.4522-2-codrin.ciubotariu@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds two clock muxes for the two I2S
buses present on sama5d2 platforms.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---

Changes in v7:
	- none

Changes in v6:
        - none

 arch/arm/boot/dts/sama5d2.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 61f68e5c48e9..eeb6afa1cda7 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -992,6 +992,24 @@
 						atmel,clk-output-range = <0 100000000>;
 					};
 				};
+
+				i2s_clkmux {
+					compatible = "atmel,sama5d2-clk-i2s-mux";
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					i2s0muxck: i2s0_muxclk {
+						clocks = <&i2s0_clk>, <&i2s0_gclk>;
+						#clock-cells = <0>;
+						reg = <0>;
+					};
+
+					i2s1muxck: i2s1_muxclk {
+						clocks = <&i2s1_clk>, <&i2s1_gclk>;
+						#clock-cells = <0>;
+						reg = <1>;
+					};
+				};
 			};
 
 			qspi0: spi at f0020000 {
-- 
2.17.1
