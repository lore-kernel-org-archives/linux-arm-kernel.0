From: menschel.p@posteo.de (Patrick Menschel)
Date: Tue,  4 Apr 2017 20:36:28 +0200
Subject: [PATCH v4 2/6] ARM: dts: sun4i: Add CAN node
In-Reply-To: <1491330992-9876-1-git-send-email-menschel.p@posteo.de>
References: <1491330992-9876-1-git-send-email-menschel.p@posteo.de>
Message-ID: <1491330992-9876-3-git-send-email-menschel.p@posteo.de>
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
index 498f7f2..4d8eaf2 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -1329,5 +1329,13 @@
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
 	};
 };
-- 
2.7.4
