From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 06 Sep 2016 00:33:05 +0300
Subject: [PATCH] ARM: dts: wheat: add support for tactile switches
In-Reply-To: <5383928.8UnDsUpmkz@wasted.cogentembedded.com>
References: <5383928.8UnDsUpmkz@wasted.cogentembedded.com>
Message-ID: <10465663.8teCsXZU7y@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add  support for the  tactile switches  SW2/3 (on the debug board) as a
virtual keyboard like it  was done with the Blanche board).

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against the 'renesas-devel-20160905-v4.8-rc5' of Simon Horman's
'renesas.git' repo plus the Wheat DU patch...

 arch/arm/boot/dts/r8a7792-wheat.dts |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7792-wheat.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7792-wheat.dts
+++ renesas/arch/arm/boot/dts/r8a7792-wheat.dts
@@ -12,6 +12,7 @@
 /dts-v1/;
 #include "r8a7792.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "Wheat";
@@ -56,6 +57,25 @@
 		pinctrl-names = "default";
 	};
 
+	keyboard {
+		compatible = "gpio-keys";
+
+		key-a {
+			linux,code = <KEY_A>;
+			label = "SW2";
+			wakeup-source;
+			debounce-interval = <20>;
+			gpios = <&gpio3 20 GPIO_ACTIVE_LOW>;
+		};
+		key-b {
+			linux,code = <KEY_B>;
+			label = "SW3";
+			wakeup-source;
+			debounce-interval = <20>;
+			gpios = <&gpio11 2 GPIO_ACTIVE_LOW>;
+		};
+	};
+
 	vcc_sdhi0: regulator-vcc-sdhi0 {
 		compatible = "regulator-fixed";
 
