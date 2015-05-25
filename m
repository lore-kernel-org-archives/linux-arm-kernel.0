From: carlo@caione.org (Carlo Caione)
Date: Mon, 25 May 2015 13:00:41 +0200
Subject: [PATCH 2/2] pinctrl: dt-binding: Extend meson documentation with GPIO
 IRQs support
In-Reply-To: <1432551641-3256-1-git-send-email-carlo@caione.org>
References: <1432551641-3256-1-git-send-email-carlo@caione.org>
Message-ID: <1432551641-3256-3-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Beniamino Galvani <b.galvani@gmail.com>

Extend the pinctrl binding documentation with the support for external
GPIO interrupts.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
index 3f6a524..56743eb 100644
--- a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
@@ -3,6 +3,12 @@
 Required properties for the root node:
  - compatible: "amlogic,meson8-pinctrl" or "amlogic,meson8b-pinctrl"
  - reg: address and size of registers controlling irq functionality
+ - reg-names: should be "irq"
+ - interrupt-controller: marks the device node as an interrupt controller
+ - #interrupt-cells: should be 2. The first cell is the GPIO number. The
+		     second cell is used to specify trigger type.
+ - interrupts: specifies the GPIO IRQ numbers on the GIC (GPIO_IRQ#)
+ - interrupt-parent: specifies the parent interrupt controller.
 
 === GPIO sub-nodes ===
 
@@ -46,7 +52,13 @@ pinctrl-bindings.txt
 
 	pinctrl: pinctrl at c1109880 {
 		compatible = "amlogic,meson8-pinctrl";
+		reg-names = "irq";
 		reg = <0xc1109880 0x10>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 64 1>, <0 65 1>, <0 66 1>, <0 67 1>,
+			     <0 68 1>, <0 69 1>, <0 70 1>, <0 71 1>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
-- 
1.9.1
