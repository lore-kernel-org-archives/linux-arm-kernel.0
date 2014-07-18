From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Fri, 18 Jul 2014 19:20:06 +0200
Subject: [PATCH v2 1/4] ARM: dts: exynos5250: max77686 is Snow only
In-Reply-To: <1405704009-8430-1-git-send-email-afaerber@suse.de>
References: <1405704009-8430-1-git-send-email-afaerber@suse.de>
Message-ID: <1405704009-8430-2-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move it from exynos5250-cros-common.dtsi to exynos5250-snow.dts.
Spring does not need it, it uses an s5m8767 instead.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2: New (Doug Anderson)

 arch/arm/boot/dts/exynos5250-cros-common.dtsi | 151 -------------------------
 arch/arm/boot/dts/exynos5250-snow.dts         | 155 ++++++++++++++++++++++++++
 2 files changed, 155 insertions(+), 151 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-cros-common.dtsi b/arch/arm/boot/dts/exynos5250-cros-common.dtsi
index 89ac90f..61128d1 100644
--- a/arch/arm/boot/dts/exynos5250-cros-common.dtsi
+++ b/arch/arm/boot/dts/exynos5250-cros-common.dtsi
@@ -27,163 +27,12 @@
 		i2c2_bus: i2c2-bus {
 			samsung,pin-pud = <0>;
 		};
-
-		max77686_irq: max77686-irq {
-			samsung,pins = "gpx3-2";
-			samsung,pin-function = <0>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
-		};
 	};
 
 	i2c at 12C60000 {
 		status = "okay";
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <378000>;
-
-		max77686 at 09 {
-			compatible = "maxim,max77686";
-			interrupt-parent = <&gpx3>;
-			interrupts = <2 0>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&max77686_irq>;
-			wakeup-source;
-			reg = <0x09>;
-			#clock-cells = <1>;
-
-			voltage-regulators {
-				ldo1_reg: LDO1 {
-					regulator-name = "P1.0V_LDO_OUT1";
-					regulator-min-microvolt = <1000000>;
-					regulator-max-microvolt = <1000000>;
-					regulator-always-on;
-				};
-
-				ldo2_reg: LDO2 {
-					regulator-name = "P1.8V_LDO_OUT2";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-				};
-
-				ldo3_reg: LDO3 {
-					regulator-name = "P1.8V_LDO_OUT3";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-				};
-
-				ldo7_reg: LDO7 {
-					regulator-name = "P1.1V_LDO_OUT7";
-					regulator-min-microvolt = <1100000>;
-					regulator-max-microvolt = <1100000>;
-					regulator-always-on;
-				};
-
-				ldo8_reg: LDO8 {
-					regulator-name = "P1.0V_LDO_OUT8";
-					regulator-min-microvolt = <1000000>;
-					regulator-max-microvolt = <1000000>;
-					regulator-always-on;
-				};
-
-				ldo10_reg: LDO10 {
-					regulator-name = "P1.8V_LDO_OUT10";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-				};
-
-				ldo12_reg: LDO12 {
-					regulator-name = "P3.0V_LDO_OUT12";
-					regulator-min-microvolt = <3000000>;
-					regulator-max-microvolt = <3000000>;
-					regulator-always-on;
-				};
-
-				ldo14_reg: LDO14 {
-					regulator-name = "P1.8V_LDO_OUT14";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-				};
-
-				ldo15_reg: LDO15 {
-					regulator-name = "P1.0V_LDO_OUT15";
-					regulator-min-microvolt = <1000000>;
-					regulator-max-microvolt = <1000000>;
-					regulator-always-on;
-				};
-
-				ldo16_reg: LDO16 {
-					regulator-name = "P1.8V_LDO_OUT16";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-				};
-
-				buck1_reg: BUCK1 {
-					regulator-name = "vdd_mif";
-					regulator-min-microvolt = <950000>;
-					regulator-max-microvolt = <1300000>;
-					regulator-always-on;
-					regulator-boot-on;
-				};
-
-				buck2_reg: BUCK2 {
-					regulator-name = "vdd_arm";
-					regulator-min-microvolt = <850000>;
-					regulator-max-microvolt = <1350000>;
-					regulator-always-on;
-					regulator-boot-on;
-				};
-
-				buck3_reg: BUCK3 {
-					regulator-name = "vdd_int";
-					regulator-min-microvolt = <900000>;
-					regulator-max-microvolt = <1200000>;
-					regulator-always-on;
-					regulator-boot-on;
-				};
-
-				buck4_reg: BUCK4 {
-					regulator-name = "vdd_g3d";
-					regulator-min-microvolt = <850000>;
-					regulator-max-microvolt = <1300000>;
-					regulator-always-on;
-					regulator-boot-on;
-				};
-
-				buck5_reg: BUCK5 {
-					regulator-name = "P1.8V_BUCK_OUT5";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-					regulator-boot-on;
-				};
-
-				buck6_reg: BUCK6 {
-					regulator-name = "P1.35V_BUCK_OUT6";
-					regulator-min-microvolt = <1350000>;
-					regulator-max-microvolt = <1350000>;
-					regulator-always-on;
-				};
-
-				buck7_reg: BUCK7 {
-					regulator-name = "P2.0V_BUCK_OUT7";
-					regulator-min-microvolt = <2000000>;
-					regulator-max-microvolt = <2000000>;
-					regulator-always-on;
-				};
-
-				buck8_reg: BUCK8 {
-					regulator-name = "P2.85V_BUCK_OUT8";
-					regulator-min-microvolt = <2850000>;
-					regulator-max-microvolt = <2850000>;
-					regulator-always-on;
-				};
-			};
-		};
 	};
 
 	i2c at 12C70000 {
diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index c682c88..0f867a3 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -344,4 +344,159 @@
 	};
 };
 
+&i2c_0 {
+	max77686 at 09 {
+		compatible = "maxim,max77686";
+		interrupt-parent = <&gpx3>;
+		interrupts = <2 0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&max77686_irq>;
+		wakeup-source;
+		reg = <0x09>;
+		#clock-cells = <1>;
+
+		voltage-regulators {
+			ldo1_reg: LDO1 {
+				regulator-name = "P1.0V_LDO_OUT1";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-always-on;
+			};
+
+			ldo2_reg: LDO2 {
+				regulator-name = "P1.8V_LDO_OUT2";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+
+			ldo3_reg: LDO3 {
+				regulator-name = "P1.8V_LDO_OUT3";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+
+			ldo7_reg: LDO7 {
+				regulator-name = "P1.1V_LDO_OUT7";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-always-on;
+			};
+
+			ldo8_reg: LDO8 {
+				regulator-name = "P1.0V_LDO_OUT8";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-always-on;
+			};
+
+			ldo10_reg: LDO10 {
+				regulator-name = "P1.8V_LDO_OUT10";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+
+			ldo12_reg: LDO12 {
+				regulator-name = "P3.0V_LDO_OUT12";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-always-on;
+			};
+
+			ldo14_reg: LDO14 {
+				regulator-name = "P1.8V_LDO_OUT14";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+
+			ldo15_reg: LDO15 {
+				regulator-name = "P1.0V_LDO_OUT15";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-always-on;
+			};
+
+			ldo16_reg: LDO16 {
+				regulator-name = "P1.8V_LDO_OUT16";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+
+			buck1_reg: BUCK1 {
+				regulator-name = "vdd_mif";
+				regulator-min-microvolt = <950000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			buck2_reg: BUCK2 {
+				regulator-name = "vdd_arm";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			buck3_reg: BUCK3 {
+				regulator-name = "vdd_int";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			buck4_reg: BUCK4 {
+				regulator-name = "vdd_g3d";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			buck5_reg: BUCK5 {
+				regulator-name = "P1.8V_BUCK_OUT5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			buck6_reg: BUCK6 {
+				regulator-name = "P1.35V_BUCK_OUT6";
+				regulator-min-microvolt = <1350000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-always-on;
+			};
+
+			buck7_reg: BUCK7 {
+				regulator-name = "P2.0V_BUCK_OUT7";
+				regulator-min-microvolt = <2000000>;
+				regulator-max-microvolt = <2000000>;
+				regulator-always-on;
+			};
+
+			buck8_reg: BUCK8 {
+				regulator-name = "P2.85V_BUCK_OUT8";
+				regulator-min-microvolt = <2850000>;
+				regulator-max-microvolt = <2850000>;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
+&pinctrl_0 {
+	max77686_irq: max77686-irq {
+		samsung,pins = "gpx3-2";
+		samsung,pin-function = <0>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+};
+
 #include "cros-ec-keyboard.dtsi"
-- 
1.9.3
