From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 21 Sep 2018 20:30:14 +0200
Subject: [RFT] arm64: ARM: dts: exynos: Remove double SD card detect pin
 inversion on TM2
Message-ID: <20180921183014.20236-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SDHCI standard, MMC host controller bindings and MMC core defines
card detect pin as active low.  Therefore there is no point to invert it
twice.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index a1e3194b7483..86d8ddc3288a 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -939,8 +939,7 @@
 	status = "okay";
 	cap-sd-highspeed;
 	disable-wp;
-	cd-gpios = <&gpa2 4 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpa2 4 GPIO_ACTIVE_LOW>;
 	card-detect-delay = <200>;
 	samsung,dw-mshc-ciu-div = <3>;
 	samsung,dw-mshc-sdr-timing = <0 4>;
-- 
2.17.1
