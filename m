From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 27 Sep 2016 12:37:15 +0200
Subject: [PATCH] ARM: at91: pm: remove useless extern definition
Message-ID: <20160927103715.26785-1-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

at91_ramc_base is local to pm.c, remove its definition in pm.h

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/pm.c | 2 +-
 arch/arm/mach-at91/pm.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index b4332b727e9c..3d89b7905bd9 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -55,7 +55,7 @@ static struct {
 	int memctrl;
 } at91_pm_data;
 
-void __iomem *at91_ramc_base[2];
+static void __iomem *at91_ramc_base[2];
 
 static int at91_pm_valid_state(suspend_state_t state)
 {
diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
index 3fcf8810f14e..bf980c6ef294 100644
--- a/arch/arm/mach-at91/pm.h
+++ b/arch/arm/mach-at91/pm.h
@@ -18,8 +18,6 @@
 #include <soc/at91/at91sam9_sdramc.h>
 
 #ifndef __ASSEMBLY__
-extern void __iomem *at91_ramc_base[];
-
 #define at91_ramc_read(id, field) \
 	__raw_readl(at91_ramc_base[id] + field)
 
-- 
2.9.3
