From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 03 Apr 2015 18:43:47 +0200
Subject: [PATCH 4/6] ARM: dts: Exynos4210: add CPU OPP and regulator supply
 property
In-Reply-To: <1428079429-4252-1-git-send-email-b.zolnierkie@samsung.com>
References: <'@samsung.com>
 <1428079429-4252-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1428079429-4252-5-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

For Exynos4210 platforms, add CPU operating points and CPU
regulator supply properties for migrating from Exynos specific
cpufreq driver to using generic cpufreq driver.

Changes by Bartlomiej:
- removed Exynos5250 and Exynos5420 support for now

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Andreas Faerber <afaerber@suse.de>
Cc: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Andreas Farber <afaerber@suse.de>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/boot/dts/exynos4210-origen.dts         |    4 ++++
 arch/arm/boot/dts/exynos4210-trats.dts          |    4 ++++
 arch/arm/boot/dts/exynos4210-universal_c210.dts |    4 ++++
 arch/arm/boot/dts/exynos4210.dtsi               |   12 ++++++++++++
 4 files changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index b811461..5b0941f 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -335,3 +335,7 @@
 		};
 	};
 };
+
+&cpu0 {
+	cpu0-supply = <&buck1_reg>;
+};
diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index 32c5fd8..9b5bdd0 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -483,3 +483,7 @@
 		};
 	};
 };
+
+&cpu0 {
+	cpu0-supply = <&varm_breg>;
+};
diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
index d4f2b11..5bf74da 100644
--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
@@ -567,3 +567,7 @@
 &mdma1 {
 	reg = <0x12840000 0x1000>;
 };
+
+&cpu0 {
+	cpu0-supply = <&vdd_arm_reg>;
+};
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index be89f83..df075e64 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -40,6 +40,18 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0x900>;
+			clocks = <&clock CLK_ARM_CLK>;
+			clock-names = "cpu";
+			clock-latency = <160000>;
+
+			operating-points = <
+				1200000 1250000
+				1000000 1150000
+				800000	1075000
+				500000	975000
+				400000	975000
+				200000	950000
+			>;
 			cooling-min-level = <4>;
 			cooling-max-level = <2>;
 			#cooling-cells = <2>; /* min followed by max */
-- 
1.7.9.5
