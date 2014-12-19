From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 19 Dec 2014 14:55:36 +0100
Subject: [PATCH v2 16/16] ARM: dts: Fix I2S1, I2S2 compatible for exynos4 SoCs
In-Reply-To: <1418997336-17777-1-git-send-email-s.nawrocki@samsung.com>
References: <1418997336-17777-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1418997336-17777-17-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I2S1, I2S2 on Exynos4 SoC series have limited functionality compared
to I2S0, "samsung,s3c6410-i2s" compatible should be used for them.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 5f9e72f..71dc876 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -371,7 +371,7 @@
 	};
 
 	i2s1: i2s at 13960000 {
-		compatible = "samsung,s5pv210-i2s";
+		compatible = "samsung,s3c6410-i2s";
 		reg = <0x13960000 0x100>;
 		clocks = <&clock CLK_I2S1>;
 		clock-names = "iis";
@@ -384,7 +384,7 @@
 	};
 
 	i2s2: i2s at 13970000 {
-		compatible = "samsung,s5pv210-i2s";
+		compatible = "samsung,s3c6410-i2s";
 		reg = <0x13970000 0x100>;
 		clocks = <&clock CLK_I2S2>;
 		clock-names = "iis";
-- 
1.7.9.5
