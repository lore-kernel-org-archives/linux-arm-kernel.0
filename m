From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 21 Jul 2014 11:17:48 +0900
Subject: [PATCHv7 4/4] ARM: dts: Fix wrong compatible string for Exynos3250 ADC
In-Reply-To: <1405909068-22539-1-git-send-email-cw00.choi@samsung.com>
References: <1405909068-22539-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1405909068-22539-5-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset fix wrong compatible string for Exynos3250 ADC. Exynos3250 SoC
need to control only special clock for ADC. Exynos SoC except for Exynos3250
has not included special clock for ADC. The exynos ADC driver can control
special clock if compatible string is 'exynos3250-adc-v2'.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
Acked-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/boot/dts/exynos3250.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 15c9c87..8ab1289 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -407,10 +407,10 @@
 		};
 
 		adc: adc at 126C0000 {
-			compatible = "samsung,exynos-adc-v3";
+			compatible = "samsung,exynos3250-adc";
 			reg = <0x126C0000 0x100>, <0x10020718 0x4>;
 			interrupts = <0 137 0>;
-			clock-names = "adc", "sclk_tsadc";
+			clock-names = "adc", "sclk";
 			clocks = <&cmu CLK_TSADC>, <&cmu CLK_SCLK_TSADC>;
 			#io-channel-cells = <1>;
 			io-channel-ranges;
-- 
1.8.0
