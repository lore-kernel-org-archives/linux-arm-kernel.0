From: menschel.p@posteo.de (Patrick Menschel)
Date: Mon,  3 Apr 2017 19:00:11 +0200
Subject: [PATCH v3 1/4] ARM: dts: sun4i: Add CAN node
In-Reply-To: <1491238814-4888-1-git-send-email-menschel.p@posteo.de>
References: <1491238814-4888-1-git-send-email-menschel.p@posteo.de>
Message-ID: <1491238814-4888-2-git-send-email-menschel.p@posteo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A10 SoC has an on-board CAN controller.
This patch adds the device node.

This patch is adapted from the description in
Documentation/devicetree/bindings/net/can/sun4i_can.txt

Signed-off-by: Patrick Menschel <menschel.p@posteo.de>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index ba20b48..7c559e7 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -1313,6 +1313,14 @@
 			#size-cells = <0>;
 		};
 
+		can0: can at 01c2bc00 {
+			compatible = "allwinner,sun4i-a10-can";
+			reg = <0x01c2bc00 0x400>;
+			interrupts = <26>;
+			clocks = <&apb1_gates 4>;
+			status = "disabled";
+		};
+
 		ps20: ps2 at 01c2a000 {
 			compatible = "allwinner,sun4i-a10-ps2";
 			reg = <0x01c2a000 0x400>;
-- 
1.9.1
