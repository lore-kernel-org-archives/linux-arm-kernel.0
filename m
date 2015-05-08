From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Fri,  8 May 2015 15:30:05 +0200
Subject: [PATCH] ARM: dts: Add syscon property to the MIPI phy in exynos5420
Message-ID: <1431091805-11451-1-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since e4b3d38088df6f3acd40 ("phy: exynos-video-mipi: Fix regression by
adding support for PMU regmap") the syscon property is required in
samsung,s5pv210-mipi-video-phy nodes, but this DTS hadn't been updated
yet.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index f67b23f..72a56f1 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -541,6 +541,7 @@
 	mipi_phy: video-phy at 10040714 {
 		compatible = "samsung,s5pv210-mipi-video-phy";
 		reg = <0x10040714 12>;
+		syscon = <&pmu_system_controller>;
 		#phy-cells = <1>;
 	};
 
-- 
2.4.0
