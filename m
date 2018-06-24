From: daniel@zonque.org (Daniel Mack)
Date: Sun, 24 Jun 2018 19:42:05 +0200
Subject: [PATCH] arm: dts: pxa3xx: provide correct clk-names property for nand
 controller node
Message-ID: <20180624174205.20648-1-daniel@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NAND driver looks for a clock named "core" and falls back to a pdev
clock that has a wrong rate if not set.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 arch/arm/boot/dts/pxa3xx.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/pxa3xx.dtsi b/arch/arm/boot/dts/pxa3xx.dtsi
index 3851057bc77d..7f65791c0559 100644
--- a/arch/arm/boot/dts/pxa3xx.dtsi
+++ b/arch/arm/boot/dts/pxa3xx.dtsi
@@ -134,6 +134,7 @@
 			compatible = "marvell,pxa3xx-nand-controller";
 			reg = <0x43100000 90>;
 			interrupts = <45>;
+			clock-names = "core";
 			clocks = <&clks CLK_NAND>;
 			dmas = <&pdma 97 3>;
 			dma-names = "data";
-- 
2.17.1
