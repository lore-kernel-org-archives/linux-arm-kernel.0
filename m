From: padma.v@samsung.com (Padmavathi Venna)
Date: Wed, 07 Aug 2013 14:40:12 +0530
Subject: [PATCH V3 3/7] ARM: dts: Add i2c bus 1 and it's audio codec child node
 on smdk5420
In-Reply-To: <1375866616-5541-1-git-send-email-padma.v@samsung.com>
References: <1375866616-5541-1-git-send-email-padma.v@samsung.com>
Message-ID: <1375866616-5541-4-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds i2c bus 1 and wm8994 codec node on i2c bus1 and the
required regulator supplies and properties on smdk5420 board.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/boot/dts/exynos5420-smdk5420.dts |   58 +++++++++++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index d05de7a..e86c1ae 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -68,4 +68,62 @@
 			bus-width = <4>;
 		};
 	};
+
+	avdd2: fixed-regulator at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "avdd2-supply";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
+	cpvdd: fixed-regulator at 1 {
+		compatible = "regulator-fixed";
+		regulator-name = "cpvdd-supply";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
+	dbvdd: fixed-regulator at 2 {
+		compatible = "regulator-fixed";
+		regulator-name = "dbvdd-supply";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	spkvdd: fixed-regulator at 3 {
+		compatible = "regulator-fixed";
+		regulator-name = "spkvdd-supply";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	i2c at 12C70000 {
+		status = "okay";
+		samsung,i2c-sda-delay = <100>;
+		samsung,i2c-max-bus-freq = <20000>;
+
+		eeprom at 51 {
+			compatible = "samsung,s524ad0xd1";
+			reg = <0x51>;
+		};
+
+		wm8994: wm8994 at 1a {
+			compatible = "wlf,wm8994";
+			reg = <0x1a>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			AVDD2-supply = <&avdd2>;
+			CPVDD-supply = <&cpvdd>;
+			DBVDD-supply = <&dbvdd>;
+			SPKVDD1-supply = <&spkvdd>;
+			SPKVDD2-supply = <&spkvdd>;
+		};
+	};
+
 };
-- 
1.7.4.4
