From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 21 Jul 2016 08:44:08 +0900
Subject: [PATCH v2] ARM: dts: r8a7794: Correct SDHI register size
Message-ID: <1469058248-27880-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

r8a7794 SDHI ch0 has SD_DMACR which is located in 0x324.
This patch updates register size

Based on work for the r8a7790 by Kuninori Morimoto.

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
Found by inspection
Compile tested only

v2
* Correct register size: some how I messed it up the first time around
---
 arch/arm/boot/dts/r8a7794.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 685f986cf962..55737bca4e63 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -697,7 +697,7 @@
 
 	sdhi0: sd at ee100000 {
 		compatible = "renesas,sdhi-r8a7794";
-		reg = <0 0xee100000 0 0x200>;
+		reg = <0 0xee100000 0 0x328>;
 		interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7794_CLK_SDHI0>;
 		dmas = <&dmac0 0xcd>, <&dmac0 0xce>,
-- 
2.7.0.rc3.207.g0ac5344
