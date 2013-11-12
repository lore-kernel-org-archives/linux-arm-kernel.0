From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Tue, 12 Nov 2013 15:46:13 -0400
Subject: [PATCHv5 11/20] arm: dts: add omap4460 thermal data
In-Reply-To: <1384285582-16933-1-git-send-email-eduardo.valentin@ti.com>
References: <1384285582-16933-1-git-send-email-eduardo.valentin@ti.com>
Message-ID: <1384285582-16933-12-git-send-email-eduardo.valentin@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes the dtsi entry on omap4460 to contain
the thermal data. This data will enable the passive
cooling with CPUfreq cooling device at 100C and the
system will do a thermal shutdown at 125C.

Cc: "Beno?t Cousson" <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ian.campbell@citrix.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-omap at vger.kernel.org
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 arch/arm/boot/dts/omap4460.dtsi | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap4460.dtsi b/arch/arm/boot/dts/omap4460.dtsi
index c2f0f39..4d93aba 100644
--- a/arch/arm/boot/dts/omap4460.dtsi
+++ b/arch/arm/boot/dts/omap4460.dtsi
@@ -12,7 +12,7 @@
 / {
 	cpus {
 		/* OMAP446x 'standard device' variants OPP50 to OPPTurbo */
-		cpu at 0 {
+		cpu0: cpu at 0 {
 			operating-points = <
 				/* kHz    uV */
 				350000  1025000
@@ -30,12 +30,18 @@
 		ti,hwmods = "debugss";
 	};
 
-	bandgap {
+	thermal-zones{
+		#include "omap4-cpu-thermal.dtsi"
+	};
+
+	bandgap: bandgap {
 		reg = <0x4a002260 0x4
 		       0x4a00232C 0x4
 		       0x4a002378 0x18>;
 		compatible = "ti,omap4460-bandgap";
 		interrupts = <0 126 IRQ_TYPE_LEVEL_HIGH>; /* talert */
 		gpios = <&gpio3 22 0>; /* tshut */
+
+		#thermal-sensor-cells = <0>;
 	};
 };
-- 
1.8.2.1.342.gfa7285d
