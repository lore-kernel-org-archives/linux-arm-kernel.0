From: haibo.chen@freescale.com (Haibo Chen)
Date: Mon, 9 Nov 2015 21:28:23 +0800
Subject: [PATCH v2 3/4] ARM: dts: imx7d.dtsi: add ADC support
In-Reply-To: <1447075704-4605-1-git-send-email-haibo.chen@freescale.com>
References: <1447075704-4605-1-git-send-email-haibo.chen@freescale.com>
Message-ID: <1447075704-4605-4-git-send-email-haibo.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add imx7d ADC support.

Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
---
 arch/arm/boot/dts/imx7d.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index ebc053a..87c3319 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -583,6 +583,26 @@
 			reg = <0x30400000 0x400000>;
 			ranges;
 
+			adc1: adc at 30610000 {
+				compatible = "fsl,imx7d-adc";
+				reg = <0x30610000 0x10000>;
+				interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX7D_ADC_ROOT_CLK>;
+				num-channels = <4>;
+				clock-names = "adc";
+				status = "disabled";
+			};
+
+			adc2: adc at 30620000 {
+				compatible = "fsl,imx7d-adc";
+				reg = <0x30620000 0x10000>;
+				interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX7D_ADC_ROOT_CLK>;
+				num-channels = <4>;
+				clock-names = "adc";
+				status = "disabled";
+			};
+
 			pwm1: pwm at 30660000 {
 				compatible = "fsl,imx7d-pwm", "fsl,imx27-pwm";
 				reg = <0x30660000 0x10000>;
-- 
1.9.1
