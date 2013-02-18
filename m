From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 18 Feb 2013 13:43:43 +0530
Subject: [PATCH 5/7] ARM: dts: add mct device tree node for all supported
 Exynos SoC's
In-Reply-To: <1361175225-19282-1-git-send-email-thomas.abraham@linaro.org>
References: <1361175225-19282-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1361175225-19282-6-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add MCT device tree node for Exynos4210, Exynos4212, Exynos4412 and Exynos5250.

Cc: Changhwan Youn <chaos.youn@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
Reviewed-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/exynos4210.dtsi |   22 ++++++++++++++++++++++
 arch/arm/boot/dts/exynos4212.dtsi |   22 ++++++++++++++++++++++
 arch/arm/boot/dts/exynos4412.dtsi |   24 ++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5250.dtsi |   22 ++++++++++++++++++++++
 4 files changed, 90 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 79ba247..0e16a34 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -47,6 +47,28 @@
 			     <0 12 0>, <0 13 0>, <0 14 0>, <0 15 0>;
 	};
 
+	mct at 10050000 {
+		compatible = "samsung,exynos4210-mct";
+		reg = <0x10050000 0x800>;
+		interrupt-controller;
+		#interrups-cells = <2>;
+		interrupt-parent = <&mct_map>;
+		interrupts = <0 0>, <1 0>, <2 0>, <3 0>,
+			     <4 0>, <5 0>;
+
+		mct_map: mct-map {
+			#interrupt-cells = <2>;
+			#address-cells = <0>;
+			#size-cells = <0>;
+			interrupt-map = <0x0 0 &gic 0 57 0>,
+					<0x1 0 &gic 0 69 0>,
+					<0x2 0 &combiner 12 6>,
+					<0x3 0 &combiner 12 7>,
+					<0x4 0 &gic 0 42 0>,
+					<0x5 0 &gic 0 48 0>;
+		};
+	};
+
 	pmu {
 		compatible = "arm,cortex-a9-pmu";
 		interrupt-parent = <&combiner>;
diff --git a/arch/arm/boot/dts/exynos4212.dtsi b/arch/arm/boot/dts/exynos4212.dtsi
index c6ae200..36d4299 100644
--- a/arch/arm/boot/dts/exynos4212.dtsi
+++ b/arch/arm/boot/dts/exynos4212.dtsi
@@ -25,4 +25,26 @@
 	gic:interrupt-controller at 10490000 {
 		cpu-offset = <0x8000>;
 	};
+
+	mct at 10050000 {
+		compatible = "samsung,exynos4412-mct";
+		reg = <0x10050000 0x800>;
+		interrupt-controller;
+		#interrups-cells = <2>;
+		interrupt-parent = <&mct_map>;
+		interrupts = <0 0>, <1 0>, <2 0>, <3 0>,
+			     <4 0>, <5 0>;
+
+		mct_map: mct-map {
+			#interrupt-cells = <2>;
+			#address-cells = <0>;
+			#size-cells = <0>;
+			interrupt-map = <0x0 0 &gic 0 57 0>,
+					<0x1 0 &combiner 12 5>,
+					<0x2 0 &combiner 12 6>,
+					<0x3 0 &combiner 12 7>,
+					<0x4 0 &gic 1 12 0>,
+					<0x5 0 &gic 1 12 0>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index d7dfe31..821c9fd 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -25,4 +25,28 @@
 	gic:interrupt-controller at 10490000 {
 		cpu-offset = <0x4000>;
 	};
+
+	mct at 10050000 {
+		compatible = "samsung,exynos4412-mct";
+		reg = <0x10050000 0x800>;
+		interrupt-controller;
+		#interrups-cells = <2>;
+		interrupt-parent = <&mct_map>;
+		interrupts = <0 0>, <1 0>, <2 0>, <3 0>,
+			     <4 0>, <5 0>, <6 0>, <7 0>;
+
+		mct_map: mct-map {
+			#interrupt-cells = <2>;
+			#address-cells = <0>;
+			#size-cells = <0>;
+			interrupt-map = <0x0 0 &gic 0 57 0>,
+					<0x1 0 &combiner 12 5>,
+					<0x2 0 &combiner 12 6>,
+					<0x3 0 &combiner 12 7>,
+					<0x4 0 &gic 1 12 0>,
+					<0x5 0 &gic 1 12 0>,
+					<0x6 0 &gic 1 12 0>,
+					<0x7 0 &gic 1 12 0>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 7c3d07a..8d8b5a0 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -79,6 +79,28 @@
 			     <0 28 0>, <0 29 0>, <0 30 0>, <0 31 0>;
 	};
 
+	mct at 101C0000 {
+		compatible = "samsung,exynos4210-mct";
+		reg = <0x101C0000 0x800>;
+		interrupt-controller;
+		#interrups-cells = <2>;
+		interrupt-parent = <&mct_map>;
+		interrupts = <0 0>, <1 0>, <2 0>, <3 0>,
+			     <4 0>, <5 0>;
+
+		mct_map: mct-map {
+			#interrupt-cells = <2>;
+			#address-cells = <0>;
+			#size-cells = <0>;
+			interrupt-map = <0x0 0 &combiner 23 3>,
+					<0x1 0 &combiner 23 4>,
+					<0x2 0 &combiner 25 2>,
+					<0x3 0 &combiner 25 3>,
+					<0x4 0 &gic 0 120 0>,
+					<0x5 0 &gic 0 121 0>;
+		};
+	};
+
 	pmu {
 		compatible = "arm,cortex-a15-pmu";
 		interrupt-parent = <&combiner>;
-- 
1.7.5.4
