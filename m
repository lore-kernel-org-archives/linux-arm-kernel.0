From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 31 Mar 2014 18:15:57 +0300
Subject: [PATCH 18/55] ARM: OMAP4: PRM: remove references to
 prm-regbits-44xx.h from PRM core code
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Message-ID: <1396278994-12624-19-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Done in preparation to make PRM a standalone driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/prm44xx.c     |   33 ++++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/prminst44xx.c |    3 ++-
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 27f4603..5033cd3 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -23,11 +23,42 @@
 #include "prm44xx.h"
 #include "prm54xx.h"
 #include "prm7xx.h"
-#include "prm-regbits-44xx.h"
 #include "prcm44xx.h"
 #include "prminst44xx_private.h"
 #include "powerdomain.h"
 
+#define OMAP4430_GLOBAL_COLD_RST_SHIFT			0
+#define OMAP4430_GLOBAL_WARM_SW_RST_SHIFT		1
+#define OMAP4430_MPU_SECURITY_VIOL_RST_SHIFT		2
+#define OMAP4430_MPU_WDT_RST_SHIFT			3
+#define OMAP4430_SECURE_WDT_RST_SHIFT			4
+#define OMAP4430_EXTERNAL_WARM_RST_SHIFT		5
+#define OMAP4430_VDD_MPU_VOLT_MGR_RST_SHIFT		6
+#define OMAP4430_VDD_IVA_VOLT_MGR_RST_SHIFT		7
+#define OMAP4430_VDD_CORE_VOLT_MGR_RST_SHIFT		8
+#define OMAP4430_ICEPICK_RST_SHIFT			9
+#define OMAP4430_C2C_RST_SHIFT				10
+
+#define OMAP4430_GLOBAL_WUEN_MASK			(1 << 16)
+
+#define OMAP4430_LASTPOWERSTATEENTERED_SHIFT		24
+#define OMAP4430_LASTPOWERSTATEENTERED_MASK		(0x3 << 24)
+#define OMAP4430_LOWPOWERSTATECHANGE_SHIFT		4
+#define OMAP4430_LOWPOWERSTATECHANGE_MASK		(1 << 4)
+
+#define OMAP4430_LOGICRETSTATE_SHIFT			2
+#define OMAP4430_LOGICRETSTATE_MASK			(1 << 2)
+#define OMAP4430_LOGICSTATEST_SHIFT			2
+#define OMAP4430_LOGICSTATEST_MASK			(1 << 2)
+
+#define OMAP4430_VP_CORE_TRANXDONE_ST_MASK		(1 << 21)
+#define OMAP4430_VP_IVA_TRANXDONE_ST_MASK		(1 << 29)
+#define OMAP4430_VP_MPU_TRANXDONE_ST_MASK		(1 << 5)
+
+#define OMAP4430_WUCLK_CTRL_MASK			(1 << 8)
+#define OMAP4430_WUCLK_STATUS_SHIFT			9
+#define OMAP4430_WUCLK_STATUS_MASK			(1 << 9)
+
 /* Static data */
 
 #define OMAP44XX_IRQ_GIC_START	32
diff --git a/arch/arm/mach-omap2/prminst44xx.c b/arch/arm/mach-omap2/prminst44xx.c
index bd0e0da..74349e1 100644
--- a/arch/arm/mach-omap2/prminst44xx.c
+++ b/arch/arm/mach-omap2/prminst44xx.c
@@ -21,10 +21,11 @@
 #include "prm54xx.h"
 #include "prm7xx.h"
 #include "prminst44xx.h"
-#include "prm-regbits-44xx.h"
 #include "prcm44xx.h"
 #include "prcm_mpu44xx.h"
 
+#define OMAP4430_RST_GLOBAL_WARM_SW_MASK		(1 << 0)
+
 static void __iomem *_prm_bases[OMAP4_MAX_PRCM_PARTITIONS];
 
 /**
-- 
1.7.9.5
