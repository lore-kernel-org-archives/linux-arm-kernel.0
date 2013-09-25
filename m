From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 25 Sep 2013 17:58:00 +0300
Subject: [PATCH] ARM: sun6i: Fix the APB2 clock gates register size
Message-ID: <1380121080-9321-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The APB2 clocks gates are only a 32 bits register wide, and not 2 as set
currently in the DTSI.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index f244f5f..c1751a6 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -175,7 +175,7 @@
 		apb2_gates: apb2_gates at 01c2006c {
 			#clock-cells = <1>;
 			compatible = "allwinner,sun6i-a31-apb2-gates-clk";
-			reg = <0x01c2006c 0x8>;
+			reg = <0x01c2006c 0x4>;
 			clocks = <&apb2>;
 			clock-output-names = "apb2_i2c0", "apb2_i2c1",
 					"apb2_i2c2", "apb2_i2c3", "apb2_uart0",
-- 
1.8.4
