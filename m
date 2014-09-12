From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 13 Sep 2014 00:34:30 +0200
Subject: [PATCH 2/3] ARM: dts: rockchip: add cpu supplies to boards
In-Reply-To: <1410561271-19197-1-git-send-email-heiko@sntech.de>
References: <1410561271-19197-1-git-send-email-heiko@sntech.de>
Message-ID: <1410561271-19197-3-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the cpu-supplies to the curie2, radxarock and rk3288-evb-rk808 boards.
The rk3288-evb-act8846 variant cannot provide the cpu-regulator at the moment
so will get its supply later.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3066a-bqcurie2.dts | 4 ++++
 arch/arm/boot/dts/rk3188-radxarock.dts | 6 +++++-
 arch/arm/boot/dts/rk3288-evb-rk808.dts | 6 +++++-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk3066a-bqcurie2.dts b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
index 665dd56..5974a09 100644
--- a/arch/arm/boot/dts/rk3066a-bqcurie2.dts
+++ b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
@@ -60,6 +60,10 @@
 	};
 };
 
+&cpu0 {
+	cpu0-supply = <&vdd_arm>;
+};
+
 &i2c1 {
 	status = "okay";
 	clock-frequency = <400000>;
diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts b/arch/arm/boot/dts/rk3188-radxarock.dts
index ff35acfa..8cbd5a2 100644
--- a/arch/arm/boot/dts/rk3188-radxarock.dts
+++ b/arch/arm/boot/dts/rk3188-radxarock.dts
@@ -76,6 +76,10 @@
 	};
 };
 
+&cpu0 {
+	cpu0-supply = <&vdd_arm>;
+};
+
 &i2c1 {
 	status = "okay";
 	clock-frequency = <400000>;
@@ -117,7 +121,7 @@
 			vdd_arm: REG3 {
 				regulator-name = "VDD_ARM";
 				regulator-min-microvolt = <875000>;
-				regulator-max-microvolt = <1300000>;
+				regulator-max-microvolt = <1350000>;
 				regulator-always-on;
 			};
 
diff --git a/arch/arm/boot/dts/rk3288-evb-rk808.dts b/arch/arm/boot/dts/rk3288-evb-rk808.dts
index ff522f8..d8c775e6 100644
--- a/arch/arm/boot/dts/rk3288-evb-rk808.dts
+++ b/arch/arm/boot/dts/rk3288-evb-rk808.dts
@@ -17,6 +17,10 @@
 	compatible = "rockchip,rk3288-evb-rk808", "rockchip,rk3288";
 };
 
+&cpu0 {
+	cpu0-supply = <&vdd_cpu>;
+};
+
 &i2c0 {
 	clock-frequency = <400000>;
 	status = "okay";
@@ -44,7 +48,7 @@
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <750000>;
-				regulator-max-microvolt = <1300000>;
+				regulator-max-microvolt = <1350000>;
 				regulator-name = "vdd_arm";
 			};
 
-- 
2.0.1
