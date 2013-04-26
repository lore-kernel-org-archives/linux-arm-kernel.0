From: nm@ti.com (Nishanth Menon)
Date: Fri, 26 Apr 2013 12:39:33 -0500
Subject: [PATCH 2/2] ARM: dts: OMAP4460: Fix CPU OPP voltages
In-Reply-To: <1366997973-19120-1-git-send-email-nm@ti.com>
References: <1366997973-19120-1-git-send-email-nm@ti.com>
Message-ID: <1366997973-19120-3-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit d16fb25 (ARM: dts: OMAP4460: Add CPU OPP table)
introduced wrong OPP voltages per OPP by mistake. Sync the OPP
tables with existing OMAP4460 OPP data in
arch/arm/mach-omap2/opp4xxx_data.c

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/omap4460.dtsi |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/omap4460.dtsi b/arch/arm/boot/dts/omap4460.dtsi
index 7c2c23c..2cf227c 100644
--- a/arch/arm/boot/dts/omap4460.dtsi
+++ b/arch/arm/boot/dts/omap4460.dtsi
@@ -15,9 +15,9 @@
 		cpu at 0 {
 			operating-points = <
 				/* kHz    uV */
-				350000   975000
-				700000  1075000
-				920000  1200000
+				350000  1025000
+				700000  1200000
+				920000  1313000
 			>;
 			clock-latency = <300000>; /* From legacy driver */
 		};
-- 
1.7.9.5
