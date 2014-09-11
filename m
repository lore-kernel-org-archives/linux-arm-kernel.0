From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 11 Sep 2014 11:56:57 +0200
Subject: [PATCH 2/4] ARM: mvebu: add user LED support of Armada 370 RD
In-Reply-To: <1410429419-29820-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1410429419-29820-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1410429419-29820-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 370 RD has a GPIO controlled LED connected on MPP32, so
this commit adds the relevant hardware description to Armada 370 RD
Device Tree.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-rd.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
index 7af04c4..10a6448 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -55,6 +55,11 @@
 					marvell,pins = "mpp8";
 					marvell,function = "gpio";
 				};
+
+				led_pins: led-pins {
+					marvell,pins = "mpp32";
+					marvell,function = "gpio";
+				};
 			};
 
 			serial at 12000 {
@@ -121,6 +126,18 @@
 				pinctrl-names = "default";
 			};
 
+			gpio_leds {
+				compatible = "gpio-leds";
+				pinctrl-names = "default";
+				pinctrl-0 = <&led_pins>;
+
+				sw_led {
+					label = "370rd:green:sw";
+					gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
+					default-state = "keep";
+				};
+			};
+
 			nand at d0000 {
 				status = "okay";
 				num-cs = <1>;
-- 
2.0.0
