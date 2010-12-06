From: marek.belisko@open-nandra.com (Marek Belisko)
Date: Mon,  6 Dec 2010 14:23:48 +0100
Subject: [PATCH] omap1: pm_bus: Fix compilation warning.
Message-ID: <1291641828-19909-1-git-send-email-marek.belisko@open-nandra.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix following compilation warning:
arch/arm/mach-omap1/pm_bus.c: In function 'omap1_pm_runtime_resume':
arch/arm/mach-omap1/pm_bus.c:51: warning: unused variable 'ret'

Signed-off-by: Marek Belisko <marek.belisko@open-nandra.com>
---
 arch/arm/mach-omap1/pm_bus.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/pm_bus.c b/arch/arm/mach-omap1/pm_bus.c
index 8b66392..f97c6e9 100644
--- a/arch/arm/mach-omap1/pm_bus.c
+++ b/arch/arm/mach-omap1/pm_bus.c
@@ -48,7 +48,6 @@ static int omap1_pm_runtime_suspend(struct device *dev)
 
 static int omap1_pm_runtime_resume(struct device *dev)
 {
-	int ret = 0;
 	struct clk *iclk, *fclk;
 
 	dev_dbg(dev, "%s\n", __func__);
-- 
1.7.1
