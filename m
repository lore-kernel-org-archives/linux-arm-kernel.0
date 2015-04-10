From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 10 Apr 2015 19:59:00 +0200
Subject: [PATCH 4/6] ARM: dts: Exynos4x12: add CPU OPP and regulator supply
 property
In-Reply-To: <1428688742-15578-1-git-send-email-b.zolnierkie@samsung.com>
References: <1428688742-15578-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1428688742-15578-5-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For Exynos4x12 platforms, add CPU operating points and CPU
regulator supply properties for migrating from Exynos specific
cpufreq driver to using generic cpufreq driver.

Based on the earlier work by Thomas Abraham.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Andreas Faerber <afaerber@suse.de>
Cc: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Andreas Farber <afaerber@suse.de>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/boot/dts/exynos4212.dtsi               |   22 ++++++++++++++++++++++
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi |    4 ++++
 arch/arm/boot/dts/exynos4412-origen.dts         |    5 +++++
 arch/arm/boot/dts/exynos4412-trats2.dts         |    5 +++++
 arch/arm/boot/dts/exynos4412.dtsi               |   22 ++++++++++++++++++++++
 5 files changed, 58 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4212.dtsi b/arch/arm/boot/dts/exynos4212.dtsi
index 5be0328..f97e4b5 100644
--- a/arch/arm/boot/dts/exynos4212.dtsi
+++ b/arch/arm/boot/dts/exynos4212.dtsi
@@ -30,6 +30,28 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0xA00>;
+			clocks = <&clock CLK_ARM_CLK>;
+			clock-names = "cpu";
+
+			operating-points = <
+				1400000 1287500
+				1300000 1250000
+				1200000 1187500
+				1100000 1137500
+				1000000 1087500
+				 900000 1037500
+				 800000 1000000
+				 700000  987500
+				 600000  975000
+				 500000  950000
+				 400000  925000
+				 300000  900000
+				 200000  900000
+			>;
+			boost-opps = <
+				1500000 1350000
+			>;
+			clock-latency = <200000>;
 			cooling-min-level = <13>;
 			cooling-max-level = <7>;
 			#cooling-cells = <2>; /* min followed by max */
diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index 8de12af..86f3830 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -504,3 +504,7 @@
 		samsung,pin-pud = <1>;
 	};
 };
+
+&cpu0 {
+	cpu0-supply = <&buck2_reg>;
+};
diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
index bd8b730..a9c957c 100644
--- a/arch/arm/boot/dts/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -532,3 +532,8 @@
 		};
 	};
 };
+
+
+&cpu0 {
+	cpu0-supply = <&buck2_reg>;
+};
diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 173ffa4..47f9b47 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -1304,3 +1304,8 @@
 		PIN_SLP(gpv4-0, INPUT, DOWN);
 	};
 };
+
+
+&cpu0 {
+	cpu0-supply = <&buck2_reg>;
+};
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 68ad43b..903981e8 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -30,6 +30,28 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0xA00>;
+			clocks = <&clock CLK_ARM_CLK>;
+			clock-names = "cpu";
+
+			operating-points = <
+				1400000 1287500
+				1300000 1250000
+				1200000 1187500
+				1100000 1137500
+				1000000 1087500
+				 900000 1037500
+				 800000 1000000
+				 700000  987500
+				 600000  975000
+				 500000  950000
+				 400000  925000
+				 300000  900000
+				 200000  900000
+			>;
+			boost-opps = <
+				1500000 1350000
+			>;
+			clock-latency = <200000>;
 			cooling-min-level = <13>;
 			cooling-max-level = <7>;
 			#cooling-cells = <2>; /* min followed by max */
-- 
1.7.9.5
