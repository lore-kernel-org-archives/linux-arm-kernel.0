From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 9 Jul 2013 13:02:17 +0530
Subject: [PATCH 10/12] ARM: DRA7: Enable PM framework initializations
In-Reply-To: <1373355139-12487-1-git-send-email-rnayak@ti.com>
References: <1373355139-12487-1-git-send-email-rnayak@ti.com>
Message-ID: <1373355139-12487-11-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ambresh K <ambresh@ti.com>

Initialise powerdomains, clockdomains, and hwmod frameworks.

Signed-off-by: Ambresh K <ambresh@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/io.c      |    5 +++++
 arch/arm/mach-omap2/prm44xx.c |    2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 542e6bd..09115e7 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -667,6 +667,11 @@ void __init dra7xx_init_early(void)
 	omap_prm_base_init();
 	omap_cm_base_init();
 	dra7xx_check_revision();
+	omap44xx_prm_init();
+	dra7xx_powerdomains_init();
+	dra7xx_clockdomains_init();
+	dra7xx_hwmod_init();
+	omap_hwmod_init_postsetup();
 }
 #endif
 
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 15271b6..03a6034 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -660,7 +660,7 @@ static struct prm_ll_data omap44xx_prm_ll_data = {
 
 int __init omap44xx_prm_init(void)
 {
-	if (!cpu_is_omap44xx() && !soc_is_omap54xx())
+	if (!cpu_is_omap44xx() && !soc_is_omap54xx() && !soc_is_dra7xx())
 		return 0;
 
 	return prm_register(&omap44xx_prm_ll_data);
-- 
1.7.9.5
