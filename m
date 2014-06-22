From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 22 Jun 2014 22:48:44 +0200
Subject: [PATCH v4 10/13] ARM: dts: rockchip: move oscillator input clock into
 main dtsi
In-Reply-To: <1808429.dNxms7FR7U@diego>
References: <1808429.dNxms7FR7U@diego>
Message-ID: <1667363.AdZ5ojCAWZ@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock definitions get a lot shorter due to the soc clocks being handled by
rk3188-cru and only the input clock remains. These can not simply live
in the main rk3xxx.dtsi without affecting readability.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3066a-clocks.dtsi | 6 ------
 arch/arm/boot/dts/rk3188-clocks.dtsi  | 6 ------
 arch/arm/boot/dts/rk3xxx.dtsi         | 6 ++++++
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/rk3066a-clocks.dtsi b/arch/arm/boot/dts/rk3066a-clocks.dtsi
index 6e307fc..0d4d667 100644
--- a/arch/arm/boot/dts/rk3066a-clocks.dtsi
+++ b/arch/arm/boot/dts/rk3066a-clocks.dtsi
@@ -31,12 +31,6 @@
 			#clock-cells = <0>;
 		};
 
-		xin24m: xin24m {
-			compatible = "fixed-clock";
-			clock-frequency = <24000000>;
-			#clock-cells = <0>;
-		};
-
 		dummy48m: dummy48m {
 			compatible = "fixed-clock";
 			clock-frequency = <48000000>;
diff --git a/arch/arm/boot/dts/rk3188-clocks.dtsi b/arch/arm/boot/dts/rk3188-clocks.dtsi
index b1b92dc..6bc0373 100644
--- a/arch/arm/boot/dts/rk3188-clocks.dtsi
+++ b/arch/arm/boot/dts/rk3188-clocks.dtsi
@@ -31,12 +31,6 @@
 			#clock-cells = <0>;
 		};
 
-		xin24m: xin24m {
-			compatible = "fixed-clock";
-			clock-frequency = <24000000>;
-			#clock-cells = <0>;
-		};
-
 		dummy48m: dummy48m {
 			compatible = "fixed-clock";
 			clock-frequency = <48000000>;
diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index b47d5fe..0de3f06 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -26,6 +26,12 @@
 		compatible = "simple-bus";
 		ranges;
 
+		xin24m: xin24m {
+			compatible = "fixed-clock";
+			clock-frequency = <24000000>;
+			#clock-cells = <0>;
+		};
+
 		scu at 1013c000 {
 			compatible = "arm,cortex-a9-scu";
 			reg = <0x1013c000 0x100>;
-- 
1.9.0
