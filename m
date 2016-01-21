From: rogershimizu@gmail.com (Roger Shimizu)
Date: Thu, 21 Jan 2016 23:38:45 +0900
Subject: [PATCH v3 2/7] ARM: dts: kirkwood: gpio pin fixes for linkstation
 ls-wvl/vl
In-Reply-To: <1453387130-6914-1-git-send-email-rogershimizu@gmail.com>
References: <1453387130-6914-1-git-send-email-rogershimizu@gmail.com>
Message-ID: <1453387130-6914-3-git-send-email-rogershimizu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For kirkwood, gpio pins starts from 32 are in the 2nd bank, so it should be
converted to "gpio1 <pin minus 32>" in dts file.
e.g. gpio 40 should be "gpio1 8"

The pin/bank issue was found when discussing Debian Bug #810894
  [https://bugs.debian.org/810894#47]

Fixes: c43379e150aa ("ARM: dts: add buffalo linkstation ls-wvl/vl")
Reported-by: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-lswvl.dts | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-lswvl.dts b/arch/arm/boot/dts/kirkwood-lswvl.dts
index 09eed3cea0af..28fd9abd7a57 100644
--- a/arch/arm/boot/dts/kirkwood-lswvl.dts
+++ b/arch/arm/boot/dts/kirkwood-lswvl.dts
@@ -1,7 +1,8 @@
 /*
  * Device Tree file for Buffalo Linkstation LS-WVL/VL
  *
- * Copyright (C) 2015, rogershimizu at gmail.com
+ * Copyright (C) 2015, 2016
+ * Roger Shimizu <rogershimizu@gmail.com>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -156,21 +157,21 @@
 		button at 1 {
 			label = "Function Button";
 			linux,code = <KEY_OPTION>;
-			gpios = <&gpio0 45 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
 		};
 
 		button at 2 {
 			label = "Power-on Switch";
 			linux,code = <KEY_RESERVED>;
 			linux,input-type = <5>;
-			gpios = <&gpio0 46 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
 		};
 
 		button at 3 {
 			label = "Power-auto Switch";
 			linux,code = <KEY_ESC>;
 			linux,input-type = <5>;
-			gpios = <&gpio0 47 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
 		};
 	};
 
@@ -185,38 +186,38 @@
 
 		led at 1 {
 			label = "lswvl:red:alarm";
-			gpios = <&gpio0 36 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
 		};
 
 		led at 2 {
 			label = "lswvl:red:func";
-			gpios = <&gpio0 37 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
 		};
 
 		led at 3 {
 			label = "lswvl:amber:info";
-			gpios = <&gpio0 38 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
 		};
 
 		led at 4 {
 			label = "lswvl:blue:func";
-			gpios = <&gpio0 39 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
 		};
 
 		led at 5 {
 			label = "lswvl:blue:power";
-			gpios = <&gpio0 40 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
 			default-state = "keep";
 		};
 
 		led at 6 {
 			label = "lswvl:red:hdderr0";
-			gpios = <&gpio0 34 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
 		};
 
 		led at 7 {
 			label = "lswvl:red:hdderr1";
-			gpios = <&gpio0 35 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;
 		};
 	};
 
@@ -233,7 +234,7 @@
 				3250 1
 				5000 0>;
 
-		alarm-gpios = <&gpio0 43 GPIO_ACTIVE_HIGH>;
+		alarm-gpios = <&gpio1 11 GPIO_ACTIVE_HIGH>;
 	};
 
 	restart_poweroff {
-- 
2.1.4
