From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 10 Sep 2014 18:37:34 +0200
Subject: [PATCH] ARM: dts: Specify default clocks for Exynos4 FIMC devices
Message-ID: <1410367054-30926-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The default mux and divider clocks are specified in device tree
so that the FIMC devices in Exynos4210 and Exynos4x12 SoCs are
clocked from recommended clock source and with maximum supported
frequency. If needed these settings could be overrode in board
specific dts files, however they are in practice optimal in most
cases.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/boot/dts/exynos4210.dtsi |   16 ++++++++++++++++
 arch/arm/boot/dts/exynos4x12.dtsi |   16 ++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 807bb5b..0969d2e 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -154,18 +154,30 @@
 			samsung,pix-limits = <4224 8192 1920 4224>;
 			samsung,mainscaler-ext;
 			samsung,cam-if;
+			assigned-clocks = <&clock CLK_MOUT_FIMC0>,
+					<&clock CLK_SCLK_FIMC0>;
+			assigned-clock-parents = <&clock CLK_SCLK_MPLL>;
+			assigned-clock-rates = <0>, <160000000>;
 		};
 
 		fimc_1: fimc at 11810000 {
 			samsung,pix-limits = <4224 8192 1920 4224>;
 			samsung,mainscaler-ext;
 			samsung,cam-if;
+			assigned-clocks = <&clock CLK_MOUT_FIMC1>,
+					<&clock CLK_SCLK_FIMC1>;
+			assigned-clock-parents = <&clock CLK_SCLK_MPLL>;
+			assigned-clock-rates = <0>, <160000000>;
 		};
 
 		fimc_2: fimc at 11820000 {
 			samsung,pix-limits = <4224 8192 1920 4224>;
 			samsung,mainscaler-ext;
 			samsung,lcd-wb;
+			assigned-clocks = <&clock CLK_MOUT_FIMC2>,
+					<&clock CLK_SCLK_FIMC2>;
+			assigned-clock-parents = <&clock CLK_SCLK_MPLL>;
+			assigned-clock-rates = <0>, <160000000>;
 		};
 
 		fimc_3: fimc at 11830000 {
@@ -173,6 +185,10 @@
 			samsung,rotators = <0>;
 			samsung,mainscaler-ext;
 			samsung,lcd-wb;
+			assigned-clocks = <&clock CLK_MOUT_FIMC3>,
+					<&clock CLK_SCLK_FIMC3>;
+			assigned-clock-parents = <&clock CLK_SCLK_MPLL>;
+			assigned-clock-rates = <0>, <160000000>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index 861bb91..38ba14f 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -162,6 +162,10 @@
 			samsung,mainscaler-ext;
 			samsung,isp-wb;
 			samsung,cam-if;
+			assigned-clocks = <&clock CLK_MOUT_FIMC0>,
+					<&clock CLK_SCLK_FIMC0>;
+			assigned-clock-parents = <&clock CLK_MOUT_MPLL_USER_T>;
+			assigned-clock-rates = <0>, <176000000>;
 		};
 
 		fimc_1: fimc at 11810000 {
@@ -170,6 +174,10 @@
 			samsung,mainscaler-ext;
 			samsung,isp-wb;
 			samsung,cam-if;
+			assigned-clocks = <&clock CLK_MOUT_FIMC1>,
+					<&clock CLK_SCLK_FIMC1>;
+			assigned-clock-parents = <&clock CLK_MOUT_MPLL_USER_T>;
+			assigned-clock-rates = <0>, <176000000>;
 		};
 
 		fimc_2: fimc at 11820000 {
@@ -179,6 +187,10 @@
 			samsung,isp-wb;
 			samsung,lcd-wb;
 			samsung,cam-if;
+			assigned-clocks = <&clock CLK_MOUT_FIMC2>,
+					<&clock CLK_SCLK_FIMC2>;
+			assigned-clock-parents = <&clock CLK_MOUT_MPLL_USER_T>;
+			assigned-clock-rates = <0>, <176000000>;
 		};
 
 		fimc_3: fimc at 11830000 {
@@ -188,6 +200,10 @@
 			samsung,mainscaler-ext;
 			samsung,isp-wb;
 			samsung,lcd-wb;
+			assigned-clocks = <&clock CLK_MOUT_FIMC3>,
+					<&clock CLK_SCLK_FIMC3>;
+			assigned-clock-parents = <&clock CLK_MOUT_MPLL_USER_T>;
+			assigned-clock-rates = <0>, <176000000>;
 		};
 
 		fimc_lite_0: fimc-lite at 12390000 {
-- 
1.7.9.5
