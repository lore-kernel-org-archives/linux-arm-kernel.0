From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Mon, 10 Jul 2017 20:44:40 +0200
Subject: [PATCH] ARM64: allwinner: sun50i-a64: Correct emac register size
Message-ID: <20170710184440.28946-1-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The datasheet said that emac register size is 0x10000 not 0x100

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index e9a41b1896df..be70f5cac447 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -464,7 +464,7 @@
 		emac: ethernet at 1c30000 {
 			compatible = "allwinner,sun50i-a64-emac";
 			syscon = <&syscon>;
-			reg = <0x01c30000 0x100>;
+			reg = <0x01c30000 0x10000>;
 			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
 			resets = <&ccu RST_BUS_EMAC>;
-- 
2.13.0
