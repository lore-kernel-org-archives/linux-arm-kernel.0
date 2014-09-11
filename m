From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 11 Sep 2014 11:56:56 +0200
Subject: [PATCH 1/4] ARM: mvebu: add gpio fan support to Armada 370 RD
In-Reply-To: <1410429419-29820-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1410429419-29820-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1410429419-29820-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 370 RD platform has a GPIO-controlled fan on MPP8, so this
commit adds the relevant hardware description to Armada 370 RD Device
Tree.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-rd.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
index 4169f40..7af04c4 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -50,6 +50,13 @@
 		};
 
 		internal-regs {
+			pinctrl {
+				fan_pins: fan-pins {
+					marvell,pins = "mpp8";
+					marvell,function = "gpio";
+				};
+			};
+
 			serial at 12000 {
 				status = "okay";
 			};
@@ -106,6 +113,14 @@
 				};
 			};
 
+			gpio-fan {
+				compatible = "gpio-fan";
+				gpios = <&gpio0 8 GPIO_ACTIVE_HIGH>;
+				gpio-fan,speed-map = <0 0 3000 1>;
+				pinctrl-0 = <&fan_pins>;
+				pinctrl-names = "default";
+			};
+
 			nand at d0000 {
 				status = "okay";
 				num-cs = <1>;
-- 
2.0.0
