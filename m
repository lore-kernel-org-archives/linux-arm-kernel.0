From: siccegge@cs.fau.de (Christoph Egger)
Date: Wed, 30 Jun 2010 18:01:56 +0200
Subject: [PATCH 25/33] Removing dead CORGI_SSP_DEPRECATED
In-Reply-To: <cover.1277911345.git.siccegge@cs.fau.de>
References: <cover.1277911345.git.siccegge@cs.fau.de>
Message-ID: <80c10751fb5b7d9be55656ac35827a403a5d6b2b.1277911346.git.siccegge@cs.fau.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CORGI_SSP_DEPRECATED doesn't exist in Kconfig, therefore removing all
references for it from the source code.

Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
---
 arch/arm/mach-pxa/sharpsl_pm.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-pxa/sharpsl_pm.c b/arch/arm/mach-pxa/sharpsl_pm.c
index 582701e..d8c5301 100644
--- a/arch/arm/mach-pxa/sharpsl_pm.c
+++ b/arch/arm/mach-pxa/sharpsl_pm.c
@@ -180,17 +180,12 @@ int sharpsl_pm_pxa_read_max1111(int channel)
 	if (machine_is_tosa())
 	    return 0;
 
-#ifdef CONFIG_CORGI_SSP_DEPRECATED
-	return corgi_ssp_max1111_get((channel << MAXCTRL_SEL_SH) | MAXCTRL_PD0 | MAXCTRL_PD1
-			| MAXCTRL_SGL | MAXCTRL_UNI | MAXCTRL_STR);
-#else
 	extern int max1111_read_channel(int);
 
 	/* max1111 accepts channels from 0-3, however,
 	 * it is encoded from 0-7 here in the code.
 	 */
 	return max1111_read_channel(channel >> 1);
-#endif
 }
 
 static int get_percentage(int voltage)
-- 
1.7.0.4
