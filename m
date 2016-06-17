From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 17 Jun 2016 22:28:09 +0200
Subject: [PATCH 4/7] ARM: dts: add I2C block in GSBI12
In-Reply-To: <1466195292-28236-1-git-send-email-linus.walleij@linaro.org>
References: <1466195292-28236-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1466195292-28236-6-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The I2C block on the GSBI12 is used on the APQ8060 Dragonboard for
sensors. Make it available in the chipset file.

Take this opportunity to fix the IRQ flag "0" to "NONE" using the
IRQ DT include.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8660.dtsi | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index e7c6e2942f47..8ee3045f4066 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -122,11 +122,22 @@
 				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
 				reg = <0x19c40000 0x1000>,
 				      <0x19c00000 0x1000>;
-				interrupts = <0 195 0x0>;
+				interrupts = <0 195 IRQ_TYPE_NONE>;
 				clocks = <&gcc GSBI12_UART_CLK>, <&gcc GSBI12_H_CLK>;
 				clock-names = "core", "iface";
 				status = "disabled";
 			};
+
+			gsbi12_i2c: i2c at 19c80000 {
+				compatible = "qcom,i2c-qup-v1.1.1";
+				reg = <0x19c80000 0x1000>;
+				interrupts = <0 196 IRQ_TYPE_NONE>;
+				clocks = <&gcc GSBI12_QUP_CLK>, <&gcc GSBI12_H_CLK>;
+				clock-names = "core", "iface";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		qcom,ssbi at 500000 {
-- 
2.4.11
