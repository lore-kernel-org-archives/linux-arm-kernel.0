From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Tue, 12 Nov 2013 15:46:14 -0400
Subject: [PATCHv5 12/20] arm: dts: add cooling properties on omap4430 cpu node
In-Reply-To: <1384285582-16933-1-git-send-email-eduardo.valentin@ti.com>
References: <1384285582-16933-1-git-send-email-eduardo.valentin@ti.com>
Message-ID: <1384285582-16933-13-git-send-email-eduardo.valentin@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP4430 devices can reach high temperatures and thus
needs to have cpufreq-cooling on systems running on it.

This patch adds the required cooling device properties
so that cpufreq-cpu0 driver loads the cooling device.

Cc: "Beno?t Cousson" <bcousson@baylibre.com>
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
index e9c97d6..930ab47 100644
--- a/arch/arm/boot/dts/omap443x.dtsi
+++ b/arch/arm/boot/dts/omap443x.dtsi
@@ -22,6 +22,11 @@
 				1008000 1375000
 			>;
 			clock-latency = <300000>; /* From legacy driver */
+
+			/* cooling options */
+			cooling-min-level = <0>;
+			cooling-max-level = <3>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 	};
 
-- 
1.8.2.1.342.gfa7285d
