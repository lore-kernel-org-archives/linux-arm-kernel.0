From: chander.kashyap@linaro.org (Chander Kashyap)
Date: Wed, 28 Aug 2013 18:12:48 +0530
Subject: [PATCH 2/2] DTS: Exynos5: Remove invalid MCT properties
In-Reply-To: <1377693768-16777-1-git-send-email-chander.kashyap@linaro.org>
References: <1377693768-16777-1-git-send-email-chander.kashyap@linaro.org>
Message-ID: <1377693768-16777-3-git-send-email-chander.kashyap@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove interrupt-controller and #interrupt-cells properties of MCT device tree
node, as MCT is not an interrupt controllor.

Suggested by: Tomasz Figa

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
---
 arch/arm/boot/dts/exynos5250.dtsi |    2 --
 arch/arm/boot/dts/exynos5420.dtsi |    2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index f2f178a..dca90ec 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -101,8 +101,6 @@
 	mct at 101C0000 {
 		compatible = "samsung,exynos4210-mct";
 		reg = <0x101C0000 0x800>;
-		interrupt-controller;
-		#interrups-cells = <1>;
 		interrupt-parent = <&mct_map>;
 		interrupts = <0>, <1>, <2>, <3>, <4>, <5>;
 		clocks = <&clock 1>, <&clock 335>;
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 8c54c4b..6ce2f94 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -68,8 +68,6 @@
 	mct at 101C0000 {
 		compatible = "samsung,exynos4210-mct";
 		reg = <0x101C0000 0x800>;
-		interrupt-controller;
-		#interrups-cells = <1>;
 		interrupt-parent = <&mct_map>;
 		interrupts = <0>, <1>, <2>, <3>, <4>, <5>, <6>, <7>;
 		clocks = <&clock 1>, <&clock 315>;
-- 
1.7.9.5
