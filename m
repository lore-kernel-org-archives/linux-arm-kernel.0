From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 11 Mar 2014 16:54:53 +0900
Subject: [PATCH 4/5] ARM: dts: exynos: Move common dt data for interrupt
 combiner controller
In-Reply-To: <1394524494-30641-1-git-send-email-cw00.choi@samsung.com>
References: <1394524494-30641-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1394524494-30641-5-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch move common dt data of interrupt combiner controller to
exynos4x12.dtsi. Each Exynos4x12 SoC has different number of interrput combiner
as following:
- Exynos4212 : interrput combiner 18(0 ~ 17)
- Exynos4412 : interrput combiner 20(0 ~ 19)

The exynos combiner driver initialize interrupt according to specific number
of interrput combiner.
- samsung,combiner-nr : The number of interrput combiners supported.

Also,
This patch arrange again the dt data according to register address
in exynos4212/exynos4412.dtsi.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4212.dtsi | 13 ++++---------
 arch/arm/boot/dts/exynos4412.dtsi | 14 ++++----------
 arch/arm/boot/dts/exynos4x12.dtsi |  8 ++++++++
 3 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4212.dtsi b/arch/arm/boot/dts/exynos4212.dtsi
index 94a43f9..ceefc71 100644
--- a/arch/arm/boot/dts/exynos4212.dtsi
+++ b/arch/arm/boot/dts/exynos4212.dtsi
@@ -22,16 +22,11 @@
 / {
 	compatible = "samsung,exynos4212";
 
-	gic: interrupt-controller at 10490000 {
-		cpu-offset = <0x8000>;
+	combiner: interrupt-controller at 10440000 {
+		samsung,combiner-nr = <18>;
 	};
 
-	interrupt-controller at 10440000 {
-		samsung,combiner-nr = <18>;
-		interrupts = <0 0 0>, <0 1 0>, <0 2 0>, <0 3 0>,
-			     <0 4 0>, <0 5 0>, <0 6 0>, <0 7 0>,
-			     <0 8 0>, <0 9 0>, <0 10 0>, <0 11 0>,
-			     <0 12 0>, <0 13 0>, <0 14 0>, <0 15 0>,
-			     <0 107 0>, <0 108 0>;
+	gic: interrupt-controller at 10490000 {
+		cpu-offset = <0x8000>;
 	};
 };
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 87b339c..a40b6e2 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -22,17 +22,11 @@
 / {
 	compatible = "samsung,exynos4412";
 
-	gic: interrupt-controller at 10490000 {
-		cpu-offset = <0x4000>;
-	};
-
-	interrupt-controller at 10440000 {
+	combiner: interrupt-controller at 10440000 {
 		samsung,combiner-nr = <20>;
-		interrupts = <0 0 0>, <0 1 0>, <0 2 0>, <0 3 0>,
-			     <0 4 0>, <0 5 0>, <0 6 0>, <0 7 0>,
-			     <0 8 0>, <0 9 0>, <0 10 0>, <0 11 0>,
-			     <0 12 0>, <0 13 0>, <0 14 0>, <0 15 0>,
-			     <0 107 0>, <0 108 0>, <0 48 0>, <0 42 0>;
 	};
 
+	gic: interrupt-controller at 10490000 {
+		cpu-offset = <0x4000>;
+	};
 };
diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index 066eb35..6e17034 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -73,6 +73,14 @@
 		};
 	};
 
+	combiner: interrupt-controller at 10440000 {
+		interrupts = <0 0 0>, <0 1 0>, <0 2 0>, <0 3 0>,
+			     <0 4 0>, <0 5 0>, <0 6 0>, <0 7 0>,
+			     <0 8 0>, <0 9 0>, <0 10 0>, <0 11 0>,
+			     <0 12 0>, <0 13 0>, <0 14 0>, <0 15 0>,
+			     <0 107 0>, <0 108 0>, <0 48 0>, <0 42 0>;
+	};
+
 	pinctrl_0: pinctrl at 11400000 {
 		compatible = "samsung,exynos4x12-pinctrl";
 		reg = <0x11400000 0x1000>;
-- 
1.8.0
