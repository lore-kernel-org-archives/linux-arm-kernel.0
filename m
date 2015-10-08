From: haibo.chen@freescale.com (Haibo Chen)
Date: Thu, 8 Oct 2015 18:59:07 +0800
Subject: [PATCH 4/5] ARM: dts: imx7d.dtsi: add ADC support
In-Reply-To: <1444301948-21721-1-git-send-email-haibo.chen@freescale.com>
References: <1444301948-21721-1-git-send-email-haibo.chen@freescale.com>
Message-ID: <1444301948-21721-4-git-send-email-haibo.chen@freescale.com>
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
