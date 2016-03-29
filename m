From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 29 Mar 2016 23:50:46 +0200
Subject: [PATCH 7/7] ARM: dts: lpc4350-hitex-eval: add adc1
In-Reply-To: <1459288246-1670-1-git-send-email-manabian@gmail.com>
References: <1459288246-1670-1-git-send-email-manabian@gmail.com>
Message-ID: <1459288246-1670-8-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable adc1 on LPC4350 Hitex Evalution board. This board has a
10k potensiometer (R26) connected to ADC1 channel 2.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc4350-hitex-eval.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/lpc4350-hitex-eval.dts b/arch/arm/boot/dts/lpc4350-hitex-eval.dts
index 022d495..6d0c698 100644
--- a/arch/arm/boot/dts/lpc4350-hitex-eval.dts
+++ b/arch/arm/boot/dts/lpc4350-hitex-eval.dts
@@ -119,9 +119,25 @@
 			gpios = <&pca_gpio 3 GPIO_ACTIVE_LOW>;
 		};
 	};
+
+	vcc: vcc_fixed {
+		compatible = "regulator-fixed";
+		regulator-name = "3v3io";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
 };
 
 &pinctrl {
+	adc1_pins: adc1-pins {
+		adc1_pins_cfg {
+			pins = "pf_9";
+			function = "adc";
+			input-disable;
+			bias-disable;
+		};
+	};
+
 	emc_pins: emc-pins {
 		emc_addr0_23_cfg {
 			pins =	"p2_9",  "p2_10", "p2_11", "p2_12",
@@ -325,6 +341,13 @@
 	};
 };
 
+&adc1 {
+	status = "okay";
+	vref-supply = <&vcc>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&adc1_pins>;
+};
+
 &emc {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.7.4
