From: nigel@nobiscuit.com (Nigel Roberts)
Date: Mon,  1 Apr 2013 23:03:22 +1100
Subject: [PATCH] Fix typo in the definition of ix2-200 rebuild LED
In-Reply-To: <1364817802-7889-1-git-send-email-nigel@nobiscuit.com>
References: <1364817802-7889-1-git-send-email-nigel@nobiscuit.com>
Message-ID: <1364817802-7889-2-git-send-email-nigel@nobiscuit.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the conversion to pinctrl, an error in the pins for the rebuild
LED was introduced. This patch assigns the correct pins and includes
the correct name for the LED in kirkwood-iomega_ix2_200.dts.

Signed-off-by: Nigel Roberts <nigel@nobiscuit.com>
---
 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts b/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
index 93c3afb..3694e94 100644
--- a/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
+++ b/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
@@ -96,11 +96,11 @@
 				marvell,function = "gpio";
 			};
 			pmx_led_rebuild_brt_ctrl_1: pmx-led-rebuild-brt-ctrl-1 {
-				marvell,pins = "mpp44";
+				marvell,pins = "mpp46";
 				marvell,function = "gpio";
 			};
 			pmx_led_rebuild_brt_ctrl_2: pmx-led-rebuild-brt-ctrl-2 {
-				marvell,pins = "mpp45";
+				marvell,pins = "mpp47";
 				marvell,function = "gpio";
 			};
 
@@ -157,14 +157,14 @@
 			gpios = <&gpio0 16 0>;
 			linux,default-trigger = "default-on";
 		};
-		health_led1 {
+		rebuild_led {
+			label = "status:white:rebuild_led";
+			gpios = <&gpio1 4 0>;
+		};
+		health_led {
 			label = "status:red:health_led";
 			gpios = <&gpio1 5 0>;
 		};
-		health_led2 {
-			label = "status:white:health_led";
-			gpios = <&gpio1 4 0>;
-		};
 		backup_led {
 			label = "status:blue:backup_led";
 			gpios = <&gpio0 15 0>;
-- 
1.7.9.5
