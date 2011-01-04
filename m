From: nm@ti.com (Nishanth Menon)
Date: Tue,  4 Jan 2011 14:07:14 -0600
Subject: [PATCH 5/5] omap2+: pm_bus: make functions used as pointers as static
In-Reply-To: <1294171634-13943-1-git-send-email-nm@ti.com>
References: <1294171634-13943-1-git-send-email-nm@ti.com>
Message-ID: <1294171634-13943-6-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

omap_pm_runtime_suspend and omap_pm_runtime_resume are used
as function pointers and does not really need to be exposed
to the world.

Fixes sparse warnings:
arch/arm/mach-omap2/pm_bus.c:23:5: warning: symbol 'omap_pm_runtime_suspend' was not declared. Should it be static?
arch/arm/mach-omap2/pm_bus.c:40:5: warning: symbol 'omap_pm_runtime_resume' was not declared. Should it be static?

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/pm_bus.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm_bus.c b/arch/arm/mach-omap2/pm_bus.c
index 784989f..5acd2ab 100644
--- a/arch/arm/mach-omap2/pm_bus.c
+++ b/arch/arm/mach-omap2/pm_bus.c
@@ -20,7 +20,7 @@
 #include <plat/omap-pm.h>
 
 #ifdef CONFIG_PM_RUNTIME
-int omap_pm_runtime_suspend(struct device *dev)
+static int omap_pm_runtime_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	int r, ret = 0;
@@ -37,7 +37,7 @@ int omap_pm_runtime_suspend(struct device *dev)
 	return ret;
 };
 
-int omap_pm_runtime_resume(struct device *dev)
+static int omap_pm_runtime_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	int r;
-- 
1.6.3.3
