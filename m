From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 17 Aug 2016 09:34:58 +0200
Subject: [PATCH] ARM: dts: exynos: Use stdout non-deprecated property and add
 serial options to Odroid XU/XU3/XU4
Message-ID: <1471419298-10414-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "linux,stdout-path" is deprecated.

Add serial options so the console can be properly configured when
bootloader does not pass "console" parameter to command line.  Without
options and lack of "console", the serial output dies during boot (just
after probing sound).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos5410-odroidxu.dts          | 2 +-
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5410-odroidxu.dts b/arch/arm/boot/dts/exynos5410-odroidxu.dts
index f6d135245a4b..a5ae76c1838f 100644
--- a/arch/arm/boot/dts/exynos5410-odroidxu.dts
+++ b/arch/arm/boot/dts/exynos5410-odroidxu.dts
@@ -26,7 +26,7 @@
 	};
 
 	chosen {
-		linux,stdout-path = &serial_2;
+		stdout-path = "serial2:115200n8";
 	};
 
 	emmc_pwrseq: pwrseq {
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index d56253049ccb..d04490d40b07 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -26,7 +26,7 @@
 	};
 
 	chosen {
-		linux,stdout-path = &serial_2;
+		stdout-path = "serial2:115200n8";
 	};
 
 	firmware at 02073000 {
-- 
1.9.1
