From: b.michalska@samsung.com (Beata Michalska)
Date: Thu, 19 Mar 2015 11:56:27 +0100
Subject: [PATCH] ARM: dts: Update video-phy node with syscon phandle for
 Exynos3250
Message-ID: <1426762587-24923-1-git-send-email-b.michalska@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As a follow-up to recent changes to Exynos mipi video phy
driver, introducing support for PMU regmap in commit
e4b3d38088df6f3acd40 ("phy: exynos-video-mipi: Fix regression
by adding support for PMU regmap") add a syscon phandle to
video-phy node to bring back to life both MIPI DSI displays
and MIPI CSIS-2 camera sensors on Exynos3250.

Signed-off-by: Beata Michalska <b.michalska@samsung.com>
---
 arch/arm/boot/dts/exynos3250.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index ac6b0ae..6c89670 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -137,6 +137,7 @@
 			compatible = "samsung,s5pv210-mipi-video-phy";
 			reg = <0x10020710 8>;
 			#phy-cells = <1>;
+			syscon = <&pmu_system_controller>;
 		};
 
 		pd_cam: cam-power-domain at 10023C00 {
-- 
1.7.9.5
