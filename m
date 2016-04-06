From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 06 Apr 2016 11:00:41 +0900
Subject: [PATCH v2 02/11] ARM: dts: exynos: Fix DTC unit name warnings in
 Exynos3250
In-Reply-To: <1459908050-16430-1-git-send-email-k.kozlowski@samsung.com>
References: <1459908050-16430-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1459908050-16430-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix following DTC warnings in Exynos3250 boards:

Warning (unit_address_vs_reg): Node /soc/video-phy at 10020710 has a unit name, but no reg property

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

Changes since v1:
1. Add Javier's tag.
---
 arch/arm/boot/dts/exynos3250.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 137f9015d4e8..5225e953d2ed 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -153,7 +153,7 @@
 			interrupt-parent = <&gic>;
 		};
 
-		mipi_phy: video-phy at 10020710 {
+		mipi_phy: video-phy {
 			compatible = "samsung,s5pv210-mipi-video-phy";
 			#phy-cells = <1>;
 			syscon = <&pmu_system_controller>;
-- 
2.5.0
