From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Wed,  9 Apr 2014 15:51:18 +0200
Subject: [PATCH 15/15] ARM: sunxi: dt: add support for A31's PL pins
In-Reply-To: <1397051478-4113-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1397051478-4113-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1397051478-4113-16-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A31 SoC control its PL pins using a different memory, and needs both a
new gate clk and a reset line to enable these PL port.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index ed9c2c1..90b3a25 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -210,13 +210,17 @@
 
 		pio: pinctrl at 01c20800 {
 			compatible = "allwinner,sun6i-a31-pinctrl";
-			reg = <0x01c20800 0x400>;
+			reg = <0x01c20800 0x400>,
+			      <0x01f02c00 0x400>;
 			interrupts = <0 11 4>,
 				     <0 15 4>,
 				     <0 16 4>,
 				     <0 17 4>;
-			clocks = <&apb1_gates 5>;
-			clock-names = "pio_clk";
+			clocks = <&apb1_gates 5>,
+				 <&apb0_gates 0>;
+			clock-names = "pio_clk", "pioL_clk";
+			resets = <&apb0_rst 0>;
+
 			gpio-controller;
 			interrupt-controller;
 			#address-cells = <1>;
-- 
1.8.3.2
