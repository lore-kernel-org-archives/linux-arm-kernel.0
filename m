From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 14 May 2015 10:06:45 +0900
Subject: [PATCH 16/31] ARM: shmobile: kzm9d dts: Use generic names for device
 nodes
In-Reply-To: <cover.1431565427.git.horms+renesas@verge.net.au>
References: <cover.1431565427.git.horms+renesas@verge.net.au>
Message-ID: <69478b2093796860e3991db102ede97131b8d67a.1431565427.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

lan9220 -> ethernet
uart -> serial

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/emev2-kzm9d.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/emev2-kzm9d.dts b/arch/arm/boot/dts/emev2-kzm9d.dts
index 19446273e4a7..1dee0aa4f40c 100644
--- a/arch/arm/boot/dts/emev2-kzm9d.dts
+++ b/arch/arm/boot/dts/emev2-kzm9d.dts
@@ -81,7 +81,7 @@
 		regulator-boot-on;
 	};
 
-	lan9220 at 20000000 {
+	ethernet at 20000000 {
 		compatible = "smsc,lan9220", "smsc,lan9115";
 		reg = <0x20000000 0x10000>;
 		phy-mode = "mii";
@@ -96,7 +96,7 @@
 };
 
 &pfc {
-	uart1_pins: uart at e1030000 {
+	uart1_pins: serial at e1030000 {
 		renesas,groups = "uart1_ctrl", "uart1_data";
 		renesas,function = "uart1";
 	};
-- 
2.1.4
