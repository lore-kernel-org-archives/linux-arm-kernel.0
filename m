From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 31 Jul 2017 17:19:46 +0200
Subject: [PATCH 34/38] ARM: dts: rskrza1: Add SCIF2 pin group
In-Reply-To: <cover.1501514100.git.horms+renesas@verge.net.au>
References: <cover.1501514100.git.horms+renesas@verge.net.au>
Message-ID: <cde2380548e26afe03e4c9310073e0878af9efd9.1501514100.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Brandt <chris.brandt@renesas.com>

Add pin configuration for SCIF2 serial console interface.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r7s72100-rskrza1.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100-rskrza1.dts b/arch/arm/boot/dts/r7s72100-rskrza1.dts
index 72df20a04320..5fac0f82d742 100644
--- a/arch/arm/boot/dts/r7s72100-rskrza1.dts
+++ b/arch/arm/boot/dts/r7s72100-rskrza1.dts
@@ -10,6 +10,7 @@
 
 /dts-v1/;
 #include "r7s72100.dtsi"
+#include <dt-bindings/pinctrl/r7s72100-pinctrl.h>
 
 / {
 	model = "RSKRZA1";
@@ -47,6 +48,15 @@
 	clock-frequency = <32768>;
 };
 
+&pinctrl {
+
+	/* Serial Console */
+	scif2_pins: serial2 {
+		pinmux = <RZA1_PINMUX(3, 0, 6)>,	/* TxD2 */
+			 <RZA1_PINMUX(3, 2, 4)>;	/* RxD2 */
+	};
+};
+
 &mtu2 {
 	status = "okay";
 };
@@ -78,5 +88,7 @@
 };
 
 &scif2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&scif2_pins>;
 	status = "okay";
 };
-- 
2.1.4
