From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Sat,  9 Nov 2013 13:23:55 +0100
Subject: [PATCH 3/7] ARM: shmobile: Use interrupt macros in board DT files
In-Reply-To: <1383999839-3339-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383999839-3339-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1383999839-3339-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a73a4-ape6evm.dts                   | 3 ++-
 arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts | 3 ++-
 arch/arm/boot/dts/r8a7778-bockw-reference.dts           | 3 ++-
 arch/arm/boot/dts/r8a7779-marzen-reference.dts          | 3 ++-
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts            | 3 ++-
 5 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index 7db8d79..e84d1a7 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -10,6 +10,7 @@
 
 /dts-v1/;
 #include "r8a73a4.dtsi"
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "APE6EVM";
@@ -40,7 +41,7 @@
 			compatible = "smsc,lan9118", "smsc,lan9115";
 			reg = <0x08000000 0x1000>;
 			interrupt-parent = <&irqc1>;
-			interrupts = <8 0x4>;
+			interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
 			phy-mode = "mii";
 			reg-io-width = <4>;
 			smsc,irq-active-high;
diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index c7c5bcb..aef425f 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -11,6 +11,7 @@
 /dts-v1/;
 #include "r8a7740.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pwm/pwm.h>
 
 / {
@@ -94,7 +95,7 @@
 		compatible = "sitronix,st1232";
 		reg = <0x55>;
 		interrupt-parent = <&irqpin1>;
-		interrupts = <2 0>; /* IRQ10: hwirq 2 on irqpin1 */
+		interrupts = <2 IRQ_TYPE_NONE>; /* IRQ10: hwirq 2 on irqpin1 */
 		pinctrl-0 = <&st1232_pins>;
 		pinctrl-names = "default";
 		gpios = <&pfc 166 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/r8a7778-bockw-reference.dts b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
index e7751ee..f887dc1 100644
--- a/arch/arm/boot/dts/r8a7778-bockw-reference.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
@@ -16,6 +16,7 @@
 
 /dts-v1/;
 #include "r8a7778.dtsi"
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "bockw";
@@ -45,7 +46,7 @@
 
 		phy-mode = "mii";
 		interrupt-parent = <&irqpin>;
-		interrupts = <0 0>; /* IRQ0: hwirq 0 on irqpin */
+		interrupts = <0 IRQ_TYPE_NONE>; /* IRQ0: hwirq 0 on irqpin */
 		reg-io-width = <4>;
 		vddvario-supply = <&fixedregulator3v3>;
 		vdd33a-supply = <&fixedregulator3v3>;
diff --git a/arch/arm/boot/dts/r8a7779-marzen-reference.dts b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
index 08b9ee37..0f5c614 100644
--- a/arch/arm/boot/dts/r8a7779-marzen-reference.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
@@ -12,6 +12,7 @@
 /dts-v1/;
 #include "r8a7779.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "marzen";
@@ -43,7 +44,7 @@
 
 		phy-mode = "mii";
 		interrupt-parent = <&irqpin0>;
-		interrupts = <1 0>; /* IRQ1: hwirq 1 on irqpin0 */
+		interrupts = <1 IRQ_TYPE_NONE>; /* IRQ1: hwirq 1 on irqpin0 */
 		reg-io-width = <4>;
 		vddvario-supply = <&fixedregulator3v3>;
 		vdd33a-supply = <&fixedregulator3v3>;
diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index d5a6d74..605f6c6 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -14,6 +14,7 @@
 /dts-v1/;
 #include "sh73a0.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "KZM-A9-GT";
@@ -82,7 +83,7 @@
 		reg = <0x10000000 0x100>;
 		phy-mode = "mii";
 		interrupt-parent = <&irqpin0>;
-		interrupts = <3 0>;	/* active low */
+		interrupts = <3 IRQ_TYPE_NONE>;	/* active low */
 		reg-io-width = <4>;
 		smsc,irq-push-pull;
 		smsc,save-mac-address;
-- 
1.8.1.5
