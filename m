From: tony@atomide.com (Tony Lindgren)
Date: Fri, 11 Dec 2009 15:54:16 -0800
Subject: [PATCH 10/14] omap3: id code detection 3525 vs 3515
In-Reply-To: <20091211234919.3189.95607.stgit@localhost>
References: <20091211234919.3189.95607.stgit@localhost>
Message-ID: <20091211235416.3189.72423.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergey Lapin <slapin@ossfans.org>

The runtime detection of OMAP3515 and OMAP3525
was reversed.

Signed-off-by: Sergey Lapin <slapin@ossfans.org>
Signed-off-by: Sanjeev Premi <premi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/id.c              |    4 ++--
 arch/arm/plat-omap/include/plat/cpu.h |    8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 3641ba0..a091b53 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -302,10 +302,10 @@ void __init omap3_cpuinfo(void)
 	} else if (omap3_has_iva() && omap3_has_sgx()) {
 		/* OMAP3430, OMAP3525, OMAP3515, OMAP3503 devices */
 		strcpy(cpu_name, "OMAP3430/3530");
-	} else if (omap3_has_sgx()) {
+	} else if (omap3_has_iva()) {
 		omap_revision = OMAP3525_REV(rev);
 		strcpy(cpu_name, "OMAP3525");
-	} else if (omap3_has_iva()) {
+	} else if (omap3_has_sgx()) {
 		omap_revision = OMAP3515_REV(rev);
 		strcpy(cpu_name, "OMAP3515");
 	} else {
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 9359785..0da076d 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -395,11 +395,11 @@ IS_OMAP_TYPE(3517, 0x3517)
 						(!omap3_has_iva()) &&	\
 						(!omap3_has_sgx()))
 # define cpu_is_omap3515()		(cpu_is_omap3430() &&		\
-						(omap3_has_iva()) &&	\
-						(!omap3_has_sgx()))
+						(!omap3_has_iva()) &&	\
+						(omap3_has_sgx()))
 # define cpu_is_omap3525()		(cpu_is_omap3430() &&		\
-						(omap3_has_sgx()) &&	\
-						(!omap3_has_iva()))
+						(!omap3_has_sgx()) &&	\
+						(omap3_has_iva()))
 # define cpu_is_omap3530()		(cpu_is_omap3430())
 # define cpu_is_omap3505()		is_omap3505()
 # define cpu_is_omap3517()		is_omap3517()
