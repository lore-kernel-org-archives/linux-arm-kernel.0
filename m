From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 22 Feb 2017 18:31:44 +0100
Subject: [PATCH 1/3] ARM64: dts: marvell: armada37xx: add address and size
 property for i2c cells
In-Reply-To: <20170222173146.30993-1-gregory.clement@free-electrons.com>
References: <20170222173146.30993-1-gregory.clement@free-electrons.com>
Message-ID: <20170222173146.30993-2-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These property were missing when the nodes were added and their lack
generate warning messages when adding i2c device in the subnodes.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index b48d668a6ab6..cf0c2f9ebd7d 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -112,6 +112,8 @@
 			i2c0: i2c at 11000 {
 				compatible = "marvell,armada-3700-i2c";
 				reg = <0x11000 0x24>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				clocks = <&nb_periph_clk 10>;
 				interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
 				mrvl,i2c-fast-mode;
@@ -121,6 +123,8 @@
 			i2c1: i2c at 11080 {
 				compatible = "marvell,armada-3700-i2c";
 				reg = <0x11080 0x24>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				clocks = <&nb_periph_clk 9>;
 				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 				mrvl,i2c-fast-mode;
-- 
2.11.0
