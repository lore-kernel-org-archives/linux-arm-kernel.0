From: padma.v@samsung.com (Padmavathi Venna)
Date: Mon, 03 Jun 2013 10:52:34 +0530
Subject: [PATCH V2] ARM: dts: wm8994: Add wm8994 regulator support on smdk5250.
Message-ID: <1370236954-16863-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the required regulator supplies and properties
for wm8994 codec on smdk5250 board.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---

Changes since V1:
	- Clubbed the same supply regulators as suggested by Mark.

 arch/arm/boot/dts/exynos5250-smdk5250.dts |   37 +++++++++++++++++++++++++++-
 1 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index f2a025e..dc2ec25 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -37,6 +37,30 @@
 		};
 	};
 
+	vdd:fixed-regulator at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd-supply";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
+	dbvdd:fixed-regulator at 1 {
+		compatible = "regulator-fixed";
+		regulator-name = "dbvdd-supply";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	spkvdd:fixed-regulator at 2 {
+		compatible = "regulator-fixed";
+		regulator-name = "spkvdd-supply";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
 	i2c at 12C70000 {
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <20000>;
@@ -47,8 +71,17 @@
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
+			AVDD2-supply = <&vdd>;
+			CPVDD-supply = <&vdd>;
+			DBVDD-supply = <&dbvdd>;
+			SPKVDD1-supply = <&spkvdd>;
+			SPKVDD2-supply = <&spkvdd>;
 		};
 	};
 
-- 
1.7.4.4
