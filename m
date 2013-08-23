From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Fri, 23 Aug 2013 19:15:48 -0400
Subject: [RFC PATCH 07/14] arm: dts: add omap4430 thermal data
In-Reply-To: <1377299755-5134-1-git-send-email-eduardo.valentin@ti.com>
References: <1377299755-5134-1-git-send-email-eduardo.valentin@ti.com>
Message-ID: <1377299755-5134-8-git-send-email-eduardo.valentin@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes the dtsi entry on omap4430 to contain
the thermal data. This data will enable the passive
cooling with CPUfreq cooling device at 100C and the
system will do a thermal shutdown at 125C.

Cc: "Beno?t Cousson" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-omap at vger.kernel.org
Cc: devicetree-discuss at lists.ozlabs.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 arch/arm/boot/dts/omap443x.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/omap443x.dtsi b/arch/arm/boot/dts/omap443x.dtsi
index bcf455e..91a3a5d 100644
--- a/arch/arm/boot/dts/omap443x.dtsi
+++ b/arch/arm/boot/dts/omap443x.dtsi
@@ -25,9 +25,14 @@
 		};
 	};
 
+	thermal_zones{
+		#include "omap4-cpu-thermal.dtsi"
+	};
+
 	bandgap {
 		reg = <0x4a002260 0x4
 		       0x4a00232C 0x4>;
 		compatible = "ti,omap4430-bandgap";
+		monitored-zones = <&cpu_thermal 0>;
 	};
 };
-- 
1.8.2.1.342.gfa7285d
