From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 14 Nov 2014 20:36:16 +0100
Subject: [PATCH] ARM: mvebu: fix ordering in Armada 370 .dtsi
Message-ID: <1415993776-3469-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/armada-370.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 6b3c23b1e138..7513410f7b89 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -106,11 +106,6 @@
 				reg = <0x11100 0x20>;
 			};
 
-			system-controller at 18200 {
-				compatible = "marvell,armada-370-xp-system-controller";
-				reg = <0x18200 0x100>;
-			};
-
 			pinctrl {
 				compatible = "marvell,mv88f6710-pinctrl";
 				reg = <0x18000 0x38>;
@@ -205,6 +200,11 @@
 				interrupts = <91>;
 			};
 
+			system-controller at 18200 {
+				compatible = "marvell,armada-370-xp-system-controller";
+				reg = <0x18200 0x100>;
+			};
+
 			gateclk: clock-gating-control at 18220 {
 				compatible = "marvell,armada-370-gating-clock";
 				reg = <0x18220 0x4>;
-- 
2.1.3
