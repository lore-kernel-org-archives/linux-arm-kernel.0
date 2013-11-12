From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Tue, 12 Nov 2013 15:46:19 -0400
Subject: [PATCHv5 17/20] arm: dts: add cooling properties on omap5 cpu node
In-Reply-To: <1384285582-16933-1-git-send-email-eduardo.valentin@ti.com>
References: <1384285582-16933-1-git-send-email-eduardo.valentin@ti.com>
Message-ID: <1384285582-16933-18-git-send-email-eduardo.valentin@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP5 devices can reach high temperatures and thus
needs to have cpufreq-cooling on systems running on it.

This patch adds the required cooling device properties
so that cpufreq-cpu0 driver loads the cooling device.

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
 arch/arm/boot/dts/omap5.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 187cb71..a35cd61 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -37,6 +37,9 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0x0>;
+
+			/* cooling options */
+			#cooling-cells = <2>; /* min followed by max */
 		};
 		cpu at 1 {
 			device_type = "cpu";
-- 
1.8.2.1.342.gfa7285d
