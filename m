From: padma.v@samsung.com (Padmavathi Venna)
Date: Tue, 28 May 2013 16:05:22 +0530
Subject: [PATCH] ARM: dts: wm8994: Add wm8994 regulator support on smdk5250.
Message-ID: <1369737322-10907-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the required regulator supplies and properties
for wm8994 codec on smdk5250 board.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/boot/dts/exynos5250-smdk5250.dts |   53 +++++++++++++++++++++++++++-
 1 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index f2a025e..42fc79e 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -37,6 +37,46 @@
 		};
 	};
 
+	avdd2:fixed-regulator at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "avdd2-supply";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
+	cpvdd:fixed-regulator at 1 {
+		compatible = "regulator-fixed";
+		regulator-name = "cpvdd-supply";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
+	dbvdd:fixed-regulator at 2 {
+		compatible = "regulator-fixed";
+		regulator-name = "dbvdd-supply";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	spkvdd1:fixed-regulator at 3 {
+		compatible = "regulator-fixed";
+		regulator-name = "spkvdd1-supply";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	spkvdd2:fixed-regulator at 4 {
+		compatible = "regulator-fixed";
+		regulator-name = "spkvdd2-supply";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
 	i2c at 12C70000 {
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <20000>;
@@ -47,8 +87,17 @@
 		};
 
 		wm8994: wm8994 at 1a {
-			 compatible = "wlf,wm8994";
-			 reg = <0x1a>;
+			compatible = "wlf,wm8994";
+			reg = <0x1a>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			AVDD2-supply = <&avdd2>;
+			CPVDD-supply = <&cpvdd>;
+			DBVDD-supply = <&dbvdd>;
+			SPKVDD1-supply = <&spkvdd1>;
+			SPKVDD2-supply = <&spkvdd2>;
 		};
 	};
 
-- 
1.7.4.4
