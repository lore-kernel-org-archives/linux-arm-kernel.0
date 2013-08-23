From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Fri, 23 Aug 2013 19:15:54 -0400
Subject: [RFC PATCH 13/14] arm: dts: add omap5 thermal data
In-Reply-To: <1377299755-5134-1-git-send-email-eduardo.valentin@ti.com>
References: <1377299755-5134-1-git-send-email-eduardo.valentin@ti.com>
Message-ID: <1377299755-5134-14-git-send-email-eduardo.valentin@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes the dtsi entry on omap5 to contain
the thermal data. This data will enable the passive
cooling with CPUfreq cooling device at 100C. The
system will do a thermal shutdown at 125C whenever
any of its sensors sees this level.

Cc: "Beno?t Cousson" <b-cousson@linaro.org>
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
 arch/arm/boot/dts/omap5.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index e643620..4a33fe0 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -45,6 +45,12 @@
 		};
 	};
 
+	thermal_zones {
+		#include "omap4-cpu-thermal.dtsi"
+		#include "omap5-gpu-thermal.dtsi"
+		#include "omap5-core-thermal.dtsi"
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		/* PPI secure/nonsecure IRQ */
@@ -711,6 +717,9 @@
 			       0x4a0023C0 0x3c>;
 			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
 			compatible = "ti,omap5430-bandgap";
+			monitored-zones = <&cpu_thermal 0>,
+					  <&gpu_thermal 1>,
+					  <&core_thermal 2>;
 		};
 	};
 };
-- 
1.8.2.1.342.gfa7285d
