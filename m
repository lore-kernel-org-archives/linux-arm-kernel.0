From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Thu,  6 Jul 2017 10:53:34 +0200
Subject: [PATCH] ARM: sunxi: h3/h5: Correct emac register size
Message-ID: <20170706085334.25380-1-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The datasheet said that emac register size is 0x1000 not 0x104

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 716e7d668dec..5a57b67c9b77 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -406,7 +406,7 @@
 		emac: ethernet at 1c30000 {
 			compatible = "allwinner,sun8i-h3-emac";
 			syscon = <&syscon>;
-			reg = <0x01c30000 0x104>;
+			reg = <0x01c30000 0x1000>;
 			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
 			resets = <&ccu RST_BUS_EMAC>;
-- 
2.13.0
