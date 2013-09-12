From: koen@dominion.thruhere.net (Koen Kooi)
Date: Thu, 12 Sep 2013 17:42:12 +0200
Subject: [PATCH 4/4] ARM: dts: am335x-bone-common: add cpu0 and mmc1 triggers
In-Reply-To: <1379000532-27376-1-git-send-email-koen@dominion.thruhere.net>
References: <1379000532-27376-1-git-send-email-koen@dominion.thruhere.net>
Message-ID: <1379000532-27376-5-git-send-email-koen@dominion.thruhere.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This matches the vendor 3.8.x configuration that is shipping with the boards.

The LED layout is now:

USR0: heartbeat
USR1: mmc0 (micro-SD slot)
USR2: cpu0
USR3: mmc1 (eMMC)

The cpu0 triggers was put inbetween the mmc triggers to make is easier to see
where the disk activity is.

Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index 80407ff..3057f30 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -203,12 +203,14 @@
 		led at 4 {
 			label = "beaglebone:green:usr2";
 			gpios = <&gpio1 23 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "cpu0";
 			default-state = "off";
 		};
 
 		led at 5 {
 			label = "beaglebone:green:usr3";
 			gpios = <&gpio1 24 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "mmc1";
 			default-state = "off";
 		};
 	};
-- 
1.8.2.1
