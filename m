From: woogyom.kim@gmail.com (Milo Kim)
Date: Wed, 31 Aug 2016 17:25:17 +0900
Subject: [PATCH v2 1/4] ARM: dts: sun8i: Add PWM pin in H3
In-Reply-To: <20160831082520.25962-1-woogyom.kim@gmail.com>
References: <20160831082520.25962-1-woogyom.kim@gmail.com>
Message-ID: <20160831082520.25962-2-woogyom.kim@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H3 PA5 pin is assigned for single PWM channel.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index fdf9fdb..05d0c4b 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -360,6 +360,13 @@
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
+			pwm0_pin_a: pwm0 at 0 {
+				allwinner,pins = "PA5";
+				allwinner,function = "pwm0";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
 			uart0_pins_a: uart0 at 0 {
 				allwinner,pins = "PA4", "PA5";
 				allwinner,function = "uart0";
-- 
2.9.3
