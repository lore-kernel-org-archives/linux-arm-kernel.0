From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed,  9 Mar 2016 13:26:45 +0900
Subject: [PATCH v3] ARM, ARM64: dts: drop "arm,
 amba-bus" in favor of "simple-bus"
Message-ID: <1457497605-10079-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The compatible string "simple-bus" is well defined in ePAPR, while
I see no documentation for the "arm,amba-bus" arnywhere in ePAPR or
Documentation/devicetree/.

DT is also used by other projects than Linux kernel.  It is not a
good idea to rely on such an unofficial binding.

This commit
  - replaces "arm,amba-bus" with "simple-bus"
  - drops "arm,amba-bus" where it is used along with "simple-bus"

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3:
  - Kill "arm,amba-bus" completely

Changes in v2:
  - Rephrase the git-log

 arch/arm/boot/dts/axm55xx.dtsi                   | 2 +-
 arch/arm/boot/dts/exynos3250.dtsi                | 2 +-
 arch/arm/boot/dts/exynos4.dtsi                   | 2 +-
 arch/arm/boot/dts/exynos4415.dtsi                | 2 +-
 arch/arm/boot/dts/exynos5250.dtsi                | 2 +-
 arch/arm/boot/dts/exynos5420.dtsi                | 2 +-
 arch/arm/boot/dts/exynos5440.dtsi                | 2 +-
 arch/arm/boot/dts/hi3620.dtsi                    | 2 +-
 arch/arm/boot/dts/hip01.dtsi                     | 2 +-
 arch/arm/boot/dts/hisi-x5hd2.dtsi                | 2 +-
 arch/arm/boot/dts/integrator.dtsi                | 2 +-
 arch/arm/boot/dts/qcom-apq8064.dtsi              | 2 +-
 arch/arm/boot/dts/qcom-msm8660.dtsi              | 2 +-
 arch/arm/boot/dts/qcom-msm8960.dtsi              | 2 +-
 arch/arm/boot/dts/rk3036.dtsi                    | 2 +-
 arch/arm/boot/dts/rk3228.dtsi                    | 2 +-
 arch/arm/boot/dts/rk3288.dtsi                    | 2 +-
 arch/arm/boot/dts/rk3xxx.dtsi                    | 2 +-
 arch/arm/boot/dts/s5pv210.dtsi                   | 2 +-
 arch/arm/boot/dts/socfpga.dtsi                   | 2 +-
 arch/arm/boot/dts/socfpga_arria10.dtsi           | 2 +-
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi       | 2 +-
 arch/arm/boot/dts/ste-u300.dts                   | 2 +-
 arch/arm/boot/dts/versatile-ab.dts               | 2 +-
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi          | 2 +-
 arch/arm/boot/dts/vexpress-v2m.dtsi              | 2 +-
 arch/arm64/boot/dts/arm/foundation-v8.dts        | 2 +-
 arch/arm64/boot/dts/arm/juno-motherboard.dtsi    | 2 +-
 arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi | 2 +-
 29 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/arm/boot/dts/axm55xx.dtsi b/arch/arm/boot/dts/axm55xx.dtsi
index ea288f0..a9d6d59 100644
--- a/arch/arm/boot/dts/axm55xx.dtsi
+++ b/arch/arm/boot/dts/axm55xx.dtsi
@@ -107,7 +107,7 @@
 		};
 
 		amba {
-			compatible = "arm,amba-bus";
+			compatible = "simple-bus";
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 18e3def..c61ec96 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -381,7 +381,7 @@
 		};
 
 		amba {
-			compatible = "arm,amba-bus";
+			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 045785c..3647f96 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -661,7 +661,7 @@
 	amba {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "arm,amba-bus";
+		compatible = "simple-bus";
 		interrupt-parent = <&gic>;
 		ranges;
 
diff --git a/arch/arm/boot/dts/exynos4415.dtsi b/arch/arm/boot/dts/exynos4415.dtsi
index ad76484..28b04b6 100644
--- a/arch/arm/boot/dts/exynos4415.dtsi
+++ b/arch/arm/boot/dts/exynos4415.dtsi
@@ -380,7 +380,7 @@
 		};
 
 		amba {
-			compatible = "arm,amba-bus";
+			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			interrupt-parent = <&gic>;
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 33e2d5f..56ba53e 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -674,7 +674,7 @@
 	amba {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "arm,amba-bus";
+		compatible = "simple-bus";
 		interrupt-parent = <&gic>;
 		ranges;
 
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 48a0a55..ec80ddb 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -327,7 +327,7 @@
 	amba {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "arm,amba-bus";
+		compatible = "simple-bus";
 		interrupt-parent = <&gic>;
 		ranges;
 
diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index f18b51f..b9342ec 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -200,7 +200,7 @@
 	amba {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "arm,amba-bus";
+		compatible = "simple-bus";
 		interrupt-parent = <&gic>;
 		ranges;
 	};
diff --git a/arch/arm/boot/dts/hi3620.dtsi b/arch/arm/boot/dts/hi3620.dtsi
index 6cbb62e..c85d07e 100644
--- a/arch/arm/boot/dts/hi3620.dtsi
+++ b/arch/arm/boot/dts/hi3620.dtsi
@@ -68,7 +68,7 @@
 
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "arm,amba-bus";
+		compatible = "simple-bus";
 		interrupt-parent = <&gic>;
 		ranges = <0 0xfc000000 0x2000000>;
 
diff --git a/arch/arm/boot/dts/hip01.dtsi b/arch/arm/boot/dts/hip01.dtsi
index 33130f8..4e9562f 100644
--- a/arch/arm/boot/dts/hip01.dtsi
+++ b/arch/arm/boot/dts/hip01.dtsi
@@ -43,7 +43,7 @@
 		amba {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			compatible = "arm,amba-bus";
+			compatible = "simple-bus";
 			ranges;
 
 			uart0: uart at 10001000 {
diff --git a/arch/arm/boot/dts/hisi-x5hd2.dtsi b/arch/arm/boot/dts/hisi-x5hd2.dtsi
index c52722b..fdcc23d 100644
--- a/arch/arm/boot/dts/hisi-x5hd2.dtsi
+++ b/arch/arm/boot/dts/hisi-x5hd2.dtsi
@@ -34,7 +34,7 @@
 		amba {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			compatible = "arm,amba-bus";
+			compatible = "simple-bus";
 			ranges;
 
 			timer0: timer at 00002000 {
diff --git a/arch/arm/boot/dts/integrator.dtsi b/arch/arm/boot/dts/integrator.dtsi
index 3807d4f..b82f0e6 100644
--- a/arch/arm/boot/dts/integrator.dtsi
+++ b/arch/arm/boot/dts/integrator.dtsi
@@ -57,7 +57,7 @@
 	};
 
 	fpga {
-		compatible = "arm,amba-bus", "simple-bus";
+		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index ed521e8..38a63b6 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -721,7 +721,7 @@
 		};
 
 		amba {
-			compatible = "arm,amba-bus";
+			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index e5f7f33..f1166cd 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -167,7 +167,7 @@
 		};
 
 		amba {
-			compatible = "arm,amba-bus";
+			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index 51a40d8..da05e28 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -251,7 +251,7 @@
 		};
 
 		amba {
-			compatible = "arm,amba-bus";
+			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index b9567c1..3309f0d 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -94,7 +94,7 @@
 	};
 
 	amba {
-		compatible = "arm,amba-bus";
+		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
diff --git a/arch/arm/boot/dts/rk3228.dtsi b/arch/arm/boot/dts/rk3228.dtsi
index 119ff12..4dae42a 100644
--- a/arch/arm/boot/dts/rk3228.dtsi
+++ b/arch/arm/boot/dts/rk3228.dtsi
@@ -96,7 +96,7 @@
 	};
 
 	amba {
-		compatible = "arm,amba-bus";
+		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 8ac49f3..532c7ca 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -134,7 +134,7 @@
 	};
 
 	amba {
-		compatible = "arm,amba-bus";
+		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index 99eeea7..cbd3041 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -67,7 +67,7 @@
 	};
 
 	amba {
-		compatible = "arm,amba-bus";
+		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
index 8344a0e..ffc36bd 100644
--- a/arch/arm/boot/dts/s5pv210.dtsi
+++ b/arch/arm/boot/dts/s5pv210.dtsi
@@ -130,7 +130,7 @@
 		amba {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			compatible = "arm,amba-bus";
+			compatible = "simple-bus";
 			ranges;
 
 			pdma0: dma at e0900000 {
diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 3ed4abd..ece1169 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -69,7 +69,7 @@
 		ranges;
 
 		amba {
-			compatible = "arm,amba-bus";
+			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index cce9e50..1c5e139 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -63,7 +63,7 @@
 		ranges;
 
 		amba {
-			compatible = "arm,amba-bus";
+			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
index 27a333e..e2be533 100644
--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -721,7 +721,7 @@
 	};
 
 	amba {
-		compatible = "arm,amba-bus";
+		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
diff --git a/arch/arm/boot/dts/ste-u300.dts b/arch/arm/boot/dts/ste-u300.dts
index 9c73ac2..2f5107f 100644
--- a/arch/arm/boot/dts/ste-u300.dts
+++ b/arch/arm/boot/dts/ste-u300.dts
@@ -384,7 +384,7 @@
 	};
 
 	amba {
-		compatible = "arm,amba-bus";
+		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
diff --git a/arch/arm/boot/dts/versatile-ab.dts b/arch/arm/boot/dts/versatile-ab.dts
index 6fd7efb..d23320a 100644
--- a/arch/arm/boot/dts/versatile-ab.dts
+++ b/arch/arm/boot/dts/versatile-ab.dts
@@ -148,7 +148,7 @@
 	};
 
 	amba {
-		compatible = "arm,amba-bus";
+		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
diff --git a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
index 21b0287..7a556b9 100644
--- a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
+++ b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
@@ -66,7 +66,7 @@
 		};
 
 		iofpga at 3,00000000 {
-			compatible = "arm,amba-bus", "simple-bus";
+			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 3 0 0x200000>;
diff --git a/arch/arm/boot/dts/vexpress-v2m.dtsi b/arch/arm/boot/dts/vexpress-v2m.dtsi
index e712c0a..47e4a11 100644
--- a/arch/arm/boot/dts/vexpress-v2m.dtsi
+++ b/arch/arm/boot/dts/vexpress-v2m.dtsi
@@ -65,7 +65,7 @@
 		};
 
 		iofpga at 7,00000000 {
-			compatible = "arm,amba-bus", "simple-bus";
+			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 7 0 0x20000>;
diff --git a/arch/arm64/boot/dts/arm/foundation-v8.dts b/arch/arm64/boot/dts/arm/foundation-v8.dts
index 4eac8dc..fc85d13 100644
--- a/arch/arm64/boot/dts/arm/foundation-v8.dts
+++ b/arch/arm64/boot/dts/arm/foundation-v8.dts
@@ -188,7 +188,7 @@
 		};
 
 		iofpga at 3,00000000 {
-			compatible = "arm,amba-bus", "simple-bus";
+			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 3 0 0x200000>;
diff --git a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
index 413f1b9..485d605 100644
--- a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
@@ -139,7 +139,7 @@
 			};
 
 			iofpga at 3,00000000 {
-				compatible = "arm,amba-bus", "simple-bus";
+				compatible = "simple-bus";
 				#address-cells = <1>;
 				#size-cells = <1>;
 				ranges = <0 3 0 0x200000>;
diff --git a/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi b/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
index 88a7583..1de622b 100644
--- a/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
+++ b/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
@@ -55,7 +55,7 @@
 		};
 
 		iofpga at 3,00000000 {
-			compatible = "arm,amba-bus", "simple-bus";
+			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 3 0 0x200000>;
-- 
1.9.1
