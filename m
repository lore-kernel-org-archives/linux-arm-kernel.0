From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun,  5 Feb 2012 20:13:36 +0100
Subject: [PATCH 2/4] ARM: at91: at91sam9m10g45ek/dt: add leds support
In-Reply-To: <1328469218-3208-1-git-send-email-plagnioj@jcrosoft.com>
References: <1328469218-3208-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1328469218-3208-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

use the gpio for d7 as we do not support yet the pwm led via dt

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9m10g45ek.dts |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index 46360afb..112feba 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -80,6 +80,28 @@
 				};
 			};
 
+			leds {
+				compatible = "gpio-leds";
+
+				d8 {
+					label = "d8";
+					gpios = <&pioD 30 0>;
+					linux,default-trigger = "heartbeat";
+				};
+
+				d6 {
+					label = "d6";
+					gpios = <&pioD 0 1>;
+					linux,default-trigger = "nand-disk";
+				};
+
+				d7 {
+					label = "d7";
+					gpios = <&pioD 31 1>;
+					linux,default-trigger = "mmc0";
+				};
+			};
+
 		};
 	};
 
-- 
1.7.7
