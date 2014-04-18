From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 18 Apr 2014 21:15:11 +0200
Subject: [PATCH] ARM: sun7i: Fix i2c4 base address
Message-ID: <1397848511-30160-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For some reason, the base address of the fifth I2C adapter in the A20 was
incorrect. Change this to the actual base address.

Reported-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 899fd0e2b749..9dd904d53bd3 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -821,9 +821,9 @@
 			#size-cells = <0>;
 		};
 
-		i2c4: i2c at 01c2bc00 {
+		i2c4: i2c at 01c2c000 {
 			compatible = "allwinner,sun4i-i2c";
-			reg = <0x01c2bc00 0x400>;
+			reg = <0x01c2c000 0x400>;
 			interrupts = <0 89 4>;
 			clocks = <&apb1_gates 15>;
 			clock-frequency = <100000>;
-- 
1.9.1
