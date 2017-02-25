From: florian.vaussard@gmail.com (Florian Vaussard)
Date: Sat, 25 Feb 2017 06:54:28 +0100
Subject: [PATCH 5/6] ARM: dts: socfpga: Remove unit name for LEDs in EBV
 SOCrates
In-Reply-To: <1488002069-22404-1-git-send-email-florian.vaussard@heig-vd.ch>
References: <1488002069-22404-1-git-send-email-florian.vaussard@heig-vd.ch>
Message-ID: <1488002069-22404-6-git-send-email-florian.vaussard@heig-vd.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIO LEDs in the Cyclone5 EBV SOCrates board have a unit name but no reg
property. Indeed, GPIO LEDs do not need such a property. They do not
need a unit name neither. This will trigger the following warnings when
compiled with W=1:

Node /gpio-leds/led at 0 has a unit name, but no reg property
Node /gpio-leds/led at 1 has a unit name, but no reg property
Node /gpio-leds/led at 2 has a unit name, but no reg property

The solution is to remove the unit name. In order to have unique node
names, a rename is necessary. This should be harmless as all the LEDs
have a 'label' property, hence their name do not derive from the node
name and will stay the same after this patch.

Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
---
 arch/arm/boot/dts/socfpga_cyclone5_socrates.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts b/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
index 8e3b017..53bf99e 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
@@ -60,18 +60,18 @@
 &leds {
 	compatible = "gpio-leds";
 
-	led at 0 {
+	led0 {
 		label = "led:green:heartbeat";
 		gpios = <&porta 28 1>;
 		linux,default-trigger = "heartbeat";
 	};
 
-	led at 1 {
+	led1 {
 		label = "led:green:D7";
 		gpios = <&portb 19 1>;
 	};
 
-	led at 2 {
+	led2 {
 		label = "led:green:D8";
 		gpios = <&portb 25 1>;
 	};
-- 
2.7.4
