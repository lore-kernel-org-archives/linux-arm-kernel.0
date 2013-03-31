From: nigel@nobiscuit.com (Nigel Roberts)
Date: Sun, 31 Mar 2013 15:13:23 +1100
Subject: [PATCH 1/2] Fix typo in the definition of rebuild LED pins for ix2-200
In-Reply-To: <1364703204-14982-1-git-send-email-nigel@nobiscuit.com>
References: <1364703204-14982-1-git-send-email-nigel@nobiscuit.com>
Message-ID: <1364703204-14982-2-git-send-email-nigel@nobiscuit.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
