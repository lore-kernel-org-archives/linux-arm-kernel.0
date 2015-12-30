From: romain.perier@gmail.com (Romain Perier)
Date: Wed, 30 Dec 2015 12:16:59 +0100
Subject: [PATCH] ARM: dts: rockchip: Adding LEDs handling via leds-gpio for
 the Radxa Rock2 Square
Message-ID: <1451474219-1313-1-git-send-email-romain.perier@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 arch/arm/boot/dts/rk3288-rock2-square.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-rock2-square.dts b/arch/arm/boot/dts/rk3288-rock2-square.dts
index c5453a0..a33020f 100644
--- a/arch/arm/boot/dts/rk3288-rock2-square.dts
+++ b/arch/arm/boot/dts/rk3288-rock2-square.dts
@@ -56,6 +56,23 @@
 		pinctrl-0 = <&ir_int>;
 	};
 
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		heartbeat {
+			gpios = <&gpio7 15 GPIO_ACTIVE_LOW>;
+			label = "rock2:green:heartbeat";
+			linux,default-trigger = "heartbeat";
+		};
+
+		mmc {
+			gpios = <&gpio0 11 GPIO_ACTIVE_LOW>;
+			label = "rock2:blue:mmc";
+			linux,default-trigger = "mmc0";
+		};
+	};
+
+
 	sound {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "SPDIF";
-- 
2.5.0
