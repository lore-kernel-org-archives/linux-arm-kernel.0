From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 14 May 2015 10:06:46 +0900
Subject: [PATCH 17/31] ARM: shmobile: marzen dts: Use generic names for device
 nodes
In-Reply-To: <cover.1431565427.git.horms+renesas@verge.net.au>
References: <cover.1431565427.git.horms+renesas@verge.net.au>
Message-ID: <f92d9dc7e6cd15dcd096dc5a4d3e1fe0a034f659.1431565427.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

lan0 -> ethernet

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779-marzen.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts b/arch/arm/boot/dts/r8a7779-marzen.dts
index 540756cdf391..20afea6f06ef 100644
--- a/arch/arm/boot/dts/r8a7779-marzen.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen.dts
@@ -42,10 +42,10 @@
 		regulator-always-on;
 	};
 
-	lan0 at 18000000 {
+	ethernet at 18000000 {
 		compatible = "smsc,lan9220", "smsc,lan9115";
 		reg = <0x18000000 0x100>;
-		pinctrl-0 = <&lan0_pins>;
+		pinctrl-0 = <&ethernet_pins>;
 		pinctrl-names = "default";
 
 		phy-mode = "mii";
@@ -176,7 +176,7 @@
 		};
 	};
 
-	lan0_pins: lan0 {
+	ethernet_pins: ethernet {
 		intc {
 			renesas,groups = "intc_irq1_b";
 			renesas,function = "intc";
-- 
2.1.4
