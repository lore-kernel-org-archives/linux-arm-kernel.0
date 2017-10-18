From: miquel.raynal@free-electrons.com (Miquel Raynal)
Date: Wed, 18 Oct 2017 16:36:28 +0200
Subject: [RFC 11/12] ARM: dts: pxa: use reworked NAND controller driver
In-Reply-To: <20171018143629.29302-1-miquel.raynal@free-electrons.com>
References: <20171018143629.29302-1-miquel.raynal@free-electrons.com>
Message-ID: <20171018143629.29302-12-miquel.raynal@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the bindings to use the reworked Marvell NAND controller driver.
Also adapt the nand controller node organization to distinguish which
property is relevant for the controller, and which one is NAND chip
specific. Expose the partitions as a subnode of the NAND chip.

Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
---
 arch/arm/boot/dts/pxa3xx.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/pxa3xx.dtsi b/arch/arm/boot/dts/pxa3xx.dtsi
index 7a0cc4ea819a..e7cde732bf88 100644
--- a/arch/arm/boot/dts/pxa3xx.dtsi
+++ b/arch/arm/boot/dts/pxa3xx.dtsi
@@ -116,15 +116,15 @@
 			status = "disabled";
 		};
 
-		nand0: nand at 43100000 {
-			compatible = "marvell,pxa3xx-nand";
+		nand_controller: nand-controller at 43100000 {
+			compatible = "marvell,pxa3xx-nand-controller";
 			reg = <0x43100000 90>;
 			interrupts = <45>;
 			clocks = <&clks CLK_NAND>;
 			dmas = <&pdma 97 3>;
 			dma-names = "data";
 			#address-cells = <1>;
-			#size-cells = <1>;	
+			#size-cells = <0>;
 			status = "disabled";
 		};
 
-- 
2.11.0
