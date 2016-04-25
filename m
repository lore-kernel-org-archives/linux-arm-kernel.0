From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 25 Apr 2016 11:29:56 +0200
Subject: [PATCH] ARM: dts: exynos: Enable PRNG and SSS for all Exynos4 devices
Message-ID: <1461576596-27844-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no external dependency for Security SubSystem (SSS) block so
the nodes for Pseudo Random Number Generator and AES hardware
acceleration can be enabled always for all Exynos4 devices.

Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi                  | 2 --
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 4 ----
 arch/arm/boot/dts/exynos4412-trats2.dts         | 8 --------
 3 files changed, 14 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index ffaceea74d79..5495b2bbc006 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -987,7 +987,6 @@
 		interrupts = <0 112 0>;
 		clocks = <&clock CLK_SSS>;
 		clock-names = "secss";
-		status = "disabled";
 	};
 
 	prng: rng at 10830400 {
@@ -995,7 +994,6 @@
 		reg = <0x10830400 0x200>;
 		clocks = <&clock CLK_SSS>;
 		clock-names = "secss";
-		status = "disabled";
 	};
 
 	register-debug {
diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index acd7e7b5fd13..cab0f07d7d28 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -496,10 +496,6 @@
 	status = "okay";
 };
 
-&sss {
-	status = "okay";
-};
-
 &tmu {
 	vtmu-supply = <&ldo10_reg>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 27dbf1687754..5d1eaea3f778 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -1234,10 +1234,6 @@
 	status = "okay";
 };
 
-&prng {
-	status = "okay";
-};
-
 &rtc {
 	status = "okay";
 	clocks = <&clock CLK_RTC>, <&max77686 MAX77686_CLK_AP>;
@@ -1286,10 +1282,6 @@
 	};
 };
 
-&sss {
-	status = "okay";
-};
-
 &tmu {
 	vtmu-supply = <&ldo10_reg>;
 	status = "okay";
-- 
1.9.1
