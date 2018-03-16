From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 17:38:40 +0100
Subject: [PATCH 43/47] ARM: dts: lager: Move cec_clock to root node
In-Reply-To: <cover.1521218085.git.horms+renesas@verge.net.au>
References: <cover.1521218085.git.horms+renesas@verge.net.au>
Message-ID: <fe61513f1611def2535962954be4bb4fc2cb182c.1521218085.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

cec-clock is a fixed clock generator that is not controlled by i2c-12
and thus should not be a child of the i2c-12 bus node. Rather, it should
be a child of the root node of the DT.

Fixes: c5aa87977626e778 ("ARM: dts: lager: Add CEC clock for HDMI transmitter")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 20c1b4f224b8..063fdb65dc60 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -247,6 +247,12 @@
 		};
 	};
 
+	cec_clock: cec-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <12000000>;
+	};
+
 	hdmi-out {
 		compatible = "hdmi-connector";
 		type = "a";
@@ -352,12 +358,6 @@
 			};
 		};
 
-		cec_clock: cec-clock {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <12000000>;
-		};
-
 		hdmi at 39 {
 			compatible = "adi,adv7511w";
 			reg = <0x39>;
-- 
2.11.0
