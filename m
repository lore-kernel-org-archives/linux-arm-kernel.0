From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Fri, 23 Aug 2013 19:15:50 -0400
Subject: [RFC PATCH 09/14] arm: dts: point to cooling-zones on omap4430 cpu
 node
In-Reply-To: <1377299755-5134-1-git-send-email-eduardo.valentin@ti.com>
References: <1377299755-5134-1-git-send-email-eduardo.valentin@ti.com>
Message-ID: <1377299755-5134-10-git-send-email-eduardo.valentin@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP4430 devices can reach high temperatures and thus
needs to have cpufreq-cooling on systems running on it.

This patch links the cpu node to its thermal-zone
so that cpufreq-cpu0 driver loads the cooling device.

Cc: "Beno?t Cousson" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-omap at vger.kernel.org
Cc: devicetree-discuss at lists.ozlabs.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 arch/arm/boot/dts/omap443x.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/omap443x.dtsi b/arch/arm/boot/dts/omap443x.dtsi
index 91a3a5d..e4eea43 100644
--- a/arch/arm/boot/dts/omap443x.dtsi
+++ b/arch/arm/boot/dts/omap443x.dtsi
@@ -22,6 +22,7 @@
 				1008000 1375000
 			>;
 			clock-latency = <300000>; /* From legacy driver */
+			cooling-zones = <&cpu_thermal>;
 		};
 	};
 
-- 
1.8.2.1.342.gfa7285d
