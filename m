From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 29 Mar 2016 23:50:42 +0200
Subject: [PATCH 3/7] ARM: dts: lpc18xx: add adc nodes
In-Reply-To: <1459288246-1670-1-git-send-email-manabian@gmail.com>
References: <1459288246-1670-1-git-send-email-manabian@gmail.com>
Message-ID: <1459288246-1670-4-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nodes for the two 10-bit ADCs found on all lpc18xx SoCs.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc18xx.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
index e270294..88d27ae 100644
--- a/arch/arm/boot/dts/lpc18xx.dtsi
+++ b/arch/arm/boot/dts/lpc18xx.dtsi
@@ -453,6 +453,24 @@
 			status = "disabled";
 		};
 
+		adc0: adc at 400e3000 {
+			compatible = "nxp,lpc1850-adc";
+			reg = <0x400e3000 0x1000>;
+			interrupts = <17>;
+			clocks = <&ccu1 CLK_APB3_ADC0>;
+			resets = <&rgu 40>;
+			status = "disabled";
+		};
+
+		adc1: adc at 400e4000 {
+			compatible = "nxp,lpc1850-adc";
+			reg = <0x400e4000 0x1000>;
+			interrupts = <21>;
+			clocks = <&ccu1 CLK_APB3_ADC1>;
+			resets = <&rgu 41>;
+			status = "disabled";
+		};
+
 		gpio: gpio at 400f4000 {
 			compatible = "nxp,lpc1850-gpio";
 			reg = <0x400f4000 0x4000>;
-- 
2.7.4
