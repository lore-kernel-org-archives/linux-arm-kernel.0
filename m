From: icenowy@aosc.io (Icenowy Zheng)
Date: Sun, 22 Jul 2018 13:39:53 +0800
Subject: [PATCH 3/5] arm64: allwinner: h6: add system controller device tree
 node
In-Reply-To: <20180722053955.25266-1-icenowy@aosc.io>
References: <20180722053955.25266-1-icenowy@aosc.io>
Message-ID: <20180722053955.25266-4-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we have already binding for the H6 system controller, add its node
to the device tree.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 23 ++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index cfa5fffcf62b..3ab6cf0256ca 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -92,6 +92,29 @@
 		#size-cells = <1>;
 		ranges;
 
+		syscon: syscon at 3000000 {
+			compatible = "allwinner.sun50i-h6-system-control",
+				     "allwinner,sun50i-a64-system-control";
+			reg = <0x03000000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			sram_c: sram at 28000 {
+				compatible = "mmio-sram";
+				reg = <0x00028000 0x1e000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x00028000 0x1e000>;
+
+				de2_sram: sram-section at 0 {
+					compatible = "allwinner,sun50i-h6-sram-c",
+						     "allwinner,sun50i-a64-sram-c";
+					reg = <0x0000 0x1e000>;
+				};
+			};
+		};
+
 		ccu: clock at 3001000 {
 			compatible = "allwinner,sun50i-h6-ccu";
 			reg = <0x03001000 0x1000>;
-- 
2.18.0
