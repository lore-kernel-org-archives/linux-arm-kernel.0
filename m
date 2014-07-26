From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 27 Jul 2014 01:18:18 +0200
Subject: [PATCH v2 02/15] ARM: dts: rockchip: move oscillator input clock into
 main dtsi
In-Reply-To: <1406416711-28006-1-git-send-email-heiko@sntech.de>
References: <1406416711-28006-1-git-send-email-heiko@sntech.de>
Message-ID: <1406416711-28006-3-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock definitions get a lot shorter due to the soc clocks being handled by
rk3188-cru and only the input clock remains. These can now simply live
in the main rk3xxx.dtsi without affecting readability.

At the same time, rename the node to oscillator, adding a clock-output-names
property to match how the rk3288 handles this.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Max Schwarz <max.schwarz@online.de>
Tested-by: Max Schwarz <max.schwarz@online.de>
---
 arch/arm/boot/dts/rk3066a-clocks.dtsi | 6 ------
 arch/arm/boot/dts/rk3188-clocks.dtsi  | 6 ------
 arch/arm/boot/dts/rk3xxx.dtsi         | 7 +++++++
 3 files changed, 7 insertions(+), 12 deletions(-)

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
index b47d5fe..6d16364 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -20,6 +20,13 @@
 / {
 	interrupt-parent = <&gic>;
 
+	xin24m: oscillator {
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+		#clock-cells = <0>;
+		clock-output-names = "xin24m";
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.0.1
