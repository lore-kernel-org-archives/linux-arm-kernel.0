From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue,  1 Mar 2016 12:57:00 +0900
Subject: [PATCH] ARM: dts: add "simple-bus" to "arm, amba-bus" compatible nodes
Message-ID: <1456804620-8750-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "arm,amba-bus" string in the of_default_bus_match_table is
ambiguous.  This prepares for killing it off in a long run.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/axm55xx.dtsi             | 2 +-
 arch/arm/boot/dts/exynos3250.dtsi          | 2 +-
 arch/arm/boot/dts/exynos4.dtsi             | 2 +-
 arch/arm/boot/dts/exynos4415.dtsi          | 2 +-
 arch/arm/boot/dts/exynos5250.dtsi          | 2 +-
 arch/arm/boot/dts/exynos5420.dtsi          | 2 +-
 arch/arm/boot/dts/exynos5440.dtsi          | 2 +-
 arch/arm/boot/dts/hi3620.dtsi              | 2 +-
 arch/arm/boot/dts/hip01.dtsi               | 2 +-
 arch/arm/boot/dts/hisi-x5hd2.dtsi          | 2 +-
 arch/arm/boot/dts/qcom-apq8064.dtsi        | 2 +-
 arch/arm/boot/dts/qcom-msm8660.dtsi        | 2 +-
 arch/arm/boot/dts/qcom-msm8960.dtsi        | 2 +-
 arch/arm/boot/dts/rk3036.dtsi              | 2 +-
 arch/arm/boot/dts/rk3228.dtsi              | 2 +-
 arch/arm/boot/dts/rk3288.dtsi              | 2 +-
 arch/arm/boot/dts/rk3xxx.dtsi              | 2 +-
 arch/arm/boot/dts/s5pv210.dtsi             | 2 +-
 arch/arm/boot/dts/socfpga.dtsi             | 2 +-
 arch/arm/boot/dts/socfpga_arria10.dtsi     | 2 +-
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi | 2 +-
 arch/arm/boot/dts/ste-u300.dts             | 2 +-
 arch/arm/boot/dts/versatile-ab.dts         | 2 +-
 23 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/arm/boot/dts/axm55xx.dtsi b/arch/arm/boot/dts/axm55xx.dtsi
index ea288f0..8da4582 100644
--- a/arch/arm/boot/dts/axm55xx.dtsi
+++ b/arch/arm/boot/dts/axm55xx.dtsi
@@ -107,7 +107,7 @@
 		};
 
 		amba {
-			compatible = "arm,amba-bus";
+			compatible = "arm,amba-bus", "simple-bus";
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 18e3def..0ad4fa7 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -381,7 +381,7 @@
 		};
 
 		amba {
-			compatible = "arm,amba-bus";
+			compatible = "arm,amba-bus", "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 045785c..d53fd78 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -661,7 +661,7 @@
 	amba {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "arm,amba-bus";
+		compatible = "arm,amba-bus", "simple-bus";
 		interrupt-parent = <&gic>;
 		ranges;
 
diff --git a/arch/arm/boot/dts/exynos4415.dtsi b/arch/arm/boot/dts/exynos4415.dtsi
index ad76484..35d2f99 100644
--- a/arch/arm/boot/dts/exynos4415.dtsi
+++ b/arch/arm/boot/dts/exynos4415.dtsi
@@ -380,7 +380,7 @@
 		};
 
 		amba {
-			compatible = "arm,amba-bus";
+			compatible = "arm,amba-bus", "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			interrupt-parent = <&gic>;
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 33e2d5f..bcaed08 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -674,7 +674,7 @@
 	amba {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "arm,amba-bus";
+		compatible = "arm,amba-bus", "simple-bus";
 		interrupt-parent = <&gic>;
 		ranges;
 
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 48a0a55..838bde3 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -327,7 +327,7 @@
 	amba {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "arm,amba-bus";
+		compatible = "arm,amba-bus", "simple-bus";
 		interrupt-parent = <&gic>;
 		ranges;
 
diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index f18b51f..5fe5639 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -200,7 +200,7 @@
 	amba {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "arm,amba-bus";
+		compatible = "arm,amba-bus", "simple-bus";
 		interrupt-parent = <&gic>;
 		ranges;
 	};
diff --git a/arch/arm/boot/dts/hi3620.dtsi b/arch/arm/boot/dts/hi3620.dtsi
index 6cbb62e..7b67ffe 100644
--- a/arch/arm/boot/dts/hi3620.dtsi
+++ b/arch/arm/boot/dts/hi3620.dtsi
@@ -68,7 +68,7 @@
 
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "arm,amba-bus";
+		compatible = "arm,amba-bus", "simple-bus";
 		interrupt-parent = <&gic>;
 		ranges = <0 0xfc000000 0x2000000>;
 
diff --git a/arch/arm/boot/dts/hip01.dtsi b/arch/arm/boot/dts/hip01.dtsi
index 33130f8..0835627 100644
--- a/arch/arm/boot/dts/hip01.dtsi
+++ b/arch/arm/boot/dts/hip01.dtsi
@@ -43,7 +43,7 @@
 		amba {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			compatible = "arm,amba-bus";
+			compatible = "arm,amba-bus", "simple-bus";
 			ranges;
 
 			uart0: uart at 10001000 {
diff --git a/arch/arm/boot/dts/hisi-x5hd2.dtsi b/arch/arm/boot/dts/hisi-x5hd2.dtsi
index c52722b..f3a79b7 100644
--- a/arch/arm/boot/dts/hisi-x5hd2.dtsi
+++ b/arch/arm/boot/dts/hisi-x5hd2.dtsi
@@ -34,7 +34,7 @@
 		amba {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			compatible = "arm,amba-bus";
+			compatible = "arm,amba-bus", "simple-bus";
 			ranges;
 
 			timer0: timer at 00002000 {
diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index ed521e8..ca93486 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -721,7 +721,7 @@
 		};
 
 		amba {
-			compatible = "arm,amba-bus";
+			compatible = "arm,amba-bus", "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index e5f7f33..e05773c 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -167,7 +167,7 @@
 		};
 
 		amba {
-			compatible = "arm,amba-bus";
+			compatible = "arm,amba-bus", "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index 51a40d8..7e7e891 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -251,7 +251,7 @@
 		};
 
 		amba {
-			compatible = "arm,amba-bus";
+			compatible = "arm,amba-bus", "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index b9567c1..c15fdf4 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -94,7 +94,7 @@
 	};
 
 	amba {
-		compatible = "arm,amba-bus";
+		compatible = "arm,amba-bus", "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
diff --git a/arch/arm/boot/dts/rk3228.dtsi b/arch/arm/boot/dts/rk3228.dtsi
index 119ff12..8b4e443 100644
--- a/arch/arm/boot/dts/rk3228.dtsi
+++ b/arch/arm/boot/dts/rk3228.dtsi
@@ -96,7 +96,7 @@
 	};
 
 	amba {
-		compatible = "arm,amba-bus";
+		compatible = "arm,amba-bus", "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 8ac49f3..af111fa 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -134,7 +134,7 @@
 	};
 
 	amba {
-		compatible = "arm,amba-bus";
+		compatible = "arm,amba-bus", "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index 99eeea7..c969e84 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -67,7 +67,7 @@
 	};
 
 	amba {
-		compatible = "arm,amba-bus";
+		compatible = "arm,amba-bus", "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
index 8344a0e..e945c343 100644
--- a/arch/arm/boot/dts/s5pv210.dtsi
+++ b/arch/arm/boot/dts/s5pv210.dtsi
@@ -130,7 +130,7 @@
 		amba {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			compatible = "arm,amba-bus";
+			compatible = "arm,amba-bus", "simple-bus";
 			ranges;
 
 			pdma0: dma at e0900000 {
diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 3ed4abd..cadc637 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -69,7 +69,7 @@
 		ranges;
 
 		amba {
-			compatible = "arm,amba-bus";
+			compatible = "arm,amba-bus", "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index cce9e50..06a8e86 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -63,7 +63,7 @@
 		ranges;
 
 		amba {
-			compatible = "arm,amba-bus";
+			compatible = "arm,amba-bus", "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
index 27a333e..74732e4 100644
--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -721,7 +721,7 @@
 	};
 
 	amba {
-		compatible = "arm,amba-bus";
+		compatible = "arm,amba-bus", "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
diff --git a/arch/arm/boot/dts/ste-u300.dts b/arch/arm/boot/dts/ste-u300.dts
index 9c73ac2..763a607 100644
--- a/arch/arm/boot/dts/ste-u300.dts
+++ b/arch/arm/boot/dts/ste-u300.dts
@@ -384,7 +384,7 @@
 	};
 
 	amba {
-		compatible = "arm,amba-bus";
+		compatible = "arm,amba-bus", "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
diff --git a/arch/arm/boot/dts/versatile-ab.dts b/arch/arm/boot/dts/versatile-ab.dts
index 6fd7efb..01156cf 100644
--- a/arch/arm/boot/dts/versatile-ab.dts
+++ b/arch/arm/boot/dts/versatile-ab.dts
@@ -148,7 +148,7 @@
 	};
 
 	amba {
-		compatible = "arm,amba-bus";
+		compatible = "arm,amba-bus", "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
-- 
1.9.1
