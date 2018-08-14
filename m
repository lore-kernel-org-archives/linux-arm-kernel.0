From: tuomas@tuxera.com (Tuomas Tynkkynen)
Date: Tue, 14 Aug 2018 23:47:58 +0300
Subject: [PATCH] ARM: dts: imx6: Add stdout-path to Wandboard
Message-ID: <20180814204758.3049-1-tuomas@tuxera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Setting a stdout-path in the .dtb is convenient because then the user
gets a serial console on the RS-232 connector without any extra effort
of figuring out the relevant 'console=' boot parameter.

Signed-off-by: Tuomas Tynkkynen <tuomas@tuxera.com>
---
Tested on a Wandboard Quad with mainline U-Boot 2018.05.
---
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
index e1afa54404d0..0ef34c31f7c6 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
@@ -8,6 +8,10 @@
 #include <dt-bindings/gpio/gpio.h>
 
 / {
+	chosen {
+		stdout-path = &uart1;
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.16.3
