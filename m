From: grinberg@compulab.co.il (Igor Grinberg)
Date: Tue,  4 Sep 2012 22:15:49 +0300
Subject: [PATCH] ARM: OMAP: remove unused hwmod function prototypes
In-Reply-To: <y>
References: <y>
Message-ID: <1346786149-9228-1-git-send-email-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Several hwmod function prototypes appear to not have an implementation
because the corresponding functions were removed or renamed.
Those prototypes are unneeded anymore - remove them.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 6132972..a673f45 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -591,9 +591,7 @@ int omap_hwmod_for_each(int (*fn)(struct omap_hwmod *oh, void *data),
 int __init omap_hwmod_setup_one(const char *name);
 
 int omap_hwmod_enable(struct omap_hwmod *oh);
-int _omap_hwmod_enable(struct omap_hwmod *oh);
 int omap_hwmod_idle(struct omap_hwmod *oh);
-int _omap_hwmod_idle(struct omap_hwmod *oh);
 int omap_hwmod_shutdown(struct omap_hwmod *oh);
 
 int omap_hwmod_assert_hardreset(struct omap_hwmod *oh, const char *name);
@@ -626,11 +624,6 @@ int omap_hwmod_add_initiator_dep(struct omap_hwmod *oh,
 int omap_hwmod_del_initiator_dep(struct omap_hwmod *oh,
 				 struct omap_hwmod *init_oh);
 
-int omap_hwmod_set_clockact_both(struct omap_hwmod *oh);
-int omap_hwmod_set_clockact_main(struct omap_hwmod *oh);
-int omap_hwmod_set_clockact_iclk(struct omap_hwmod *oh);
-int omap_hwmod_set_clockact_none(struct omap_hwmod *oh);
-
 int omap_hwmod_enable_wakeup(struct omap_hwmod *oh);
 int omap_hwmod_disable_wakeup(struct omap_hwmod *oh);
 
-- 
1.7.8.6
