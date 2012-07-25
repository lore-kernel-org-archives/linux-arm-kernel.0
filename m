From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Wed, 25 Jul 2012 14:37:44 +0200
Subject: [PATCH 2/2] ARM: dts: imx6q: Invert the GPIO controller order
In-Reply-To: <1343219864-3040-1-git-send-email-dirk.behme@de.bosch.com>
References: <1343219864-3040-1-git-send-email-dirk.behme@de.bosch.com>
Message-ID: <1343219864-3040-2-git-send-email-dirk.behme@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthias Thomae <matthias.thomae@de.bosch.com>

The GPIO controllers in the device tree are registered dynamically
via gpiochip_add and gpiochip_find_base in descending order (from
ARCH_NR_GPIO to 0). This change reorders the controllers in the
device tree (from gpio7 to gpio1) so that they finally appear in
ascending order after registration.

Signed-off-by: Matthias Thomae <matthias.thomae@de.bosch.com>
CC: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx6q.dtsi |   36 ++++++++++++++++++------------------
 1 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index c25d495..7c908c1 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -276,30 +276,30 @@
 				interrupts = <0 55 0x04>;
 			};
 
-			gpio1: gpio at 0209c000 {
+			gpio7: gpio at 020b4000 {
 				compatible = "fsl,imx6q-gpio", "fsl,imx31-gpio";
-				reg = <0x0209c000 0x4000>;
-				interrupts = <0 66 0x04 0 67 0x04>;
+				reg = <0x020b4000 0x4000>;
+				interrupts = <0 78 0x04 0 79 0x04>;
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 			};
 
-			gpio2: gpio at 020a0000 {
+			gpio6: gpio at 020b0000 {
 				compatible = "fsl,imx6q-gpio", "fsl,imx31-gpio";
-				reg = <0x020a0000 0x4000>;
-				interrupts = <0 68 0x04 0 69 0x04>;
+				reg = <0x020b0000 0x4000>;
+				interrupts = <0 76 0x04 0 77 0x04>;
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 			};
 
-			gpio3: gpio at 020a4000 {
+			gpio5: gpio at 020ac000 {
 				compatible = "fsl,imx6q-gpio", "fsl,imx31-gpio";
-				reg = <0x020a4000 0x4000>;
-				interrupts = <0 70 0x04 0 71 0x04>;
+				reg = <0x020ac000 0x4000>;
+				interrupts = <0 74 0x04 0 75 0x04>;
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
@@ -316,30 +316,30 @@
 				#interrupt-cells = <2>;
 			};
 
-			gpio5: gpio at 020ac000 {
+			gpio3: gpio at 020a4000 {
 				compatible = "fsl,imx6q-gpio", "fsl,imx31-gpio";
-				reg = <0x020ac000 0x4000>;
-				interrupts = <0 74 0x04 0 75 0x04>;
+				reg = <0x020a4000 0x4000>;
+				interrupts = <0 70 0x04 0 71 0x04>;
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 			};
 
-			gpio6: gpio at 020b0000 {
+			gpio2: gpio at 020a0000 {
 				compatible = "fsl,imx6q-gpio", "fsl,imx31-gpio";
-				reg = <0x020b0000 0x4000>;
-				interrupts = <0 76 0x04 0 77 0x04>;
+				reg = <0x020a0000 0x4000>;
+				interrupts = <0 68 0x04 0 69 0x04>;
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 			};
 
-			gpio7: gpio at 020b4000 {
+			gpio1: gpio at 0209c000 {
 				compatible = "fsl,imx6q-gpio", "fsl,imx31-gpio";
-				reg = <0x020b4000 0x4000>;
-				interrupts = <0 78 0x04 0 79 0x04>;
+				reg = <0x0209c000 0x4000>;
+				interrupts = <0 66 0x04 0 67 0x04>;
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
-- 
1.7.0.4
