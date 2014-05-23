From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 23 May 2014 21:38:55 +0200
Subject: [PATCH v3 10/11] ARM: dts: rockchip: move rk3188 core input clocks
 into main dtsi
In-Reply-To: <1621067.VASjIdzoSl@phil>
References: <1621067.VASjIdzoSl@phil>
Message-ID: <1494003.CuVFMbK6YX@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock definitions get a lot shorter due to the soc clocks being handled by
rk3188-cru and only the input clocks remaining. These can not simply live
in the main rk3188.dtsi without affecting readability.

As we do now provide all necessary clocks, the dummy clock can go away too.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3188-clocks.dtsi | 18 ------------------
 arch/arm/boot/dts/rk3188.dtsi        | 12 ++++++++++++
 2 files changed, 12 insertions(+), 18 deletions(-)

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
index 3719436..3295c6b 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -52,6 +52,18 @@
 		};
 	};
 
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
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
