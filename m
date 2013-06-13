From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Fri, 14 Jun 2013 01:46:03 +0200
Subject: [PATCH v6 18/18] ARM: shmobile: marzen-reference: Add LED2-LED4 to
 the device tree
In-Reply-To: <1371167163-10507-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1371167163-10507-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1371167163-10507-19-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

LED2 to LED4 are GPIO LEDs. Add corresponding DT nodes.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7779-marzen-reference.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779-marzen-reference.dts b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
index 6d20247..b64705b 100644
--- a/arch/arm/boot/dts/r8a7779-marzen-reference.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
@@ -11,6 +11,7 @@
 
 /dts-v1/;
 /include/ "r8a7779.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "marzen";
@@ -47,6 +48,19 @@
 		vddvario-supply = <&fixedregulator3v3>;
 		vdd33a-supply = <&fixedregulator3v3>;
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		led2 {
+			gpios = <&gpio4 29 GPIO_ACTIVE_HIGH>;
+		};
+		led3 {
+			gpios = <&gpio4 30 GPIO_ACTIVE_HIGH>;
+		};
+		led4 {
+			gpios = <&gpio4 31 GPIO_ACTIVE_HIGH>;
+		};
+	};
 };
 
 &pfc {
-- 
1.8.1.5
