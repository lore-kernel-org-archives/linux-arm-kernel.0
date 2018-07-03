From: andrew@aj.id.au (Andrew Jeffery)
Date: Tue,  3 Jul 2018 17:04:13 +1000
Subject: [RFC PATCH 4/4] dts: aspeed-g5: Add bmc-misc-ctrl nodes to devicetree
In-Reply-To: <20180703070413.28756-1-andrew@aj.id.au>
References: <20180703070413.28756-1-andrew@aj.id.au>
Message-ID: <20180703070413.28756-5-andrew@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 192 +++++++++++++++++++++++++++++++
 1 file changed, 192 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 17f2714d18a7..57d477e17c0c 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -187,6 +187,77 @@
 					aspeed,external-nodes = <&gfx &lhc>;
 
 				};
+
+				field at 2c.16 {
+					compatible = "bmc-misc-ctrl";
+					offset = <0x2c>;
+					mask = <0x00030000>;
+					label = "dac-mux";
+				};
+
+				field at 50.0 {
+					compatible = "bmc-misc-ctrl";
+					offset = <0x50>;
+					mask = <0xffffffff>;
+					label = "vga0";
+					read-only;
+				};
+
+				field at 54.0 {
+					compatible = "bmc-misc-ctrl";
+					offset = <0x54>;
+					mask = <0xffffffff>;
+					label = "vga1";
+					read-only;
+				};
+
+				field at 58.0 {
+					compatible = "bmc-misc-ctrl";
+					offset = <0x58>;
+					mask = <0xffffffff>;
+					label = "vga2";
+					read-only;
+				};
+
+				field at 5c.0 {
+					compatible = "bmc-misc-ctrl";
+					offset = <0x5c>;
+					mask = <0xffffffff>;
+					label = "vga3";
+					read-only;
+				};
+
+				field at 60.0 {
+					compatible = "bmc-misc-ctrl";
+					offset = <0x60>;
+					mask = <0xffffffff>;
+					label = "vga4";
+					read-only;
+				};
+
+				field at 64.0 {
+					compatible = "bmc-misc-ctrl";
+					offset = <0x64>;
+					mask = <0xffffffff>;
+					label = "vga5";
+					read-only;
+				};
+
+				field at 68.0 {
+					compatible = "bmc-misc-ctrl";
+					offset = <0x68>;
+					mask = <0xffffffff>;
+					label = "vga6";
+					read-only;
+				};
+
+				field at 6c.0 {
+					compatible = "bmc-misc-ctrl";
+					offset = <0x6c>;
+					mask = <0xffffffff>;
+					label = "vga7";
+					read-only;
+				};
 			};
 
 			rng: hwrng at 1e6e2078 {
@@ -343,6 +414,127 @@
 						#reset-cells = <1>;
 					};
 
+					field at f0.24 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xf0 24 8>;
+						mask = <0xff000000>;
+						label = "sio-2b";
+					};
+
+					field at f0.16 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xf0>;
+						mask = <0x00ff0000>;
+						label = "sio-2a";
+					};
+
+					field at f0.8 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xf0>;
+						mask = <0x0000ff00>;
+						bit-shift = <8>;
+						label = "sio-29";
+					};
+
+					field at f0.0 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xf0>;
+						mask = <0x000000ff>;
+						label = "sio-28";
+					};
+
+					field at f4.24 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xf4>;
+						mask = <0xff000000>;
+						label = "sio-2f";
+					};
+
+					field at f4.16 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xf4>;
+						mask = <0x00ff0000>;
+						label = "sio-2e";
+					};
+
+					field at f4.8 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xf4>;
+						mask = <0x0000ff00>;
+						label = "sio-2d";
+					};
+
+					field at f4.0 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xf4>;
+						mask = <0x000000ff>;
+						label = "sio-2c";
+					};
+
+					field at f8.24 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xf8>;
+						mask = <0xff000000>;
+						read-only;
+						label = "sio-23";
+					};
+
+					field at f8.16 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xf8>;
+						mask = <0x00ff0000>;
+						read-only;
+						label = "sio-22";
+					};
+
+					field at f8.8 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xf8>;
+						mask = <0x0000ff00>;
+						read-only;
+						label = "sio-21";
+					};
+
+					field at f8.0 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xf8>;
+						mask = <0x000000ff>;
+						read-only;
+						label = "sio-20";
+					};
+
+					field at fc.24 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xfc>;
+						mask = <0xff000000>;
+						read-only;
+						label = "sio-27";
+					};
+
+					field at fc.16 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xfc>;
+						mask = <0x00ff0000>;
+						read-only;
+						label = "sio-26";
+					};
+
+					field at fc.8 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xfc>;
+						mask = <0x0000ff00>;
+						read-only;
+						label = "sio-25";
+					};
+
+					field at fc.0 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xfc>;
+						mask = <0x000000ff>;
+						read-only;
+						label = "sio-24";
+					};
+
 					ibt: ibt at c0 {
 						compatible = "aspeed,ast2500-ibt-bmc";
 						reg = <0xc0 0x18>;
-- 
2.17.1
