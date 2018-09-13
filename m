From: robh@kernel.org (Rob Herring)
Date: Thu, 13 Sep 2018 13:12:38 -0500
Subject: [PATCH] ARM: dts: sun9i: Fix I2C bus warnings
Message-ID: <20180913181245.25484-14-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dtc has new checks for I2C buses. The sun9i-a80 dts file has a node named
'i2c' which causes a false positive warning. As the node is a RSB bus,
correct the node name to be 'rsb' to fix the warnings.

arch/arm/boot/dts/sun9i-a80-cubieboard4.dtb: Warning (i2c_bus_reg): /soc/i2c at 8003400/codec at e89:reg: I2C address must be less than 10-bits, got "0xe89"
arch/arm/boot/dts/sun9i-a80-cubieboard4.dtb: Warning (i2c_bus_reg): /soc/i2c at 8003400/pmic at 745:reg: I2C address must be less than 10-bits, got "0x745"
arch/arm/boot/dts/sun9i-a80-optimus.dtb: Warning (i2c_bus_reg): /soc/i2c at 8003400/codec at e89:reg: I2C address must be less than 10-bits, got "0xe89"
arch/arm/boot/dts/sun9i-a80-optimus.dtb: Warning (i2c_bus_reg): /soc/i2c at 8003400/pmic at 745:reg: I2C address must be less than 10-bits, got "0x745"

Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please apply to the sub-arch tree. The dtc changes haven't landed, but 
will for 4.20.

 arch/arm/boot/dts/sun9i-a80.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index 25591d6883ef..d9532fb1ef65 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -1196,7 +1196,7 @@
 			};
 		};
 
-		r_rsb: i2c at 8003400 {
+		r_rsb: rsb at 8003400 {
 			compatible = "allwinner,sun8i-a23-rsb";
 			reg = <0x08003400 0x400>;
 			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.17.1
