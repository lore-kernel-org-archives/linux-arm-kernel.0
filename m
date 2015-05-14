From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu, 14 May 2015 14:40:40 +0200
Subject: [PATCH v2] ARM: dts: Add syscon property to the MIPI phy in exynos5420
Message-ID: <1431607240-14549-1-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since e4b3d38088df6f3acd40 ("phy: exynos-video-mipi: Fix regression by
adding support for PMU regmap") the syscon property is required in
samsung,s5pv210-mipi-video-phy nodes, but this DTS hadn't been updated
yet.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Krzysztof Koz?owski <k.kozlowski@samsung.com>

--

v2:	* Remove reg property as suggested by Javier
	* Added his Reviewed-by
---
 arch/arm/boot/dts/exynos5420.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 4531753..78bcbc0 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -541,7 +541,7 @@
 
 	mipi_phy: video-phy at 10040714 {
 		compatible = "samsung,s5pv210-mipi-video-phy";
-		reg = <0x10040714 12>;
+		syscon = <&pmu_system_controller>;
 		#phy-cells = <1>;
 	};
 
-- 
2.4.0
