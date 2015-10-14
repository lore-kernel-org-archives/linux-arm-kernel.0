From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 14 Oct 2015 15:02:06 +0900
Subject: [PATCH] dt-bindings: Correct the example for Exynos power domain
 clocks
Message-ID: <1444802526-18518-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 29e5eea06bc1 ("ARM: EXYNOS: Get current parent clock for
power domain on/off") the "pclkN" names of "clock-names" property is not
parsed any more. The bindings and driver were updated but the example
was not. Fix the example now.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 Documentation/devicetree/bindings/arm/exynos/power_domain.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
index e151057d92f0..4e947372a693 100644
--- a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
+++ b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
@@ -43,9 +43,8 @@ Example:
 	mfc_pd: power-domain at 10044060 {
 		compatible = "samsung,exynos4210-pd";
 		reg = <0x10044060 0x20>;
-		clocks = <&clock CLK_FIN_PLL>, <&clock CLK_MOUT_SW_ACLK333>,
-			<&clock CLK_MOUT_USER_ACLK333>;
-		clock-names = "oscclk", "pclk0", "clk0";
+		clocks = <&clock CLK_FIN_PLL>, <&clock CLK_MOUT_USER_ACLK333>;
+		clock-names = "oscclk", "clk0";
 		#power-domain-cells = <0>;
 	};
 
-- 
1.9.1
