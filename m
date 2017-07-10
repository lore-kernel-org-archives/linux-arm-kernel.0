From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Mon, 10 Jul 2017 16:14:48 -0500
Subject: [PATCH] PM / Domains: Fix compilation error for devices that don't
 enable PM_SLEEP
Message-ID: <20170710211448.11046-1-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set pm_genpd_poweroff_noirq to NULL if CONFIG_PM_SLEEP isn't enabled.
This is the same approach done for other PM_SLEEP related functions.

Without this patch building the kernel with the keystone_defconfig
results in a compilation error.

Fixes: 10da65423fdb ("PM / Domains: Call driver's noirq callbacks")

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 drivers/base/power/domain.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 9649dce..c140a9d5 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1182,6 +1182,7 @@ EXPORT_SYMBOL_GPL(pm_genpd_syscore_poweron);
 #define pm_genpd_thaw_noirq		NULL
 #define pm_genpd_restore_noirq		NULL
 #define pm_genpd_complete		NULL
+#define pm_genpd_poweroff_noirq		NULL
 
 #endif /* CONFIG_PM_SLEEP */
 
-- 
2.10.0
