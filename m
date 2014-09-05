From: heiko@sntech.de (Heiko Stuebner)
Date: Sat,  6 Sep 2014 01:06:12 +0200
Subject: [PATCH 09/11] ARM: dts: rockchip: add cpu supplies to boards
In-Reply-To: <1409958374-30937-1-git-send-email-heiko@sntech.de>
References: <1409958374-30937-1-git-send-email-heiko@sntech.de>
Message-ID: <1409958374-30937-10-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the cpu-supplies to the curie2 and radxarock boards. The rk3288
boards are currently still missing their cpu-regulator, so will get their
supply later.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3066a-bqcurie2.dts | 4 ++++
 arch/arm/boot/dts/rk3188-radxarock.dts | 6 +++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3066a-bqcurie2.dts b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
index 042f821d..b185738 100644
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
index 171b610..f3656d4 100644
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
@@ -106,7 +110,7 @@
 			vdd_arm: REG3 {
 				regulator-name = "VDD_ARM";
 				regulator-min-microvolt = <875000>;
-				regulator-max-microvolt = <1300000>;
+				regulator-max-microvolt = <1350000>;
 				regulator-always-on;
 			};
 
-- 
2.0.1
