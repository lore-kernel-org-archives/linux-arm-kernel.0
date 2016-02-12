From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 13 Feb 2016 00:49:20 +0100
Subject: [PATCH] ARM: dts: pxa: fix dma engine node to pxa3xx-nand
Message-ID: <1455320960-10121-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the switch from mmp_pdma to pxa_dma driver for pxa architectures,
the pxa_dma requires 2 arguments, namely the requestor line and the
requested priority.

Fix the only left device node which was still passing only one argument,
making the pxa3xx-nand driver misbehave in a device-tree configuration,
ie. failing all data transfers.

Fixes: c943646d1f49 ("ARM: dts: pxa: add dma engine node to pxa3xx-nand")
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/boot/dts/pxa3xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/pxa3xx.dtsi b/arch/arm/boot/dts/pxa3xx.dtsi
index bea454f50ff9..fec47bcd8292 100644
--- a/arch/arm/boot/dts/pxa3xx.dtsi
+++ b/arch/arm/boot/dts/pxa3xx.dtsi
@@ -31,7 +31,7 @@
 			reg = <0x43100000 90>;
 			interrupts = <45>;
 			clocks = <&clks CLK_NAND>;
-			dmas = <&pdma 97>;
+			dmas = <&pdma 97 3>;
 			dma-names = "data";
 			#address-cells = <1>;
 			#size-cells = <1>;	
-- 
2.1.4
