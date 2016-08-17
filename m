From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 17 Aug 2016 22:03:06 +0300
Subject: [PATCH] ARM: dts: blanche: add support for general purpose switches
In-Reply-To: <5383928.8UnDsUpmkz@wasted.cogentembedded.com>
References: <5383928.8UnDsUpmkz@wasted.cogentembedded.com>
Message-ID: <10166368.YKl2X2iyOO@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support  for the  general purpose  software switches  SW2 and tactile
switches SW24/25 as a virtual keyboard (like it was done with the Lager/
Koelsch boards).

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against the 'renesas-devel-20160817-v4.8-rc2' of Simon Horman's
'renesas.git' repo.

 arch/arm/boot/dts/r8a7792-blanche.dts |   49 ++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7792-blanche.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7792-blanche.dts
+++ renesas/arch/arm/boot/dts/r8a7792-blanche.dts
@@ -11,6 +11,8 @@
 
 /dts-v1/;
 #include "r8a7792.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "Blanche";
@@ -54,6 +56,53 @@
 		pinctrl-0 = <&lan89218_pins>;
 		pinctrl-names = "default";
 	};
+
+	keyboard {
+		compatible = "gpio-keys";
+
+		key-1 {
+			linux,code = <KEY_1>;
+			label = "SW2-1";
+			wakeup-source;
+			debounce-interval = <20>;
+			gpios = <&gpio3 10 GPIO_ACTIVE_LOW>;
+		};
+		key-2 {
+			linux,code = <KEY_2>;
+			label = "SW2-2";
+			wakeup-source;
+			debounce-interval = <20>;
+			gpios = <&gpio3 11 GPIO_ACTIVE_LOW>;
+		};
+		key-3 {
+			linux,code = <KEY_3>;
+			label = "SW2-3";
+			wakeup-source;
+			debounce-interval = <20>;
+			gpios = <&gpio3 12 GPIO_ACTIVE_LOW>;
+		};
+		key-4 {
+			linux,code = <KEY_4>;
+			label = "SW2-4";
+			wakeup-source;
+			debounce-interval = <20>;
+			gpios = <&gpio3 15 GPIO_ACTIVE_LOW>;
+		};
+		key-a {
+			linux,code = <KEY_A>;
+			label = "SW24";
+			wakeup-source;
+			debounce-interval = <20>;
+			gpios = <&gpio3 20 GPIO_ACTIVE_LOW>;
+		};
+		key-b {
+			linux,code = <KEY_B>;
+			label = "SW25";
+			wakeup-source;
+			debounce-interval = <20>;
+			gpios = <&gpio11 2 GPIO_ACTIVE_LOW>;
+		};
+	};
 };
 
 &extal_clk {
