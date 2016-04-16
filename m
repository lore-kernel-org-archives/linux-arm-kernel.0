From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 16 Apr 2016 02:49:14 +0200
Subject: [PATCH] ARM: dts: rockchip: move rk3288 edp phy under the GRF
Message-ID: <1640976.sZtsTTlDpl@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The edp-phy control is a part of the General Register Files and
with a recent patch in 4.6 the phy driver can now also handle this
correctly, so move the dts node under the GRF as well.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288.dtsi | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 180eb97..9068189 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -201,15 +201,6 @@
 		#clock-cells = <0>;
 	};
 
-	edp_phy: edp-phy {
-		compatible = "rockchip,rk3288-dp-phy";
-		clocks = <&cru SCLK_EDP_24M>;
-		clock-names = "24m";
-		rockchip,grf = <&grf>;
-		#phy-cells = <0>;
-		status = "disabled";
-	};
-
 	timer {
 		compatible = "arm,armv7-timer";
 		arm,cpu-registers-not-fw-configured;
@@ -756,6 +747,14 @@
 	grf: syscon at ff770000 {
 		compatible = "rockchip,rk3288-grf", "syscon", "simple-mfd";
 		reg = <0xff770000 0x1000>;
+
+		edp_phy: edp-phy {
+			compatible = "rockchip,rk3288-dp-phy";
+			clocks = <&cru SCLK_EDP_24M>;
+			clock-names = "24m";
+			#phy-cells = <0>;
+			status = "disabled";
+		};
 	};
 
 	wdt: watchdog at ff800000 {
-- 
2.7.0
