From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 27 Dec 2012 23:21:10 +0100
Subject: [PATCH] ARM: Dove: move CuBox led pinctrl to gpio-leds node
Message-ID: <1356646870-2903-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpio-leds has support for pinctrl allocation, make use of it.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/dove-cubox.dts |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dove-cubox.dts b/arch/arm/boot/dts/dove-cubox.dts
index cdee96f..bed5b62 100644
--- a/arch/arm/boot/dts/dove-cubox.dts
+++ b/arch/arm/boot/dts/dove-cubox.dts
@@ -17,6 +17,9 @@
 
 	leds {
 		compatible = "gpio-leds";
+		pinctrl-0 = <&pmx_gpio_18>;
+		pinctrl-names = "default";
+
 		power {
 			label = "Power";
 			gpios = <&gpio0 18 1>;
@@ -47,7 +50,7 @@
 };
 
 &pinctrl {
-	pinctrl-0 = <&pmx_gpio_12 &pmx_gpio_18>;
+	pinctrl-0 = <&pmx_gpio_12>;
 	pinctrl-names = "default";
 
 	pmx_gpio_12: pmx-gpio-12 {
-- 
1.7.10.4
