From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 21 Dec 2017 12:02:36 +0100
Subject: [PATCH v5 10/12] ARM: dts: sun8i: a83t: Enable the PWM
In-Reply-To: <cover.e5a47cc96ec5274dd932daa2bde47df073087da9.1513854122.git-series.maxime.ripard@free-electrons.com>
References: <cover.e5a47cc96ec5274dd932daa2bde47df073087da9.1513854122.git-series.maxime.ripard@free-electrons.com>
Message-ID: <0660061a425cbe3ea6426f5271457d6dde9313f1.1513854122.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A83T has the same PWM block than the H3. Add it to our DT.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index e4db38c717d9..ae34d22d6d47 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -440,6 +440,11 @@
 				bias-pull-up;
 			};
 
+			pwm_pin: pwm-pin {
+				pins = "PD28";
+				function = "pwm";
+			};
+
 			spdif_tx_pin: spdif-tx-pin {
 				pins = "PE18";
 				function = "spdif";
@@ -497,6 +502,15 @@
 			status = "disabled";
 		};
 
+		pwm: pwm at 1c21400 {
+			compatible = "allwinner,sun8i-a83t-pwm",
+				     "allwinner,sun8i-h3-pwm";
+			reg = <0x01c21400 0x400>;
+			clocks = <&osc24M>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		uart0: serial at 1c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
-- 
git-series 0.9.1
