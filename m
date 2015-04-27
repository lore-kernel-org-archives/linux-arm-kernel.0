From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 27 Apr 2015 14:55:33 +0200
Subject: [PATCH 09/10] ARM: shmobile: kzm9d dts: Use generic names for device
 nodes
In-Reply-To: <1430139334-15272-1-git-send-email-geert+renesas@glider.be>
References: <1430139334-15272-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1430139334-15272-10-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

lan9220 -> ethernet
uart -> serial

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/emev2-kzm9d.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/emev2-kzm9d.dts b/arch/arm/boot/dts/emev2-kzm9d.dts
index 19446273e4a7f832..1dee0aa4f40cc351 100644
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
1.9.1
