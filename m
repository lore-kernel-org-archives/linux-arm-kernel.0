From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 16 Dec 2014 22:59:59 +0100
Subject: [PATCH 6/6] ARM: sunxi: DT: Convert the DTs to use the generic
 interrupt header
In-Reply-To: <1418767199-20957-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1418767199-20957-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1418767199-20957-6-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NMI IRQ controller uses the standard flags definition for the IRQ level and
edges.

Use the common header to use defines instead of opaque numbers.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20-bananapi.dts        | 4 +++-
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     | 4 +++-
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts      | 4 +++-
 arch/arm/boot/dts/sun7i-a20-hummingbird.dts     | 4 +++-
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts       | 4 +++-
 arch/arm/boot/dts/sun7i-a20-m3.dts              | 4 +++-
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts  | 4 +++-
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 4 +++-
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 4 +++-
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts        | 3 ++-
 10 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
index d5e5d39ff3c0..6ee352b852bf 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
@@ -52,6 +52,8 @@
 #include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
 #include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
@@ -157,7 +159,7 @@
 				compatible = "x-powers,axp209";
 				reg = <0x34>;
 				interrupt-parent = <&nmi_intc>;
-				interrupts = <0 8>;
+				interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 
 				interrupt-controller;
 				#interrupt-cells = <1>;
diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
index 9dc4c10f682e..94344d2a87e0 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
@@ -16,6 +16,8 @@
 #include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
 #include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
@@ -90,7 +92,7 @@
 				compatible = "x-powers,axp209";
 				reg = <0x34>;
 				interrupt-parent = <&nmi_intc>;
-				interrupts = <0 8>;
+				interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 
 				interrupt-controller;
 				#interrupt-cells = <1>;
diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index 673846245cd9..811749672158 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -16,6 +16,8 @@
 #include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
 #include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
@@ -132,7 +134,7 @@
 				compatible = "x-powers,axp209";
 				reg = <0x34>;
 				interrupt-parent = <&nmi_intc>;
-				interrupts = <0 8>;
+				interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 
 				interrupt-controller;
 				#interrupt-cells = <1>;
diff --git a/arch/arm/boot/dts/sun7i-a20-hummingbird.dts b/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
index 4356a1709559..f5b02ec6016d 100644
--- a/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
+++ b/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
@@ -16,6 +16,8 @@
 #include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
 #include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
@@ -150,7 +152,7 @@
 				compatible = "x-powers,axp209";
 				reg = <0x34>;
 				interrupt-parent = <&nmi_intc>;
-				interrupts = <0 8>;
+				interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 				interrupt-controller;
 				#interrupt-cells = <1>;
 			};
diff --git a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
index 275e49ffb78b..a4fcd479e0e7 100644
--- a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
+++ b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
@@ -50,6 +50,8 @@
 #include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
 #include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
@@ -154,7 +156,7 @@
 				compatible = "x-powers,axp209";
 				reg = <0x34>;
 				interrupt-parent = <&nmi_intc>;
-				interrupts = <0 8>;
+				interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 
 				interrupt-controller;
 				#interrupt-cells = <1>;
diff --git a/arch/arm/boot/dts/sun7i-a20-m3.dts b/arch/arm/boot/dts/sun7i-a20-m3.dts
index 15be3ea80088..693ae780aa99 100644
--- a/arch/arm/boot/dts/sun7i-a20-m3.dts
+++ b/arch/arm/boot/dts/sun7i-a20-m3.dts
@@ -52,6 +52,8 @@
 #include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
 #include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
@@ -130,7 +132,7 @@
 				compatible = "x-powers,axp209";
 				reg = <0x34>;
 				interrupt-parent = <&nmi_intc>;
-				interrupts = <0 8>;
+				interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 
 				interrupt-controller;
 				#interrupt-cells = <1>;
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
index f74405cd18b6..14c46cfcccb8 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
@@ -53,6 +53,8 @@
 #include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
 #include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
@@ -128,7 +130,7 @@
 				compatible = "x-powers,axp209";
 				reg = <0x34>;
 				interrupt-parent = <&nmi_intc>;
-				interrupts = <0 8>;
+				interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 
 				interrupt-controller;
 				#interrupt-cells = <1>;
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index 7176721f6c6b..263b95572d74 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -50,6 +50,8 @@
 #include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
 #include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
@@ -125,7 +127,7 @@
 				compatible = "x-powers,axp209";
 				reg = <0x34>;
 				interrupt-parent = <&nmi_intc>;
-				interrupts = <0 8>;
+				interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 
 				interrupt-controller;
 				#interrupt-cells = <1>;
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index 3e2979b03cf6..85023f8dcc75 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -16,6 +16,8 @@
 #include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
 #include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
@@ -130,7 +132,7 @@
 				compatible = "x-powers,axp209";
 				reg = <0x34>;
 				interrupt-parent = <&nmi_intc>;
-				interrupts = <0 8>;
+				interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 
 				interrupt-controller;
 				#interrupt-cells = <1>;
diff --git a/arch/arm/boot/dts/sun7i-a20-pcduino3.dts b/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
index 30f7a11a0017..f27d8e765c14 100644
--- a/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
+++ b/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
@@ -52,6 +52,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 #include <dt-bindings/pinctrl/sun4i-a10.h>
 
@@ -138,7 +139,7 @@
 				compatible = "x-powers,axp209";
 				reg = <0x34>;
 				interrupt-parent = <&nmi_intc>;
-				interrupts = <0 8>;
+				interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 
 				interrupt-controller;
 				#interrupt-cells = <1>;
-- 
2.2.0
