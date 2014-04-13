From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 13 Apr 2014 16:39:47 +0200
Subject: [PATCH 10/29] ARM: orion5x: use existing dt-bindings include for
 Device Tree files
In-Reply-To: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1397400006-4315-11-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The orion5x-lacie-ethernet-disk-mini-v2.dts can benefit from using
gpio.h and input.h dt-bindings headers to replace hardcoded values by
more meaningful macros.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
index 0245bb3..24f1ce7 100644
--- a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
+++ b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
@@ -8,6 +8,8 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 #include "orion5x.dtsi"
 
 / {
@@ -40,8 +42,8 @@
 		#size-cells = <0>;
 		button at 1 {
 			label = "Power-on Switch";
-			linux,code = <116>; /* KEY_POWER */
-			gpios = <&gpio0 18 0>;
+			linux,code = <KEY_POWER>;
+			gpios = <&gpio0 18 GPIO_ACTIVE_HIGH>;
 		};
 	};
 
@@ -50,7 +52,7 @@
 
 		led at 1 {
 			label = "power:blue";
-			gpios = <&gpio0 16 1>;
+			gpios = <&gpio0 16 GPIO_ACTIVE_LOW>;
 		};
 	};
 };
-- 
1.8.3.2
