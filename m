From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 06 Apr 2016 11:00:42 +0900
Subject: [PATCH v2 03/11] ARM: dts: exynos: Fix DTC unit name warnings in
 Exynos4
In-Reply-To: <1459908050-16430-1-git-send-email-k.kozlowski@samsung.com>
References: <1459908050-16430-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1459908050-16430-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix following DTC warnings in all Exynos4 boards:

Warning (unit_address_vs_reg): Node /soc/video-phy at 10020710 has a unit name, but no reg property

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

Changes since v1:
1. Add Javier's tag.
---
 arch/arm/boot/dts/exynos4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 000d506c027b..021f52d43ff7 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -82,7 +82,7 @@
 		reg = <0x12570000 0x14>;
 	};
 
-	mipi_phy: video-phy at 10020710 {
+	mipi_phy: video-phy {
 		compatible = "samsung,s5pv210-mipi-video-phy";
 		#phy-cells = <1>;
 		syscon = <&pmu_system_controller>;
-- 
2.5.0
