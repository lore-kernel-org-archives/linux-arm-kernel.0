From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:31:25 +0900
Subject: [PATCH 51/69] ARM: shmobile: Koelsch DT reference GPIO LED support
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <614a198d45e523f6066f1c22b9c10e4067f2c44a.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add led6, led7 and led8 to the Koelsch DT reference board support.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch-reference.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch-reference.dts b/arch/arm/boot/dts/r8a7791-koelsch-reference.dts
index 8e7e917..1919273 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch-reference.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch-reference.dts
@@ -11,6 +11,7 @@
 
 /dts-v1/;
 #include "r8a7791.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Koelsch";
@@ -29,6 +30,19 @@
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
 };
 
 &pfc {
-- 
1.8.4
