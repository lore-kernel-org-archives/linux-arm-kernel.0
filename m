From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun,  8 May 2016 21:05:51 +0200
Subject: [PATCH v2 06/22] ARM: dts: exynos: Remove old fixed-clock provider on
 SMDK5410
In-Reply-To: <1462734367-5619-1-git-send-email-krzk@kernel.org>
References: <1462734367-5619-1-git-send-email-krzk@kernel.org>
Message-ID: <1462734367-5619-7-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All "fin_pll" clock users are switched to the new one, provided by
Exynos5410 clock driver. Remove old DT node.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5410-smdk5410.dts | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5410-smdk5410.dts b/arch/arm/boot/dts/exynos5410-smdk5410.dts
index d7d658deeff4..377a679b454b 100644
--- a/arch/arm/boot/dts/exynos5410-smdk5410.dts
+++ b/arch/arm/boot/dts/exynos5410-smdk5410.dts
@@ -24,13 +24,6 @@
 		bootargs = "console=ttySAC2,115200";
 	};
 
-	fin_pll: xxti {
-		compatible = "fixed-clock";
-		clock-frequency = <24000000>;
-		clock-output-names = "fin_pll";
-		#clock-cells = <0>;
-	};
-
 	fixed-rate-clocks {
 		oscclk {
 			compatible = "samsung,exynos5420-oscclk";
-- 
2.5.0
