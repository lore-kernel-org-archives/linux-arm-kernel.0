From: coelho@ti.com (Luciano Coelho)
Date: Wed, 31 Jul 2013 00:15:21 +0300
Subject: [PATCH v2 2/4] arm: dts: omap4-panda-common: add WiLink6 device tree
 nodes
In-Reply-To: <1375218923-29876-1-git-send-email-coelho@ti.com>
References: <1375218923-29876-1-git-send-email-coelho@ti.com>
Message-ID: <1375218923-29876-3-git-send-email-coelho@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the WiLink device tree nodes.  On omap4-panda, a WiLink6 module is
connected on MMC5 and a GPIO interrupt is used.  The refclock
frequency is 38.4MHz.

Signed-off-by: Luciano Coelho <coelho@ti.com>
---
 arch/arm/boot/dts/omap4-panda-common.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
index b3f6e1f..59a797d 100644
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -5,6 +5,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include <dt-bindings/interrupt-controller/irq.h>
 #include "elpida_ecb240abacn.dtsi"
 
 / {
@@ -117,6 +118,20 @@
 		startup-delay-us = <70000>;
 		enable-active-high;
 	};
+
+	wlan {
+		compatible = "ti,wilink6";
+		interrupt-parent = <&gpio2>;
+		interrupts = <21 IRQ_TYPE_LEVEL_HIGH>;	/* gpio line 53 */
+		clocks = <&refclock>;
+		clock-names = "refclock";
+
+		refclock: refclock {
+			compatible = "ti,wilink-clock";
+			#clock-cells = <0>;
+			clock-frequency = <38400000>;
+		};
+	 };
 };
 
 &omap4_pmx_wkup {
-- 
1.8.3.2
