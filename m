From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Wed, 17 Jul 2013 11:02:44 -0400
Subject: [PATCH 4/9] arm: dts: flag omap4430 with needs-cooling for cpu node
In-Reply-To: <1374073374-30946-1-git-send-email-eduardo.valentin@ti.com>
References: <1374073374-30946-1-git-send-email-eduardo.valentin@ti.com>
Message-ID: <1374073374-30946-9-git-send-email-eduardo.valentin@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP4430 devices can reach high temperatures and thus
needs to have cpufreq-cooling on systems running on it.

This patch adds the flag so that cpufreq-cpu0 driver
loads the cooling device to use cpufreq on OMAP4430.

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
index bcf455e..4a4dcc3 100644
--- a/arch/arm/boot/dts/omap443x.dtsi
+++ b/arch/arm/boot/dts/omap443x.dtsi
@@ -22,6 +22,7 @@
 				1008000 1375000
 			>;
 			clock-latency = <300000>; /* From legacy driver */
+			needs-cooling; /* make sure we have cpufreq-cooling */
 		};
 	};
 
-- 
1.8.2.1.342.gfa7285d
