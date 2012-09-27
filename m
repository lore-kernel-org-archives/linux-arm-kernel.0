From: michael@walle.cc (Michael Walle)
Date: Thu, 27 Sep 2012 23:54:37 +0200
Subject: [PATCH] ARM: kirkwood: fix buttons on lsxl boards
Message-ID: <1348782877-857-1-git-send-email-michael@walle.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change event type to switch for the power and autopower switches.
Additionally, this patch aligns the keycodes with the other linkstation
boards already supported by linux.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm/boot/dts/kirkwood-lsxl.dtsi |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-lsxl.dtsi b/arch/arm/boot/dts/kirkwood-lsxl.dtsi
index a1dd36d..8fea375 100644
--- a/arch/arm/boot/dts/kirkwood-lsxl.dtsi
+++ b/arch/arm/boot/dts/kirkwood-lsxl.dtsi
@@ -48,17 +48,19 @@
 		#size-cells = <0>;
 		button at 1 {
 			label = "Function Button";
-			linux,code = <132>;
+			linux,code = <357>;
 			gpios = <&gpio1 9 1>;
 		};
 		button at 2 {
 			label = "Power-on Switch";
-			linux,code = <116>;
+			linux,code = <0>;
+			linux,input-type = <5>;
 			gpios = <&gpio1 10 1>;
 		};
 		button at 3 {
 			label = "Power-auto Switch";
-			linux,code = <142>;
+			linux,code = <1>;
+			linux,input-type = <5>;
 			gpios = <&gpio1 11 1>;
 		};
 	};
-- 
1.7.2.5
