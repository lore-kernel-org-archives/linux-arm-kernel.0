From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 10 Dec 2013 19:37:22 +0100
Subject: [PATCH RESEND 2/2] ARM: sun6i: dt: Fix interrupt trigger types
In-Reply-To: <1386700642-8302-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1386700642-8302-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1386700642-8302-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner A31 uses the ARM GIC as its internal interrupts controller. The
GIC can work on several interrupt triggers, and the A31 was actually setting it
up to use a rising edge as a trigger, while it was actually a level high
trigger, leading to some interrupts that would be completely ignored if the
edge was missed.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Cc: stable at vger.kernel.org # 3.12+
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index c1751a6..7f5878c 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -193,7 +193,10 @@
 		pio: pinctrl at 01c20800 {
 			compatible = "allwinner,sun6i-a31-pinctrl";
 			reg = <0x01c20800 0x400>;
-			interrupts = <0 11 1>, <0 15 1>, <0 16 1>, <0 17 1>;
+			interrupts = <0 11 4>,
+				     <0 15 4>,
+				     <0 16 4>,
+				     <0 17 4>;
 			clocks = <&apb1_gates 5>;
 			gpio-controller;
 			interrupt-controller;
@@ -212,11 +215,11 @@
 		timer at 01c20c00 {
 			compatible = "allwinner,sun4i-timer";
 			reg = <0x01c20c00 0xa0>;
-			interrupts = <0 18 1>,
-				     <0 19 1>,
-				     <0 20 1>,
-				     <0 21 1>,
-				     <0 22 1>;
+			interrupts = <0 18 4>,
+				     <0 19 4>,
+				     <0 20 4>,
+				     <0 21 4>,
+				     <0 22 4>;
 			clocks = <&osc24M>;
 		};
 
@@ -228,7 +231,7 @@
 		uart0: serial at 01c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
-			interrupts = <0 0 1>;
+			interrupts = <0 0 4>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb2_gates 16>;
@@ -238,7 +241,7 @@
 		uart1: serial at 01c28400 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28400 0x400>;
-			interrupts = <0 1 1>;
+			interrupts = <0 1 4>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb2_gates 17>;
@@ -248,7 +251,7 @@
 		uart2: serial at 01c28800 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28800 0x400>;
-			interrupts = <0 2 1>;
+			interrupts = <0 2 4>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb2_gates 18>;
@@ -258,7 +261,7 @@
 		uart3: serial at 01c28c00 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28c00 0x400>;
-			interrupts = <0 3 1>;
+			interrupts = <0 3 4>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb2_gates 19>;
@@ -268,7 +271,7 @@
 		uart4: serial at 01c29000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c29000 0x400>;
-			interrupts = <0 4 1>;
+			interrupts = <0 4 4>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb2_gates 20>;
@@ -278,7 +281,7 @@
 		uart5: serial at 01c29400 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c29400 0x400>;
-			interrupts = <0 5 1>;
+			interrupts = <0 5 4>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb2_gates 21>;
-- 
1.8.4.2
