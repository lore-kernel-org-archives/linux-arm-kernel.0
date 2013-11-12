From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Tue, 12 Nov 2013 15:46:20 -0400
Subject: [PATCHv5 18/20] arm: dts: make OMAP443x bandgap node to belong to OCP
In-Reply-To: <1384285582-16933-1-git-send-email-eduardo.valentin@ti.com>
References: <1384285582-16933-1-git-send-email-eduardo.valentin@ti.com>
Message-ID: <1384285582-16933-19-git-send-email-eduardo.valentin@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Small fix on representation. Bandgap node belongs to OCP.

Cc: "Beno?t Cousson" <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-omap at vger.kernel.org
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Suggested-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 arch/arm/boot/dts/omap443x.dtsi | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/omap443x.dtsi b/arch/arm/boot/dts/omap443x.dtsi
index 930ab47..2fca4e5 100644
--- a/arch/arm/boot/dts/omap443x.dtsi
+++ b/arch/arm/boot/dts/omap443x.dtsi
@@ -34,11 +34,13 @@
 		#include "omap4-cpu-thermal.dtsi"
 	};
 
-	bandgap: bandgap {
-		reg = <0x4a002260 0x4
-		       0x4a00232C 0x4>;
-		compatible = "ti,omap4430-bandgap";
+	ocp {
+		bandgap: bandgap {
+			reg = <0x4a002260 0x4
+			       0x4a00232C 0x4>;
+			compatible = "ti,omap4430-bandgap";
 
-		#thermal-sensor-cells = <0>;
+			#thermal-sensor-cells = <0>;
+		};
 	};
 };
-- 
1.8.2.1.342.gfa7285d
