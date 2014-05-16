From: nm@ti.com (Nishanth Menon)
Date: Fri, 16 May 2014 17:36:09 -0500
Subject: [PATCH] ARM: DRA7/AM43XX: fix header definition for omap44xx_restart
Message-ID: <1400279769-28704-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

omap44xx_restart is defined as a static void inline when DRA7/AM437X is
defined alone, which implies that the restart function is no longer
functional even though it is built in. So, fix the definition of the
same.

Unfortunately, the number of SoCs starting to use omap44xx_restart is
starting to grow and the definition looks a little ugly.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

based on v3.15-rc5

NOTE: this generates over 80 characters checkpatch warning.. I am not
sure other than introducing a definition for restart it could be simplified.

 arch/arm/mach-omap2/common.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index d88aff7..46150f4 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -154,7 +154,7 @@ static inline void omap3xxx_restart(enum reboot_mode mode, const char *cmd)
 }
 #endif
 
-#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5)
+#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || defined(CONFIG_SOC_DRA7XX) || defined(CONFIG_SOC_AM43XX)
 void omap44xx_restart(enum reboot_mode mode, const char *cmd);
 #else
 static inline void omap44xx_restart(enum reboot_mode mode, const char *cmd)
-- 
1.7.9.5
