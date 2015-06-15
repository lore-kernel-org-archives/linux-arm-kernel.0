From: b.michalska@samsung.com (Beata Michalska)
Date: Mon, 15 Jun 2015 10:12:46 +0200
Subject: [PATCH v2] ARM: dts: Update video-phy node with syscon phandle for
 Exynos3250
Message-ID: <1434355966-4566-1-git-send-email-b.michalska@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As a follow-up to recent changes to Exynos mipi video phy
driver, introducing support for PMU regmap in commit
e4b3d38088df6f3acd40 ("phy: exynos-video-mipi: Fix regression
by adding support for PMU regmap") add a syscon phandle to
video-phy node to bring back to life both MIPI DSI display
and MIPI CSIS-2 camera sensor on Exynos3250.

Signed-off-by: Beata Michalska <b.michalska@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
v2:
	- removed 'reg' property as this is no longer needed
	- added signatures as stated in the original thread

---
 arch/arm/boot/dts/exynos3250.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index e3bfb11..f514ead 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -138,8 +138,8 @@
 
 		mipi_phy: video-phy at 10020710 {
 			compatible = "samsung,s5pv210-mipi-video-phy";
-			reg = <0x10020710 8>;
 			#phy-cells = <1>;
+			syscon = <&pmu_system_controller>;
 		};
 
 		pd_cam: cam-power-domain at 10023C00 {
-- 
1.7.9.5
