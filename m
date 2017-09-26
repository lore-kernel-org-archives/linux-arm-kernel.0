From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Tue, 26 Sep 2017 09:22:22 +0200
Subject: [PATCH v3 02/14] ARM: dts: sunxi: h3/h5: Fix i2c2 register address
In-Reply-To: <20170926072234.27481-1-clabbe.montjoie@gmail.com>
References: <20170926072234.27481-1-clabbe.montjoie@gmail.com>
Message-ID: <20170926072234.27481-3-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The unit address and register address does not match.
This patch fix the register address with the good one.

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index b37ed3461229..289f2cd06dfe 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -632,7 +632,7 @@
 
 		i2c2: i2c at 1c2b400 {
 			compatible = "allwinner,sun6i-a31-i2c";
-			reg = <0x01c2b000 0x400>;
+			reg = <0x01c2b400 0x400>;
 			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_I2C2>;
 			resets = <&ccu RST_BUS_I2C2>;
-- 
2.13.5
