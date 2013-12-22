From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 22 Dec 2013 17:28:07 +0000
Subject: [PATCH] ARM: kirkwood: 6282: sort DT nodes by address
In-Reply-To: <cover.1386861599.git.jason@lakedaemon.net>
References: <cover.1386861599.git.jason@lakedaemon.net>
Message-ID: <1387733287-29166-1-git-send-email-jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We recently sorted the nodes in dove, orion5x, kirkwood, and armada
370/xp.  However, I missed this file.  -6281 is fine.

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
This is just an fyi, Andrew's patch adding the phy nodes brought this to my
attention.  I've applied this to mvebu/dt.

thx,

Jason.

 arch/arm/boot/dts/kirkwood-6282.dtsi | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-6282.dtsi b/arch/arm/boot/dts/kirkwood-6282.dtsi
index a4fec0432168..2902e0d7971d 100644
--- a/arch/arm/boot/dts/kirkwood-6282.dtsi
+++ b/arch/arm/boot/dts/kirkwood-6282.dtsi
@@ -104,6 +104,12 @@
 			};
 		};
 
+		thermal at 10078 {
+			compatible = "marvell,kirkwood-thermal";
+			reg = <0x10078 0x4>;
+			status = "okay";
+		};
+
 		rtc at 10300 {
 			compatible = "marvell,kirkwood-rtc", "marvell,orion-rtc";
 			reg = <0x10300 0x20>;
@@ -111,6 +117,17 @@
 			clocks = <&gate_clk 7>;
 		};
 
+		i2c at 11100 {
+			compatible = "marvell,mv64xxx-i2c";
+			reg = <0x11100 0x20>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <32>;
+			clock-frequency = <100000>;
+			clocks = <&gate_clk 7>;
+			status = "disabled";
+		};
+
 		sata at 80000 {
 			compatible = "marvell,orion-sata";
 			reg = <0x80000 0x5000>;
@@ -135,23 +152,5 @@
 			cap-mmc-highspeed;
 			status = "disabled";
 		};
-
-		thermal at 10078 {
-			compatible = "marvell,kirkwood-thermal";
-			reg = <0x10078 0x4>;
-			status = "okay";
-		};
-
-		i2c at 11100 {
-			compatible = "marvell,mv64xxx-i2c";
-			reg = <0x11100 0x20>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			interrupts = <32>;
-			clock-frequency = <100000>;
-			clocks = <&gate_clk 7>;
-			status = "disabled";
-		};
-
 	};
 };
-- 
1.8.5.2
