From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 23:19:34 +0900
Subject: [PATCH 11/21] ARM: shmobile: Sync Koelsch DTS with Koelsch reference
 DTS
In-Reply-To: <cover.1387893834.git.horms+renesas@verge.net.au>
References: <cover.1387893834.git.horms+renesas@verge.net.au>
Message-ID: <f8e2535d988a7945fa2c11214d55c20c73c60840.1387893834.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Copy the device nodes from Koelsch reference into the Koeslch device
tree file. This will allow us to use a single DTS file regarless of
kernel configuration. In case of legacy C board code the device nodes
may or may not be used, but in the multiplatform case all the DT device
nodes are used.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index c4e8b3a..d431f31 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -11,6 +11,7 @@
 
 /dts-v1/;
 #include "r8a7791.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Koelsch";
@@ -29,4 +30,32 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		led6 {
+			gpios = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		};
+		led7 {
+			gpios = <&gpio2 20 GPIO_ACTIVE_HIGH>;
+		};
+		led8 {
+			gpios = <&gpio2 21 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
+
+&pfc {
+	pinctrl-0 = <&scif0_pins &scif1_pins>;
+	pinctrl-names = "default";
+
+	scif0_pins: serial0 {
+		renesas,groups = "scif0_data_d";
+		renesas,function = "scif0";
+	};
+
+	scif1_pins: serial1 {
+		renesas,groups = "scif1_data_d";
+		renesas,function = "scif1";
+	};
 };
-- 
1.8.4
