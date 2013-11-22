From: arno@natisbad.org (Arnaud Ebalard)
Date: Fri, 22 Nov 2013 15:58:04 +0100
Subject: [PATCHv2] ARM: mvebu: Add DT entry for ReadyNAS Duo v2 to use
 gpio-poweroff driver
Message-ID: <87eh68fpqb.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Without that fix, at the end of the shutdown process, the board is
still powered (led glowing, fan running, ...).

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---

Changes since v1:
 - use macro instead of value for GPIO voltage level

 arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts b/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
index e6a102c..551bfed 100644
--- a/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
+++ b/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
@@ -1,5 +1,6 @@
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
 #include "kirkwood.dtsi"
 #include "kirkwood-6282.dtsi"
 
@@ -60,6 +61,10 @@
 				marvell,pins = "mpp29";
 				marvell,function = "gpio";
 			};
+			pmx_poweroff: pmx-poweroff {
+				marvell,pins = "mpp30";
+				marvell,function = "gpio";
+			};
 		};
 
 		clocks {
@@ -158,6 +163,13 @@
 		};
 	};
 
+	gpio-poweroff {
+		compatible = "gpio-poweroff";
+		pinctrl-0 = <&pmx_poweroff>;
+		pinctrl-names = "default";
+		gpios = <&gpio0 30 GPIO_ACTIVE_LOW>;
+	};
+
         regulators {
                 compatible = "simple-bus";
                 #address-cells = <1>;
-- 
1.8.4.4
