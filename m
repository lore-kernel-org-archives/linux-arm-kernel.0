From: stevenvandenbrandenstift@gmail.com (stevenvandenbrandenstift at gmail.com)
Date: Mon, 23 Jul 2018 18:09:54 +0200
Subject: [PATCH] sun4i: dts: add gpu node to sun4i-a10 platform
Message-ID: <20180723160954.14115-1-stevenvandenbrandenstift@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steven Vanden Branden <stevenvandenbrandenstift@gmail.com>

Add mali gpu node to sun4i a10 platforms.
Tested with offscreen rendering with lima mesa (freedesktop gitlab)

Signed-off-by: Steven Vanden Branden <stevenvandenbrandenstift@gmail.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 3a1c6b45c9a1..be22f18b1462 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -1001,6 +1001,27 @@
 			status = "disabled";
 		};
 
+		mali: gpu at 1c40000 {
+			compatible = "allwinner,sun4i-a10-mali", "arm,mali-400";
+			reg = <0x01c40000 0x10000>;
+			interrupts = <69>,
+				     <70>,
+				     <71>,
+				     <72>,
+				     <73>;
+			interrupt-names = "gp",
+					  "gpmmu",
+					  "pp0",
+					  "ppmmu0",
+					  "pmu";
+			clocks = <&ccu CLK_AHB_GPU>, <&ccu CLK_GPU>;
+			clock-names = "bus", "core";
+			resets = <&ccu RST_GPU>;
+
+			assigned-clocks = <&ccu CLK_GPU>;
+			assigned-clock-rates = <384000000>;
+		};
+
 		fe0: display-frontend at 1e00000 {
 			compatible = "allwinner,sun4i-a10-display-frontend";
 			reg = <0x01e00000 0x20000>;
-- 
2.17.1
