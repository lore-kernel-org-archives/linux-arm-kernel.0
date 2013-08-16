From: padma.v@samsung.com (Padmavathi Venna)
Date: Fri, 16 Aug 2013 09:56:18 +0530
Subject: [PATCH V5] ARM: dts: Change i2s compatible string on exynos5250
Message-ID: <1376627178-28649-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes quirks from i2s node and change the i2s
compatible names.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---

Changes since V4:
	- Mark Brown reverted the below two patches due to below build failure with
	  exynos_defconfig.
		"ARM: dts: exynos5250: move common i2s properties to exynos5 dtsi"
		"ARM: dts: Change i2s compatible string on exynos5250"

	  build error:
	  DTC     arch/arm/boot/dts/exynos5420-smdk5420.dtb
	  ERROR (phandle_references): Reference to non-existent node or label "pdma1"
	  ERROR (phandle_references): Reference to non-existent node or label "pdma1"
	  ERROR (phandle_references): Reference to non-existent node or label "pdma0"
	  ERROR (phandle_references): Reference to non-existent node or label "pdma0"

But with out "ARM: dts: Change i2s compatible string on exynos5250" will break the i2s
driver.

So posting this patch now and will take care of posting other patch later after dependent
patches got merged.

 arch/arm/boot/dts/exynos5250.dtsi |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index ef57277..376090f 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -405,7 +405,7 @@
 	};
 
 	i2s0: i2s at 03830000 {
-		compatible = "samsung,i2s-v5";
+		compatible = "samsung,s5pv210-i2s";
 		reg = <0x03830000 0x100>;
 		dmas = <&pdma0 10
 			&pdma0 9
@@ -415,16 +415,13 @@
 			<&clock_audss EXYNOS_I2S_BUS>,
 			<&clock_audss EXYNOS_SCLK_I2S>;
 		clock-names = "iis", "i2s_opclk0", "i2s_opclk1";
-		samsung,supports-6ch;
-		samsung,supports-rstclr;
-		samsung,supports-secdai;
 		samsung,idma-addr = <0x03000000>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s0_bus>;
 	};
 
 	i2s1: i2s at 12D60000 {
-		compatible = "samsung,i2s-v5";
+		compatible = "samsung,s3c6410-i2s";
 		reg = <0x12D60000 0x100>;
 		dmas = <&pdma1 12
 			&pdma1 11>;
@@ -436,7 +433,7 @@
 	};
 
 	i2s2: i2s at 12D70000 {
-		compatible = "samsung,i2s-v5";
+		compatible = "samsung,s3c6410-i2s";
 		reg = <0x12D70000 0x100>;
 		dmas = <&pdma0 12
 			&pdma0 11>;
-- 
1.7.4.4
