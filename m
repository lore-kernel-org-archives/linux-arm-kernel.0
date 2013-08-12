From: padma.v@samsung.com (Padmavathi Venna)
Date: Mon, 12 Aug 2013 15:19:54 +0530
Subject: [PATCH V4 4/4] ARM: dts: Change i2s compatible string on exynos5250
In-Reply-To: <1376300994-1679-1-git-send-email-padma.v@samsung.com>
References: <1376300994-1679-1-git-send-email-padma.v@samsung.com>
Message-ID: <1376300994-1679-5-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes quirks from i2s node and change the i2s
compatible names.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/boot/dts/exynos5.dtsi    |    4 ++--
 arch/arm/boot/dts/exynos5250.dtsi |    5 +----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
index aae2fa1..309894e 100644
--- a/arch/arm/boot/dts/exynos5.dtsi
+++ b/arch/arm/boot/dts/exynos5.dtsi
@@ -115,7 +115,7 @@
 	};
 
 	i2s1: i2s at 12D60000 {
-		compatible = "samsung,i2s-v5";
+		compatible = "samsung,s3c6410-i2s";
 		reg = <0x12D60000 0x100>;
 		dmas = <&pdma1 12
 			&pdma1 11>;
@@ -123,7 +123,7 @@
 	};
 
 	i2s2: i2s at 12D70000 {
-		compatible = "samsung,i2s-v5";
+		compatible = "samsung,s3c6410-i2s";
 		reg = <0x12D70000 0x100>;
 		dmas = <&pdma0 12
 			&pdma0 11>;
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index f941d52..ac5f5a1 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -405,7 +405,7 @@
 	};
 
 	i2s0: i2s at 03830000 {
-		compatible = "samsung,i2s-v5";
+		compatible = "samsung,s5pv210-i2s";
 		dmas = <&pdma0 10
 			&pdma0 9
 			&pdma0 8>;
@@ -414,9 +414,6 @@
 			<&clock_audss EXYNOS_I2S_BUS>,
 			<&clock_audss EXYNOS_SCLK_I2S>;
 		clock-names = "iis", "i2s_opclk0", "i2s_opclk1";
-		samsung,supports-6ch;
-		samsung,supports-rstclr;
-		samsung,supports-secdai;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s0_bus>;
 	};
-- 
1.7.4.4
