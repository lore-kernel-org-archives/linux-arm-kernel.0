From: nm@ti.com (Nishanth Menon)
Date: Fri, 26 Apr 2013 12:39:32 -0500
Subject: [PATCH 1/2] ARM: dts: OMAP36xx: Fix CPU OPP voltages
In-Reply-To: <1366997973-19120-1-git-send-email-nm@ti.com>
References: <1366997973-19120-1-git-send-email-nm@ti.com>
Message-ID: <1366997973-19120-2-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 3027e26 (ARM: dts: OMAP36xx: Add CPU OPP table)
introduced wrong OPP voltages per OPP by mistake. Sync the OPP
tables with existing OMAP36xx OPP data in
arch/arm/mach-omap2/opp3xxx_data.c

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/omap36xx.dtsi |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
index b89233e..f3447bc 100644
--- a/arch/arm/boot/dts/omap36xx.dtsi
+++ b/arch/arm/boot/dts/omap36xx.dtsi
@@ -20,9 +20,9 @@
 		cpu at 0 {
 			operating-points = <
 				/* kHz    uV */
-				300000   975000
-				600000  1075000
-				800000  1200000
+				300000  1012500
+				600000  1200000
+				800000  1325000
 			>;
 			clock-latency = <300000>; /* From legacy driver */
 		};
-- 
1.7.9.5
