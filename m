From: k@japko.eu (Krzysztof Adamski)
Date: Mon, 8 Feb 2016 10:31:14 +0100
Subject: [PATCH] ARM: dts: sunxi: Fix #interrupt-cells for PIO in H3
Message-ID: <20160208093113.GA6268@box2.japko.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pinctrl-sunxi uses 3 cells to describe interrupt, not 2. It's bank
number, pin number and flags.

Signed-off-by: Krzysztof Adamski <k@japko.eu>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 6f6b4e4..96c899a 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -368,7 +368,7 @@
 			gpio-controller;
 			#gpio-cells = <3>;
 			interrupt-controller;
-			#interrupt-cells = <2>;
+			#interrupt-cells = <3>;
 
 			uart0_pins_a: uart0 at 0 {
 				allwinner,pins = "PA4", "PA5";
-- 
2.4.2
