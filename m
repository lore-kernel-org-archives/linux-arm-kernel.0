From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 12 Mar 2014 15:19:12 +0900
Subject: [PATCHv2 1/5] ARM: dts: exynos4x12: Add ADC's dt data to read raw data
In-Reply-To: <1394605156-7768-1-git-send-email-cw00.choi@samsung.com>
References: <1394605156-7768-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1394605156-7768-2-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add ADC(Analog to Digital Converter)'s dt data to get raw data
with IIO subsystem. Usually, ADC is used to check temperature, jack type
and so on.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4x12.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index e0eb6bb..eec1e30 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -80,6 +80,18 @@
 		};
 	};
 
+	adc: adc at 126C0000 {
+		compatible = "samsung,exynos-adc-v1";
+		reg = <0x126C0000 0x100>, <0x10020718 0x4>;
+		interrupt-parent = <&combiner>;
+		interrupts = <10 3>;
+		clocks = <&clock CLK_TSADC>;
+		clock-names = "adc";
+		#io-channel-cells = <1>;
+		io-channel-ranges;
+		status = "disabled";
+	};
+
 	pinctrl_2: pinctrl at 03860000 {
 		compatible = "samsung,exynos4x12-pinctrl";
 		reg = <0x03860000 0x1000>;
-- 
1.8.0
