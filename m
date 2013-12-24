From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 23:19:36 +0900
Subject: [PATCH 06/21] ARM: shmobile: armadillo: dts: Add gpio-keys device
In-Reply-To: <cover.1387893834.git.horms+renesas@verge.net.au>
References: <cover.1387893834.git.horms+renesas@verge.net.au>
Message-ID: <90c2434daa0b8c7ec2b75fcb182436813e9120bd.1387893834.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The board had 4 buttons connected to GPIOs, add a corresponding
gpio-keys device.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 .../boot/dts/r8a7740-armadillo800eva-reference.dts | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index e916aae..95a849b 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -72,6 +72,35 @@
 		regulator-boot-on;
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
1.8.4
