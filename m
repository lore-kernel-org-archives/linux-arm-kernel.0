From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 10 Mar 2015 10:57:31 +0900
Subject: [PATCH v6 5/9] arm64: dts: exynos: Add RTC and ADC dt node for
 Exynos5433 SoC
In-Reply-To: <1425952655-21654-1-git-send-email-cw00.choi@samsung.com>
References: <1425952655-21654-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1425952655-21654-6-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds RTC (Real Time Clock) dt node for Exynos5433 SoC and adds
ADC dt node for Exynos5433 SoC. The c1b501564c98a94b4(iio: adc: exynos_adc:
Add support for exynos7) commit supports the ADC for Exynos7. Exynos5433's ADC
IP is the same with Exynos7's ADC IP. Exynos5433 has a little different from
ADCv2 on ADC_CON2 register. Exynos5433 don't contain OSEL/ESEL /HIGHF of ADC_CON2.

Cc: Kukjin Kim <kgene@kernel.org>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Inki Dae <inki.dae@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index fa27bb8..99aa51e 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -815,6 +815,24 @@
 			clock-names = "clkout16";
 			clocks = <&xxti>;
 		};
+
+		rtc: rtc at 10590000 {
+			compatible = "samsung,exynos3250-rtc";
+			reg = <0x10590000 0x100>;
+			interrupts = <0 385 0>, <0 386 0>;
+			status = "disabled";
+		};
+
+		adc: adc at 14d10000 {
+			compatible = "samsung,exynos7-adc";
+			reg = <0x14d10000 0x100>;
+			interrupts = <0 438 0>;
+			clock-names = "adc";
+			clocks = <&cmu_peric CLK_PCLK_ADCIF>;
+			#io-channel-cells = <1>;
+			io-channel-ranges;
+			status = "disabled";
+		};
 	};
 
 	timer {
-- 
1.8.5.5
