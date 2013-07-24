From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 24 Jul 2013 09:32:55 +0900
Subject: [PATCH 16/19] ARM: shmobile: marzen-reference: Add LED2-LED4 to the
 device tree
In-Reply-To: <cover.1374625203.git.horms+renesas@verge.net.au>
References: <cover.1374625203.git.horms+renesas@verge.net.au>
Message-ID: <80d1126fae07fd4bd6a93ad626ad14e753f9d892.1374625203.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

LED2 to LED4 are GPIO LEDs. Add corresponding DT nodes.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
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
1.8.2.1
