From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 14 Jul 2014 17:54:22 +0200
Subject: [PATCH v2 5/6] dts: add devicetree bindings for pxa27x clocks
In-Reply-To: <1405353263-13424-1-git-send-email-robert.jarzmik@free.fr>
References: <1405353263-13424-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1405353263-13424-6-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the clock tree description for the PXA27x based boards.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/boot/dts/pxa27x.dtsi | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index a705469..80fc5d7 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -1,5 +1,6 @@
 /* The pxa3xx skeleton simply augments the 2xx version */
-/include/ "pxa2xx.dtsi"
+#include "pxa2xx.dtsi"
+#include "dt-bindings/clock/pxa2xx-clock.h"
 
 / {
 	model = "Marvell PXA27x familiy SoC";
@@ -35,4 +36,21 @@
 			#pwm-cells = <1>;
 		};
 	};
+
+	clocks {
+	       /*
+		* The muxing of external clocks/internal dividers for osc* clock
+		* sources has been hidden under the carpet by now.
+		*/
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		pxa2xx_clks: pxa2xx_clks at 41300004 {
+			compatible = "marvell,pxa-clocks";
+			#clock-cells = <1>;
+			status = "okay";
+		};
+	};
+
 };
-- 
2.0.0.rc2
