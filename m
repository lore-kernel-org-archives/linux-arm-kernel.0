From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun,  7 Jan 2018 11:17:25 +0100
Subject: [PATCH] Revert "ARM: dts: exynos: Add missing interrupt-controller
 properties to Exynos5410 PMU"
Message-ID: <20180107101725.1545-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 6737b081409a4373e9d02c75aea7b916481e31b5.

Unlike on Exynos5420-family, on Exynos5410 the PMU is not an interrupt
controller so it should not handle interrupts of RTC.  The DTC warning
(addressed by mentioned commit) should be fixed by not routing RTC
interrupts to PMU.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5410.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index 375b73015ee4..83641ad0d8f2 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -72,9 +72,6 @@
 			clock-names = "clkout16";
 			clocks = <&fin_pll>;
 			#clock-cells = <1>;
-			interrupt-controller;
-			#interrupt-cells = <3>;
-			interrupt-parent = <&gic>;
 		};
 
 		clock: clock-controller at 10010000 {
-- 
2.11.0
