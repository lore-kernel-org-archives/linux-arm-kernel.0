From: menschel.p@posteo.de (Patrick Menschel)
Date: Mon,  3 Apr 2017 19:00:13 +0200
Subject: [PATCH v3 3/4] ARM: dts: sun7i: Add CAN node
In-Reply-To: <1491238814-4888-1-git-send-email-menschel.p@posteo.de>
References: <1491238814-4888-1-git-send-email-menschel.p@posteo.de>
Message-ID: <1491238814-4888-4-git-send-email-menschel.p@posteo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A20 SoC has an on-board CAN controller.
This patch adds the device node.

The CAN controller is inherited from the A10 SoC and uses the same driver.

This patch is adapted from the description in
Documentation/devicetree/bindings/net/can/sun4i_can.txt

Signed-off-by: Patrick Menschel <menschel.p@posteo.de>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 2db97fc..c637e10 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -1582,6 +1582,15 @@
 			#size-cells = <0>;
 		};
 
+		can0: can at 01c2bc00 {
+			compatible = "allwinner,sun7i-a20-can",
+				     "allwinner,sun4i-a10-can";
+			reg = <0x01c2bc00 0x400>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&apb1_gates 4>;
+			status = "disabled";
+		};
+
 		i2c4: i2c at 01c2c000 {
 			compatible = "allwinner,sun7i-a20-i2c",
 				     "allwinner,sun4i-a10-i2c";
-- 
1.9.1
