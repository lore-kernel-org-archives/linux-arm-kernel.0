From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 18 Apr 2014 16:43:01 +0200
Subject: [PATCH 4/4] ARM: dts: exynos4: Add CPU topology data
In-Reply-To: <1397832181-5153-1-git-send-email-t.figa@samsung.com>
References: <1397832181-5153-1-git-send-email-t.figa@samsung.com>
Message-ID: <1397832181-5153-5-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After fixing non-banked GIC support in GIC driver, CPU nodes can be
safely added to Exynos4 device tree sources, along with appropriate
gic-offset properties.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/boot/dts/exynos4210.dtsi | 19 +++++++++++++++++++
 arch/arm/boot/dts/exynos4212.dtsi | 19 +++++++++++++++++++
 arch/arm/boot/dts/exynos4412.dtsi | 37 +++++++++++++++++++++++++++++++++----
 3 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index cacf614..e463361 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -25,6 +25,25 @@
 / {
 	compatible = "samsung,exynos4210", "samsung,exynos4";
 
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 900 {
+			compatible = "arm,cortex-a9";
+			device_type = "cpu";
+			reg = <0x900>;
+			gic-offset = <0x0000>;
+		};
+
+		cpu at 901 {
+			compatible = "arm,cortex-a9";
+			device_type = "cpu";
+			reg = <0x901>;
+			gic-offset = <0x8000>;
+		};
+	};
+
 	aliases {
 		pinctrl0 = &pinctrl_0;
 		pinctrl1 = &pinctrl_1;
diff --git a/arch/arm/boot/dts/exynos4212.dtsi b/arch/arm/boot/dts/exynos4212.dtsi
index 3c00e6e..211e129 100644
--- a/arch/arm/boot/dts/exynos4212.dtsi
+++ b/arch/arm/boot/dts/exynos4212.dtsi
@@ -22,6 +22,25 @@
 / {
 	compatible = "samsung,exynos4212", "samsung,exynos4";
 
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at a00 {
+			compatible = "arm,cortex-a9";
+			device_type = "cpu";
+			reg = <0xa00>;
+			gic-offset = <0x0000>;
+		};
+
+		cpu at a01 {
+			compatible = "arm,cortex-a9";
+			device_type = "cpu";
+			reg = <0xa01>;
+			gic-offset = <0x8000>;
+		};
+	};
+
 	combiner: interrupt-controller at 10440000 {
 		samsung,combiner-nr = <18>;
 	};
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 15d3c0a..04530ef 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -22,11 +22,40 @@
 / {
 	compatible = "samsung,exynos4412", "samsung,exynos4";
 
-	combiner: interrupt-controller at 10440000 {
-		samsung,combiner-nr = <20>;
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at a00 {
+			compatible = "arm,cortex-a9";
+			device_type = "cpu";
+			reg = <0xa00>;
+			gic-offset = <0x0000>;
+		};
+
+		cpu at a01 {
+			compatible = "arm,cortex-a9";
+			device_type = "cpu";
+			reg = <0xa01>;
+			gic-offset = <0x4000>;
+		};
+
+		cpu at a02 {
+			compatible = "arm,cortex-a9";
+			device_type = "cpu";
+			reg = <0xa02>;
+			gic-offset = <0x8000>;
+		};
+
+		cpu at a03 {
+			compatible = "arm,cortex-a9";
+			device_type = "cpu";
+			reg = <0xa03>;
+			gic-offset = <0xc000>;
+		};
 	};
 
-	gic: interrupt-controller at 10490000 {
-		cpu-offset = <0x4000>;
+	combiner: interrupt-controller at 10440000 {
+		samsung,combiner-nr = <20>;
 	};
 };
-- 
1.9.2
