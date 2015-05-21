From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 21 May 2015 11:18:32 +0900
Subject: [PATCH 1/2] ARM: dts: exynos4: Remove obsolete MIPI DPHY 'reg'
 property
Message-ID: <1432174713-23368-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since e4b3d38088df ("phy: exynos-video-mipi: Fix regression by adding
support for PMU regmap") the Exynos PMU driver provides regmap to access
the MIPI DPHY registers. The MIPI DPHY node uses a phandle to syscon to
get this regmap. The 'reg' field is obsolete.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 1c74c1296ab7..6e7f0b4afa84 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -78,7 +78,6 @@
 
 	mipi_phy: video-phy at 10020710 {
 		compatible = "samsung,s5pv210-mipi-video-phy";
-		reg = <0x10020710 8>;
 		#phy-cells = <1>;
 		syscon = <&pmu_system_controller>;
 	};
-- 
1.9.1
