From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 07 May 2014 23:15:52 +0200
Subject: [PATCH v2 10/11] ARM: dts: rockchip: move rk3188 core input clocks
 into main dtsi
In-Reply-To: <3477211.Gkyeur83TV@diego>
References: <3477211.Gkyeur83TV@diego>
Message-ID: <3368690.OS3upipai3@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock definitions get a lot shorter due to the soc clocks being handled by
rk3188-cru and only the input clocks remaining. These can not simply live
in the main rk3188.dtsi without affecting readability.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3188-clocks.dtsi | 18 ------------------
 arch/arm/boot/dts/rk3188.dtsi        | 24 ++++++++++++++++++++++++
 2 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/rk3188-clocks.dtsi b/arch/arm/boot/dts/rk3188-clocks.dtsi
index b1b92dc..8c1577a 100644
--- a/arch/arm/boot/dts/rk3188-clocks.dtsi
+++ b/arch/arm/boot/dts/rk3188-clocks.dtsi
@@ -19,24 +19,6 @@
 		#size-cells = <1>;
 		ranges;
 
-		/*
-		 * This is a dummy clock, to be used as placeholder on
-		 * other mux clocks when a specific parent clock is not
-		 * yet implemented. It should be dropped when the driver
-		 * is complete.
-		 */
-		dummy: dummy {
-			compatible = "fixed-clock";
-			clock-frequency = <0>;
-			#clock-cells = <0>;
-		};
-
-		xin24m: xin24m {
-			compatible = "fixed-clock";
-			clock-frequency = <24000000>;
-			#clock-cells = <0>;
-		};
-
 		dummy48m: dummy48m {
 			compatible = "fixed-clock";
 			clock-frequency = <48000000>;
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index dc3e986..c248748 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -52,6 +52,30 @@
 		};
 	};
 
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		/*
+		 * This is a dummy clock, to be used as placeholder on
+		 * other mux clocks when a specific parent clock is not
+		 * yet implemented. It should be dropped when the driver
+		 * is complete.
+		 */
+		dummy: dummy {
+			compatible = "fixed-clock";
+			clock-frequency = <0>;
+			#clock-cells = <0>;
+		};
+
+		xin24m: xin24m {
+			compatible = "fixed-clock";
+			clock-frequency = <24000000>;
+			#clock-cells = <0>;
+		};
+	};
+
 	soc {
 		global-timer at 1013c200 {
 			interrupts = <GIC_PPI 11 0xf04>;
-- 
1.9.0
