From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 27 Nov 2015 10:55:44 +0900
Subject: [PATCH 01/15] ARM: shmobile: r8a7790: switch console back to scif0
In-Reply-To: <cover.1448586938.git.horms+renesas@verge.net.au>
References: <cover.1448586938.git.horms+renesas@verge.net.au>
Message-ID: <430d7baddf2d913de76e8101d807f4f2861705f7.1448586938.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

The boot loader uses scif0, and so must we if we want earlycon to work.

Partially reverts 7c0558941 ("ARM: shmobile: r8a7790: switch from scif
to scifa").

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index e2174d816e78..79f141188d99 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -47,13 +47,13 @@
 	compatible = "renesas,lager", "renesas,r8a7790";
 
 	aliases {
-		serial0 = &scifa0;
+		serial0 = &scif0;
 		serial1 = &scifa1;
 	};
 
 	chosen {
 		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
-		stdout-path = &scifa0;
+		stdout-path = &scif0;
 	};
 
 	memory at 40000000 {
@@ -296,9 +296,9 @@
 		renesas,function = "du";
 	};
 
-	scifa0_pins: serial0 {
-		renesas,groups = "scifa0_data";
-		renesas,function = "scifa0";
+	scif0_pins: serial0 {
+		renesas,groups = "scif0_data";
+		renesas,function = "scif0";
 	};
 
 	ether_pins: ether {
@@ -467,8 +467,8 @@
 	};
 };
 
-&scifa0 {
-	pinctrl-0 = <&scifa0_pins>;
+&scif0 {
+	pinctrl-0 = <&scif0_pins>;
 	pinctrl-names = "default";
 
 	status = "okay";
-- 
2.1.4
