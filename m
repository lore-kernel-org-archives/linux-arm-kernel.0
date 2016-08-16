From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 16 Aug 2016 10:34:53 +0100
Subject: [PATCH v4 02/17] ARM: dts: STiH407: Declare PWM Capture data lines
 via Pinctrl
In-Reply-To: <20160816093508.28307-1-lee.jones@linaro.org>
References: <20160816093508.28307-1-lee.jones@linaro.org>
Message-ID: <20160816093508.28307-3-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-pinctrl.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
index a538ae5..bc22122 100644
--- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
@@ -289,10 +289,12 @@
 				pinctrl_pwm1_chan0_default: pwm1-0-default {
 					st,pins {
 						pwm-out = <&pio3 0 ALT1 OUT>;
+						pwm-capturein = <&pio3 2 ALT1 IN>;
 					};
 				};
 				pinctrl_pwm1_chan1_default: pwm1-1-default {
 					st,pins {
+						pwm-capturein = <&pio4 3 ALT1 IN>;
 						pwm-out = <&pio4 4 ALT1 OUT>;
 					};
 				};
@@ -1030,6 +1032,7 @@
 			pwm0 {
 				pinctrl_pwm0_chan0_default: pwm0-0-default {
 					st,pins {
+						pwm-capturein = <&pio31 0 ALT1 IN>;
 						pwm-out = <&pio31 1 ALT1 OUT>;
 					};
 				};
-- 
2.9.0
