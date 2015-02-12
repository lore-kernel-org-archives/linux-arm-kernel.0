From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 12 Feb 2015 15:55:58 +0900
Subject: [PATCH v3 8/8] arm64: dts: exynos: Add I2S dt node for Exynos5433 SoC
In-Reply-To: <1423724158-23632-1-git-send-email-cw00.choi@samsung.com>
References: <1423724158-23632-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1423724158-23632-9-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Inha Song <ideal.song@samsung.com>

This patch adds I2S device tree node for Exynos5433 SoC.
In Exynos5433 SoC, I2S0 is used for audio interface.

Cc: Kukjin Kim <kgene@kernel.org>
Signed-off-by: Inha Song <ideal.song@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Inki Dae <inki.dae@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 7bf4dcf..807ad8e 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -511,6 +511,23 @@
 			status = "disabled";
 		};
 
+		i2s0: i2s0 at 11440000 {
+			compatible = "samsung,exynos7-i2s";
+			reg = <0x11440000 0x100>;
+			dmas = <&adma 0 &adma 2>;
+			dma-names = "tx", "rx";
+			interrupts = <0 70 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&cmu_aud CLK_PCLK_AUD_I2S>,
+				 <&cmu_aud CLK_SCLK_AUD_I2S>,
+				 <&cmu_aud CLK_SCLK_I2S_BCLK>;
+			clock-names = "iis", "i2s_opclk0", "i2s_opclk1";
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2s0_bus>;
+			status = "disabled";
+		};
+
 		pinctrl_alive: pinctrl at 10580000 {
 			compatible = "samsung,exynos5433-pinctrl";
 			reg = <0x10580000 0x1000>;
-- 
1.8.5.5
