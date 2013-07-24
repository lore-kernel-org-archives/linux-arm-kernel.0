From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 24 Jul 2013 09:32:58 +0900
Subject: [PATCH 19/19] ARM: shmobile: kzm9g-reference: Add LED1-LED4 to the
 device tree
In-Reply-To: <cover.1374625203.git.horms+renesas@verge.net.au>
References: <cover.1374625203.git.horms+renesas@verge.net.au>
Message-ID: <1469273960de45275f33276c7254456edcba9da2.1374625203.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

LED1 to LED4 are GPIO LEDs. Add corresponding DT nodes.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index d2b2c9f..b99e890 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -89,6 +89,22 @@
 		vddvario-supply = <&reg_1p8v>;
 		vdd33a-supply = <&reg_3p3v>;
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		led1 {
+			gpios = <&pfc 20 GPIO_ACTIVE_LOW>;
+		};
+		led2 {
+			gpios = <&pfc 21 GPIO_ACTIVE_LOW>;
+		};
+		led3 {
+			gpios = <&pfc 22 GPIO_ACTIVE_LOW>;
+		};
+		led4 {
+			gpios = <&pfc 23 GPIO_ACTIVE_LOW>;
+		};
+	};
 };
 
 &i2c0 {
-- 
1.8.2.1
