From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Tue, 21 May 2013 14:14:40 +0200
Subject: [PATCH v4 19/21] ARM: shmobile: kzm9g-reference: Add LED1-LED4 to the
 device tree
In-Reply-To: <1369138482-5871-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1369138482-5871-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1369138482-5871-20-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

LED1 to LED4 are GPIO LEDs. Add corresponding DT nodes.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index cdfd71a..21b0fe3 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -88,6 +88,22 @@
 		vddvario-supply = <&reg_1p8v>;
 		vdd33a-supply = <&reg_3p3v>;
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		led1 {
+			gpios = <&pfc 20 1>; /* Active low */
+		};
+		led2 {
+			gpios = <&pfc 21 1>; /* Active low */
+		};
+		led3 {
+			gpios = <&pfc 22 1>; /* Active low */
+		};
+		led4 {
+			gpios = <&pfc 23 1>; /* Active low */
+		};
+	};
 };
 
 &i2c0 {
-- 
1.8.1.5
