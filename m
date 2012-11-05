From: anilkumar@ti.com (AnilKumar Ch)
Date: Mon, 5 Nov 2012 16:15:46 +0530
Subject: [PATCH 06/10] ARM: dts: AM33XX: Add user-leds device tree data to
 am335x-bone
In-Reply-To: <1352112350-13398-1-git-send-email-anilkumar@ti.com>
References: <1352112350-13398-1-git-send-email-anilkumar@ti.com>
Message-ID: <1352112350-13398-7-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add gpio-leds device tree data to am335x-bone device to enable gpio
based user-leds (USR0, USR1, USR2 and USR3) present on BeagleBone.

[koen at dominion.thruhere.net: led0, led1 suggested by koen]
Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am335x-bone.dts |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index 0bd0355..206c3eb 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -57,6 +57,36 @@
 			ti,system-power-controller;
 		};
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led at 2 {
+			label = "beaglebone:green:heartbeat";
+			gpios = <&gpio2 21 0>;
+			linux,default-trigger = "heartbeat";
+			default-state = "off";
+		};
+
+		led at 3 {
+			label = "beaglebone:green:mmc0";
+			gpios = <&gpio2 22 0>;
+			linux,default-trigger = "mmc0";
+			default-state = "off";
+		};
+
+		led at 4 {
+			label = "beaglebone:green:usr2";
+			gpios = <&gpio2 23 0>;
+			default-state = "off";
+		};
+
+		led at 5 {
+			label = "beaglebone:green:usr3";
+			gpios = <&gpio2 24 0>;
+			default-state = "off";
+		};
+	};
 };
 
 /include/ "tps65217.dtsi"
-- 
1.7.9.5
