From: anilkumar@ti.com (AnilKumar Ch)
Date: Tue, 6 Nov 2012 19:18:34 +0530
Subject: [PATCH RESEND 06/10] ARM: dts: AM33XX: Add user-leds device tree data
 to am335x-bone
In-Reply-To: <1352209718-5586-1-git-send-email-anilkumar@ti.com>
References: <1352209718-5586-1-git-send-email-anilkumar@ti.com>
Message-ID: <1352209718-5586-7-git-send-email-anilkumar@ti.com>
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
index 1aac58b..2c33888 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -53,6 +53,36 @@
 
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
