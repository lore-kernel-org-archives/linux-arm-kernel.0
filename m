From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 12 Feb 2018 17:31:46 +0100
Subject: [PATCH v3 2/3] ARM: dts: exynos: Update I2S0 device node in
 exynos5433.dtsi
In-Reply-To: <20180212163147.11561-1-s.nawrocki@samsung.com>
References: <20180212163147.11561-1-s.nawrocki@samsung.com>
 <CGME20180212163207epcas1p19d0fd84633edda6f61a7b760b85e1c91@epcas1p1.samsung.com>
Message-ID: <20180212163147.11561-2-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i2s0 node name is changed to a more generic "i2s" and missing
(optional) properties are added. The #sound-dai-cells property is
required for HDMI audio support on TM2 board.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes since v2:
 - none.
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 3845a8de7a42..2b73bd86bc56 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -1658,7 +1658,7 @@
 				power-domains = <&pd_aud>;
 			};
 
-			i2s0: i2s0 at 11440000 {
+			i2s0: i2s at 11440000 {
 				compatible = "samsung,exynos7-i2s";
 				reg = <0x11440000 0x100>;
 				dmas = <&adma 0 &adma 2>;
@@ -1670,9 +1670,11 @@
 					<&cmu_aud CLK_SCLK_AUD_I2S>,
 					<&cmu_aud CLK_SCLK_I2S_BCLK>;
 				clock-names = "iis", "i2s_opclk0", "i2s_opclk1";
+				#clock-cells = <1>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&i2s0_bus>;
 				power-domains = <&pd_aud>;
+				#sound-dai-cells = <1>;
 				status = "disabled";
 			};
 
-- 
2.14.2
