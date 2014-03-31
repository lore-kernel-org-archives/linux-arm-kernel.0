From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 31 Mar 2014 18:15:55 +0300
Subject: [PATCH 16/55] ARM: OMAP2: PRM: remove references to
 prm-regbits-24xx.h from PRM core code
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Message-ID: <1396278994-12624-17-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Done in preparation to make PRM a standalone driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/prm2xxx.c      |   16 +++++++++++++++-
 arch/arm/mach-omap2/prm2xxx_3xxx.c |    1 -
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/prm2xxx.c b/arch/arm/mach-omap2/prm2xxx.c
index a7f1cac..7264ae6 100644
--- a/arch/arm/mach-omap2/prm2xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx.c
@@ -20,9 +20,23 @@
 
 #include "powerdomain.h"
 #include "clockdomain.h"
+#include "prm2xxx.h"
 #include "prm2xxx_3xxx_private.h"
 #include "cm2xxx_3xxx.h"
-#include "prm-regbits-24xx.h"
+
+#define OMAP24XX_FORCESTATE_MASK		(1 << 18)
+#define OMAP24XX_AUTOIDLE_MASK			(1 << 0)
+#define OMAP24XX_AUTO_EXTVOLT_MASK		(1 << 15)
+
+#define OMAP24XX_SETOFF_LEVEL_SHIFT		12
+#define OMAP24XX_MEMRETCTRL_MASK		(1 << 8)
+#define OMAP24XX_SETRET_LEVEL_SHIFT		6
+#define OMAP24XX_VOLT_LEVEL_SHIFT		0
+
+#define OMAP24XX_EXTWMPU_RST_SHIFT		6
+#define OMAP24XX_SECU_WD_RST_SHIFT		5
+#define OMAP24XX_MPU_WD_RST_SHIFT		4
+#define OMAP24XX_SECU_VIOL_RST_SHIFT		3
 
 /*
  * OMAP24xx PM_PWSTCTRL_*.POWERSTATE and PM_PWSTST_*.LASTSTATEENTERED bits -
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index d891499..d8044f9 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -18,7 +18,6 @@
 
 #include "powerdomain.h"
 #include "prm2xxx_3xxx_private.h"
-#include "prm-regbits-24xx.h"
 #include "clockdomain.h"
 
 /**
-- 
1.7.9.5
