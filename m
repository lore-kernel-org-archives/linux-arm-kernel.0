From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Aug 2013 13:28:29 +0900
Subject: [GIT PULL 05/19] ARM: shmobile: lager-reference: Add LED6-LED8 to the
 device tree
In-Reply-To: <cover.1375838900.git.horms+renesas@verge.net.au>
References: <cover.1375838900.git.horms+renesas@verge.net.au>
Message-ID: <466f302e076236a4796079681ca2a2f34a5792a3.1375838900.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

LED6 to LED8 are GPIO LEDs. Add corresponding DT nodes.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager-reference.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager-reference.dts b/arch/arm/boot/dts/r8a7790-lager-reference.dts
index fa5b81b..5ee71cf5 100644
--- a/arch/arm/boot/dts/r8a7790-lager-reference.dts
+++ b/arch/arm/boot/dts/r8a7790-lager-reference.dts
@@ -10,6 +10,7 @@
 
 /dts-v1/;
 /include/ "r8a7790.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Lager";
@@ -28,4 +29,17 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		led6 {
+			gpios = <&gpio4 22 GPIO_ACTIVE_HIGH>;
+		};
+		led7 {
+			gpios = <&gpio4 23 GPIO_ACTIVE_HIGH>;
+		};
+		led8 {
+			gpios = <&gpio5 17 GPIO_ACTIVE_HIGH>;
+		};
+	};
 };
-- 
1.8.3.2
