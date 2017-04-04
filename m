From: menschel.p@posteo.de (Patrick Menschel)
Date: Tue,  4 Apr 2017 20:36:27 +0200
Subject: [PATCH v4 1/6] ARM: dts: sun4i: fix device node ordering
In-Reply-To: <1491330992-9876-1-git-send-email-menschel.p@posteo.de>
References: <1491330992-9876-1-git-send-email-menschel.p@posteo.de>
Message-ID: <1491330992-9876-2-git-send-email-menschel.p@posteo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes the device node position of ps20 and ps21 to fix
ordering by rising physical address.

From

uart7: serial at 01c29c00
i2c0: i2c at 01c2ac00
i2c1: i2c at 01c2b000
i2c2: i2c at 01c2b400
ps20: ps2 at 01c2a000
ps21: ps2 at 01c2a400

to

uart7: serial at 01c29c00
ps20: ps2 at 01c2a000
ps21: ps2 at 01c2a400
i2c0: i2c at 01c2ac00
i2c1: i2c at 01c2b000
i2c2: i2c at 01c2b400

Signed-off-by: Patrick Menschel <menschel.p@posteo.de>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index ba20b48..498f7f2 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -1283,6 +1283,22 @@
 			status = "disabled";
 		};
 
+		ps20: ps2 at 01c2a000 {
+			compatible = "allwinner,sun4i-a10-ps2";
+			reg = <0x01c2a000 0x400>;
+			interrupts = <62>;
+			clocks = <&apb1_gates 6>;
+			status = "disabled";
+		};
+
+		ps21: ps2 at 01c2a400 {
+			compatible = "allwinner,sun4i-a10-ps2";
+			reg = <0x01c2a400 0x400>;
+			interrupts = <63>;
+			clocks = <&apb1_gates 7>;
+			status = "disabled";
+		};
+
 		i2c0: i2c at 01c2ac00 {
 			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2ac00 0x400>;
@@ -1313,20 +1329,5 @@
 			#size-cells = <0>;
 		};
 
-		ps20: ps2 at 01c2a000 {
-			compatible = "allwinner,sun4i-a10-ps2";
-			reg = <0x01c2a000 0x400>;
-			interrupts = <62>;
-			clocks = <&apb1_gates 6>;
-			status = "disabled";
-		};
-
-		ps21: ps2 at 01c2a400 {
-			compatible = "allwinner,sun4i-a10-ps2";
-			reg = <0x01c2a400 0x400>;
-			interrupts = <63>;
-			clocks = <&apb1_gates 7>;
-			status = "disabled";
-		};
 	};
 };
-- 
2.7.4
