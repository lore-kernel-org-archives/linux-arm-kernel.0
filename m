From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Wed, 11 Dec 2013 04:26:30 +0100
Subject: [PATCH 10/10] ARM: shmobile: armadillo: dts: Add gpio-keys device
In-Reply-To: <1386732390-31724-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1386732390-31724-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1386732390-31724-11-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The board had 4 buttons connected to GPIOs, add a corresponding
gpio-keys device.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 .../boot/dts/r8a7740-armadillo800eva-reference.dts | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index 6d6fd3d..e67c0a5 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -63,6 +63,35 @@
 		enable-active-high;
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		power-key {
+			gpios = <&pfc 99 GPIO_ACTIVE_LOW>;
+			linux,code = <116>;
+			label = "SW3";
+			gpio-key,wakeup;
+		};
+
+		back-key {
+			gpios = <&pfc 100 GPIO_ACTIVE_LOW>;
+			linux,code = <158>;
+			label = "SW4";
+		};
+
+		menu-key {
+			gpios = <&pfc 97 GPIO_ACTIVE_LOW>;
+			linux,code = <139>;
+			label = "SW5";
+		};
+
+		home-key {
+			gpios = <&pfc 98 GPIO_ACTIVE_LOW>;
+			linux,code = <102>;
+			label = "SW6";
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		led1 {
-- 
1.8.3.2
