From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 14 Apr 2015 11:05:04 -0300
Subject: [PATCH] ARM: dts: imx23-olinuxino: Fix polarity of LED GPIO
Message-ID: <1429020304-31045-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On imx23-olinuxino the LED turns on when level logic high is aplied to
GPIO2_1.

Fix the gpios property accordingly.

Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx23-olinuxino.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx23-olinuxino.dts b/arch/arm/boot/dts/imx23-olinuxino.dts
index 7e6eef2..839a3b9 100644
--- a/arch/arm/boot/dts/imx23-olinuxino.dts
+++ b/arch/arm/boot/dts/imx23-olinuxino.dts
@@ -12,6 +12,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
 #include "imx23.dtsi"
 
 / {
@@ -122,7 +123,7 @@
 
 		user {
 			label = "green";
-			gpios = <&gpio2 1 1>;
+			gpios = <&gpio2 1 GPIO_ACTIVE_HIGH>;
 		};
 	};
 };
-- 
1.9.1
