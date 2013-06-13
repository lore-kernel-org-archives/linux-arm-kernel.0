From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Fri, 14 Jun 2013 01:46:01 +0200
Subject: [PATCH v6 16/18] ARM: shmobile: armadillo-reference: Add LED1-LED4 to
 the device tree
In-Reply-To: <1371167163-10507-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1371167163-10507-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1371167163-10507-17-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

LED1 to LED4 are GPIO LEDs. Add corresponding DT nodes.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts | 15 +++++++++++++++
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
1.8.1.5
