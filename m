From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 15 Aug 2016 10:55:30 +0200
Subject: [PATCH 11/26] ARM: dts: r8a7794: Correct SDHI register size
In-Reply-To: <cover.1471251169.git.horms+renesas@verge.net.au>
References: <cover.1471251169.git.horms+renesas@verge.net.au>
Message-ID: <83701e00ded47e7f6390c6a123209426565046b7.1471251169.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

r8a7794 SDHI ch0 has SD_DMACR which is located in 0x324.
This patch updates register size

Based on work for the r8a7790 by Kuninori Morimoto.

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
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
