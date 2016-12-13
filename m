From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 13 Dec 2016 23:22:50 +0800
Subject: [PATCH 4/6] ARM: dts: sun8i: add opp-v2 table for A33
In-Reply-To: <20161213152252.53749-1-icenowy@aosc.xyz>
References: <20161213152252.53749-1-icenowy@aosc.xyz>
Message-ID: <20161213152252.53749-5-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An operating point table is needed for the cpu frequency adjusting to
work.

The operating point table is converted from the common value in
extracted script.fex from many A33 board/tablets.

1.344GHz is set as a turbo-mode operating point, as it's described as
"extremity_freq" in the FEX file. (the "max_freq" is 1.2GHz)

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 arch/arm/boot/dts/sun8i-a33.dtsi | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index 504996cbee29..035c058324b8 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -46,7 +46,45 @@
 #include <dt-bindings/dma/sun4i-a10.h>
 
 / {
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp at 648000000 {
+			opp-hz = /bits/ 64 <648000000>;
+			opp-microvolt = <1040000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+		opp at 816000000 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <1100000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+		opp at 1008000000 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt = <1200000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+		opp at 1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1320000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+		opp at 1344000000 {
+			opp-hz = /bits/ 64 <1344000000>;
+			opp-microvolt = <1460000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			turbo-mode;
+		};
+	};
+
 	cpus {
+		cpu0: cpu at 0 {
+			clocks = <&ccu CLK_CPUX>;
+			clock-names = "cpu";
+			operating-points-v2 = <&cpu0_opp_table>;
+		};
+
 		cpu at 2 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
-- 
2.11.0
