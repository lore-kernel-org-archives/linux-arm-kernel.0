From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri,  3 Oct 2014 17:54:57 +0200
Subject: [PATCH] ARM: dts: berlin: Add GPIO leds to Google Chromecast
Message-ID: <1412351697-4079-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With GPIO support for Marvell Berlin, now add the two gpio-connected
LEDs on Google Chromecast.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/berlin2cd-google-chromecast.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2cd-google-chromecast.dts b/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
index bcd81ffc495d..0816890a5c0d 100644
--- a/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
+++ b/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
@@ -11,6 +11,7 @@
 /dts-v1/;
 
 #include "berlin2cd.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Google Chromecast";
@@ -24,6 +25,22 @@
 		device_type = "memory";
 		reg = <0x00000000 0x20000000>; /* 512 MB */
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		white {
+			label = "white";
+			gpios = <&portc 1 GPIO_ACTIVE_HIGH>;
+			default-state = "keep";
+		};
+
+		red {
+			label = "red";
+			gpios = <&portc 2 GPIO_ACTIVE_HIGH>;
+			default-state = "keep";
+		};
+	};
 };
 
 &uart0 { status = "okay"; };
-- 
2.1.1
