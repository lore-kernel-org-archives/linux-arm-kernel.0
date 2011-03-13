From: nm@ti.com (Nishanth Menon)
Date: Sun, 13 Mar 2011 09:07:23 +0530
Subject: [PATCH] OMAP4: PM: remove redundant #ifdef CONFIG_PM
Message-ID: <1299987443-27275-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pm44xx.c is built only when CONFIG_PM is setup,
remove redundant CONFIG_PM check.

This also fixes:
https://bugzilla.kernel.org/show_bug.cgi?id=25022

Reported-by: Martin Etti <ettl.martin@gmx.de>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/pm44xx.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 76cfff2..59a870b 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -105,13 +105,11 @@ static int __init omap4_pm_init(void)
 
 	pr_err("Power Management for TI OMAP4.\n");
 
-#ifdef CONFIG_PM
 	ret = pwrdm_for_each(pwrdms_setup, NULL);
 	if (ret) {
 		pr_err("Failed to setup powerdomains\n");
 		goto err2;
 	}
-#endif
 
 #ifdef CONFIG_SUSPEND
 	suspend_set_ops(&omap_pm_ops);
-- 
1.7.1
