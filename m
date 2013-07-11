From: afzal@ti.com (Afzal Mohammed)
Date: Thu, 11 Jul 2013 12:06:45 +0530
Subject: [PATCH RFC 11/13] ARM: OMAP2+: AM43x PRCM init
In-Reply-To: <cover.1373519192.git.afzal@ti.com>
References: <cover.1373519192.git.afzal@ti.com>
Message-ID: <32c6a6fba13448a4a08981a017c7c4c953ab0fa4.1373519192.git.afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ambresh K <ambresh@ti.com>

Initialise AM43x HWMOD, powerdomains and clockdomains.

Signed-off-by: Ambresh K <ambresh@ti.com>
Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/io.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 7325ba6..901acf6 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -594,8 +594,14 @@ void __init am43xx_init_early(void)
 				  NULL);
 	omap2_set_globals_prm(AM33XX_L4_WK_IO_ADDRESS(AM43XX_PRCM_BASE));
 	omap2_set_globals_cm(AM33XX_L4_WK_IO_ADDRESS(AM43XX_PRCM_BASE), NULL);
+	omap_prm_base_init();
+	omap_cm_base_init();
 	omap3xxx_check_revision();
 	am33xx_check_features();
+	am43xx_powerdomains_init();
+	am43xx_clockdomains_init();
+	am33xx_hwmod_init();
+	omap_hwmod_init_postsetup();
 }
 #endif
 
-- 
1.8.3.1
