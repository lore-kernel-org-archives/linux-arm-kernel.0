From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Fri, 08 Jul 2016 14:58:39 +0100
Subject: [PATCH] ARM: dts: armada388-clearfog: number LAN ports properly
Message-ID: <E1bLWIh-0001ZK-Ai@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the ports as seen from the rear number as:

	eth0 sfp lan5 lan4 lan3 lan2 lan1 lan6

which is illogical - this came about because the rev 2.0 boards have the
LEDs on the front for the DSA switch (lan5-1) reversed.  Rev 2.1 boards
fixed the LED issue, and the Clearfog case numbers the lan ports
increasing from left to right.

Maintaining this illogical numbering causes confusion, with reports that
"my link isn't coming up" and "my connection negotiates 10base-Half"
both of which are due to people thinking that the port next to the SFP
is lan1.

Fix this by renumbering the ports to match people's expectations.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/dts/armada-388-clearfog.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/armada-388-clearfog.dts b/arch/arm/boot/dts/armada-388-clearfog.dts
index 54bf0749e15e..42d760da4e82 100644
--- a/arch/arm/boot/dts/armada-388-clearfog.dts
+++ b/arch/arm/boot/dts/armada-388-clearfog.dts
@@ -386,12 +386,12 @@
 
 			port at 0 {
 				reg = <0>;
-				label = "lan1";
+				label = "lan5";
 			};
 
 			port at 1 {
 				reg = <1>;
-				label = "lan2";
+				label = "lan4";
 			};
 
 			port at 2 {
@@ -401,12 +401,12 @@
 
 			port at 3 {
 				reg = <3>;
-				label = "lan4";
+				label = "lan2";
 			};
 
 			port at 4 {
 				reg = <4>;
-				label = "lan5";
+				label = "lan1";
 			};
 
 			port at 5 {
-- 
2.1.0
