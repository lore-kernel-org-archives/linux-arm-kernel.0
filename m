From: sean.nyekjaer@prevas.dk (Sean Nyekjaer)
Date: Sun, 25 Jun 2017 21:20:05 +0200
Subject: [PATCH] arm64: dts: marvell: Add microsd card definition for the
 ESPRESSObin
Message-ID: <20170625192005.23867-1-sean.nyekjaer@prevas.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Nyekjaer <sean@nyekjaer.dk>

This defines and enables the microsd card on the
Marvell ESPRESSObin board.

Signed-off-by: Sean Nyekjaer <sean@nyekjaer.dk>
---
 arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
index e3a136ed77b0..2dadd77e08eb 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
@@ -45,6 +45,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
 #include "armada-372x.dtsi"
 
 / {
@@ -76,6 +77,16 @@
 	status = "okay";
 };
 
+/* microsd slot */
+&sdhci1 {
+	wp-inverted;
+	bus-width = <4>;
+	cd-gpios = <&gpionb 3 GPIO_ACTIVE_LOW>;
+	no-1-8-v;
+	marvell,pad-type = "sd";
+	status = "okay";
+};
+
 /* J7 */
 &usb3 {
 	status = "okay";
-- 
2.13.1
