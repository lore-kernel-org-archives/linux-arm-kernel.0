From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 08 Feb 2018 19:44:06 +0100
Subject: [PATCH v2 1/3] ARM: dts: exynos: Add I2S1 device node to
 exynos5433.dtsi
References: <CGME20180208184418epcas2p33540f1624c15227e9c4fccb60413eb59@epcas2p3.samsung.com>
Message-ID: <20180208184408.24185-1-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT node for the second I2S controller available
on Exynos 5433 SoC.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 62f276970174..3845a8de7a42 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -1311,6 +1311,25 @@
 			status = "disabled";
 		};
 
+		i2s1: i2s at 14d60000 {
+			compatible = "samsung,exynos7-i2s";
+			reg = <0x14d60000 0x100>;
+			dmas = <&pdma0 31 &pdma0 30>;
+			dma-names = "tx", "rx";
+			interrupts = <GIC_SPI 435 IRQ_TYPE_NONE>;
+			clocks = <&cmu_peric CLK_PCLK_I2S1>,
+				 <&cmu_peric CLK_PCLK_I2S1>,
+				 <&cmu_peric CLK_SCLK_I2S1>;
+			clock-names = "iis", "i2s_opclk0", "i2s_opclk1";
+			#clock-cells = <1>;
+			samsung,supports-6ch;
+			samsung,supports-rstclr;
+			samsung,supports-tdm;
+			samsung,supports-low-rfs;
+			#sound-dai-cells = <1>;
+			status = "disabled";
+		};
+
 		pwm: pwm at 14dd0000 {
 			compatible = "samsung,exynos4210-pwm";
 			reg = <0x14dd0000 0x100>;
-- 
2.14.2
