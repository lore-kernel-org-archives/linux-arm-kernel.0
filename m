From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Tue, 12 Nov 2013 15:46:12 -0400
Subject: [PATCHv5 10/20] arm: dts: add omap4430 thermal data
In-Reply-To: <1384285582-16933-1-git-send-email-eduardo.valentin@ti.com>
References: <1384285582-16933-1-git-send-email-eduardo.valentin@ti.com>
Message-ID: <1384285582-16933-11-git-send-email-eduardo.valentin@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes the dtsi entry on omap4430 to contain
the thermal data. This data will enable the passive
cooling with CPUfreq cooling device at 100C and the
system will do a thermal shutdown at 125C.

Cc: "Beno?t Cousson" <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-omap at vger.kernel.org
Cc: devicetree-discuss at lists.ozlabs.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 arch/arm/boot/dts/omap443x.dtsi | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap443x.dtsi b/arch/arm/boot/dts/omap443x.dtsi
index bcf455e..e9c97d6 100644
--- a/arch/arm/boot/dts/omap443x.dtsi
+++ b/arch/arm/boot/dts/omap443x.dtsi
@@ -12,7 +12,7 @@
 
 / {
 	cpus {
-		cpu at 0 {
+		cpu0: cpu at 0 {
 			/* OMAP443x variants OPP50-OPPNT */
 			operating-points = <
 				/* kHz    uV */
@@ -25,9 +25,15 @@
 		};
 	};
 
-	bandgap {
+	thermal-zones{
+		#include "omap4-cpu-thermal.dtsi"
+	};
+
+	bandgap: bandgap {
 		reg = <0x4a002260 0x4
 		       0x4a00232C 0x4>;
 		compatible = "ti,omap4430-bandgap";
+
+		#thermal-sensor-cells = <0>;
 	};
 };
-- 
1.8.2.1.342.gfa7285d
