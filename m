From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 19 Jul 2013 13:37:13 +0900
Subject: [PATCH 14/19] ARM: shmobile: armadillo-reference: Add LED1-LED4 to
 the device tree
In-Reply-To: <cover.1374208262.git.horms+renesas@verge.net.au>
References: <cover.1374208262.git.horms+renesas@verge.net.au>
Message-ID: <35b235cac74f549e0e7b71c42234566b26ecb90f.1374208262.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

LED1 to LED4 are GPIO LEDs. Add corresponding DT nodes.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index 8ec4cd1..366f729 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -34,6 +34,21 @@
 		regulator-boot-on;
 	};
 
+	leds {
+		compatible = "gpio-leds";
+		led1 {
+			gpios = <&pfc 102 GPIO_ACTIVE_HIGH>;
+		};
+		led2 {
+			gpios = <&pfc 111 GPIO_ACTIVE_HIGH>;
+		};
+		led3 {
+			gpios = <&pfc 110 GPIO_ACTIVE_HIGH>;
+		};
+		led4 {
+			gpios = <&pfc 177 GPIO_ACTIVE_HIGH>;
+		};
+	};
 };
 
 &i2c0 {
-- 
1.7.10.4
