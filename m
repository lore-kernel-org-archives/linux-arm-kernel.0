From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun,  8 May 2016 21:05:50 +0200
Subject: [PATCH v2 05/22] ARM: dts: exynos: Switch MCT node to a new fin_pll
 clock
In-Reply-To: <1462734367-5619-1-git-send-email-krzk@kernel.org>
References: <1462734367-5619-1-git-send-email-krzk@kernel.org>
Message-ID: <1462734367-5619-6-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clk-exynos5410 driver now provides the "fin_pll" external fixed
clock. Switch the Multi-Core Timer to this clock.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5410.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index 7a56aec2c5ba..233149abfb62 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -125,7 +125,7 @@
 			interrupts = <0>, <1>, <2>, <3>,
 				<4>, <5>, <6>, <7>,
 				<8>, <9>, <10>, <11>;
-			clocks = <&fin_pll>, <&clock CLK_MCT>;
+			clocks = <&clock CLK_FIN_PLL>, <&clock CLK_MCT>;
 			clock-names = "fin_pll", "mct";
 
 			interrupt_map: interrupt-map {
-- 
2.5.0
