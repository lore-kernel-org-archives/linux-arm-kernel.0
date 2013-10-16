From: nm@ti.com (Nishanth Menon)
Date: Wed, 16 Oct 2013 10:39:08 -0500
Subject: [PATCH V7 8/8] ARM: dts: OMAP3: add clock nodes for CPU
In-Reply-To: <1381937948-27057-1-git-send-email-nm@ti.com>
References: <1381937948-27057-1-git-send-email-nm@ti.com>
Message-ID: <1381937948-27057-9-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP34xx and OMAP36xx platforms use dpll1 clock. Add same to common
definition.

AM33XX, OMAP443x, OMAP446x and OMAP447x platforms use dpll_mpu clock
Add same to common definition.

OMAP5, DRA7 platforms use dpll_mpu_ck clock for CPU. Add same to common
definition.

Cc: Benoit Cousson <bcousson@baylibre.com>
[nm at ti.com: keep in sync with clock node changes]
[j-keerthy at ti.com: OMAP5 and DRA7 nodes]
Signed-off-by: J Keerthy <j-keerthy@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |    4 ++++
 arch/arm/boot/dts/dra7.dtsi   |    5 +++++
 arch/arm/boot/dts/omap3.dtsi  |    5 +++++
 arch/arm/boot/dts/omap4.dtsi  |    5 +++++
 arch/arm/boot/dts/omap5.dtsi  |    6 ++++++
 5 files changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 2a994d6..09f16a0 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -55,6 +55,10 @@
 				275000  1125000
 			>;
 			voltage-tolerance = <2>; /* 2 percentage */
+
+			clocks = <&dpll_mpu_ck>;
+			clock-names = "cpu";
+
 			clock-latency = <300000>; /* From omap-cpufreq driver */
 		};
 	};
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 92cbe3b..e723b52 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -42,6 +42,11 @@
 				1000000	1060000
 				1176000	1160000
 				>;
+
+			clocks = <&dpll_mpu_ck>;
+			clock-names = "cpu";
+
+			clock-latency = <300000>; /* From omap-cpufreq driver */
 		};
 		cpu at 1 {
 			device_type = "cpu";
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 7f5d8a8..4f3778a 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -32,6 +32,11 @@
 			compatible = "arm,cortex-a8";
 			device_type = "cpu";
 			reg = <0x0>;
+
+			clocks = <&dpll1_ck>;
+			clock-names = "cpu";
+
+			clock-latency = <300000>; /* From omap-cpufreq driver */
 		};
 	};
 
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 17a3618..decff2a 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -32,6 +32,11 @@
 			device_type = "cpu";
 			next-level-cache = <&L2>;
 			reg = <0x0>;
+
+			clocks = <&dpll_mpu_ck>;
+			clock-names = "cpu";
+
+			clock-latency = <300000>; /* From omap-cpufreq driver */
 		};
 		cpu at 1 {
 			compatible = "arm,cortex-a9";
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 69874de..e18ee7e 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -44,6 +44,12 @@
 				1000000 1060000
 				1500000 1250000
 			>;
+
+			clocks = <&dpll_mpu_ck>;
+			clock-names = "cpu";
+
+			clock-latency = <300000>; /* From omap-cpufreq driver */
+
 		};
 		cpu at 1 {
 			device_type = "cpu";
-- 
1.7.9.5
