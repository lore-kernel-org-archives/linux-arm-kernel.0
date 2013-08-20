From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 20 Aug 2013 19:35:36 +0200
Subject: [PATCH] ARM: dts: exynos4210: Work around lack of cpufreq regulator
 lookup
Message-ID: <1377020136-14838-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos cpufreq drivers does not support device tree based regulator
lookup, so it can get the VDD ARM regulator only by its name. To get
cpufreq working for now, this patch works this around by renaming the
regulator in board dts files to vdd_arm, which is the name expected by
the driver.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4210-origen.dts | 7 ++++++-
 arch/arm/boot/dts/exynos4210-trats.dts  | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index 382d8c7..46378fe 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -192,7 +192,12 @@
 				};
 
 				buck1_reg: BUCK1 {
-					regulator-name = "VDD_ARM_1.2V";
+					/*
+					* HACK: The real name is VDD_ARM_1.2V,
+					* but exynos-cpufreq does not support
+					* DT-based regulator lookup yet.
+					*/
+					regulator-name = "vdd_arm";
 					regulator-min-microvolt = <950000>;
 					regulator-max-microvolt	= <1350000>;
 					regulator-always-on;
diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index 1c164f2..63cc571 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -290,7 +290,12 @@
 				};
 
 				varm_breg: BUCK1 {
-				     regulator-name = "VARM_1.2V_C210";
+				     /*
+				      * HACK: The real name is VARM_1.2V_C210,
+				      * but exynos-cpufreq does not support
+				      * DT-based regulator lookup yet.
+				      */
+				     regulator-name = "vdd_arm";
 				     regulator-min-microvolt = <900000>;
 				     regulator-max-microvolt = <1350000>;
 				     regulator-always-on;
-- 
1.8.3.2
