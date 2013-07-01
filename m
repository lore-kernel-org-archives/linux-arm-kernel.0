From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 01 Jul 2013 17:22:34 +0200
Subject: [PATCH v3 12/13] ARM: dts: Add S5K5BA sensor regulator definitions for
 Trats board
In-Reply-To: <1372692155-17653-1-git-send-email-s.nawrocki@samsung.com>
References: <1372692155-17653-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1372692155-17653-13-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrzej Hajda <a.hajda@samsung.com>

Add MAX8998 LDO12 and fixed voltage regulator nodes. While at it,
all fixed voltage regulator nodes are grouped in a 'regulators' node.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4210-trats.dts |   80 +++++++++++++++++++++++++-------
 1 file changed, 64 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index 6b1568e..f62e299 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -30,13 +30,64 @@
 		bootargs = "console=ttySAC2,115200N8 root=/dev/mmcblk0p5 rootwait earlyprintk panic=5";
 	};
 
-	vemmc_reg: voltage-regulator at 0 {
-	        compatible = "regulator-fixed";
-		regulator-name = "VMEM_VDD_2.8V";
-		regulator-min-microvolt = <2800000>;
-		regulator-max-microvolt = <2800000>;
-		gpio = <&gpk0 2 0>;
-		enable-active-high;
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		vemmc_reg: regulator at 0 {
+			compatible = "regulator-fixed";
+			regulator-name = "VMEM_VDD_2.8V";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			gpio = <&gpk0 2 0>;
+			enable-active-high;
+		};
+
+		tsp_reg: regulator at 1 {
+			compatible = "regulator-fixed";
+			regulator-name = "TSP_FIXED_VOLTAGES";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			gpio = <&gpl0 3 0>;
+			enable-active-high;
+		};
+
+		cam_af_28v_reg: regulator at 2 {
+			compatible = "regulator-fixed";
+			regulator-name = "8M_AF_2.8V_EN";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			gpio = <&gpk1 1 0>;
+			enable-active-high;
+		};
+
+		cam_io_en_reg: regulator at 3 {
+			compatible = "regulator-fixed";
+			regulator-name = "CAM_IO_EN";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			gpio = <&gpe2 1 0>;
+			enable-active-high;
+		};
+
+		cam_io_12v_reg: regulator at 4 {
+			compatible = "regulator-fixed";
+			regulator-name = "8M_1.2V_EN";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			gpio = <&gpe2 5 0>;
+			enable-active-high;
+		};
+
+		vt_core_15v_reg: regulator at 5 {
+			compatible = "regulator-fixed";
+			regulator-name = "VT_CORE_1.5V";
+			regulator-min-microvolt = <1500000>;
+			regulator-max-microvolt = <1500000>;
+			gpio = <&gpe2 2 0>;
+			enable-active-high;
+		};
 	};
 
 	sdhci_emmc: sdhci at 12510000 {
@@ -97,15 +148,6 @@
 		};
 	};
 
-	tsp_reg: voltage-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "TSP_FIXED_VOLTAGES";
-		regulator-min-microvolt = <2800000>;
-		regulator-max-microvolt = <2800000>;
-		gpio = <&gpl0 3 0>;
-		enable-active-high;
-	};
-
 	i2c at 13890000 {
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-slave-addr = <0x10>;
@@ -218,6 +260,12 @@
 				     regulator-always-on;
 				};
 
+				vtcam_reg: LDO12 {
+				     regulator-name = "VT_CAM_1.8V";
+				     regulator-min-microvolt = <1800000>;
+				     regulator-max-microvolt = <1800000>;
+				};
+
 				vcclcd_reg: LDO13 {
 				     regulator-name = "VCC_3.3V_LCD";
 				     regulator-min-microvolt = <3300000>;
-- 
1.7.9.5
