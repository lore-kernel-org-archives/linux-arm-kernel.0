From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 21 May 2015 11:18:33 +0900
Subject: [PATCH 2/2] ARM: dts: exynos4415: Add syscon property to the MIPI DPHY
In-Reply-To: <1432174713-23368-1-git-send-email-k.kozlowski@samsung.com>
References: <1432174713-23368-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1432174713-23368-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since e4b3d38088df ("phy: exynos-video-mipi: Fix regression by adding
support for PMU regmap") the Exynos PMU driver provides regmap to access
the MIPI DPHY registers. The MIPI DPHY driver accesses this regmap
through syscon phandle.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos4415.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4415.dtsi b/arch/arm/boot/dts/exynos4415.dtsi
index 186cb8465683..6a83d7999d8a 100644
--- a/arch/arm/boot/dts/exynos4415.dtsi
+++ b/arch/arm/boot/dts/exynos4415.dtsi
@@ -124,8 +124,8 @@
 
 		mipi_phy: video-phy at 10020710 {
 			compatible = "samsung,s5pv210-mipi-video-phy";
-			reg = <0x10020710 8>;
 			#phy-cells = <1>;
+			syscon = <&pmu_system_controller>;
 		};
 
 		pd_cam: cam-power-domain at 10024000 {
-- 
1.9.1
