From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 31 Mar 2014 18:15:52 +0300
Subject: [PATCH 13/55] ARM: OMAP4: PRCM: remove references to
 cm-regbits-44xx.h from PRCM core files
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Message-ID: <1396278994-12624-14-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Done in preparation to make PRCM a standalone driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm44xx.c             |    1 -
 arch/arm/mach-omap2/cminst44xx.c         |    8 +++++++-
 arch/arm/mach-omap2/powerdomain-common.c |    1 -
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/cm44xx.c b/arch/arm/mach-omap2/cm44xx.c
index 37ba6e8..c440ba7 100644
--- a/arch/arm/mach-omap2/cm44xx.c
+++ b/arch/arm/mach-omap2/cm44xx.c
@@ -21,7 +21,6 @@
 #include "cm.h"
 #include "cm1_44xx.h"
 #include "cm2_44xx.h"
-#include "cm-regbits-44xx.h"
 
 /* CM1 hardware module low-level functions */
 
diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index d27d2bd..c2712d3 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -28,12 +28,18 @@
 #include "cm44xx.h"
 #include "cminst44xx.h"
 #include "cm-regbits-34xx.h"
-#include "cm-regbits-44xx.h"
 #include "prcm44xx.h"
 #include "prm44xx.h"
 #include "prcm_mpu44xx.h"
 #include "prcm-common.h"
 
+#define OMAP4430_IDLEST_SHIFT		16
+#define OMAP4430_IDLEST_MASK		(0x3 << 16)
+#define OMAP4430_CLKTRCTRL_SHIFT	0
+#define OMAP4430_CLKTRCTRL_MASK		(0x3 << 0)
+#define OMAP4430_MODULEMODE_SHIFT	0
+#define OMAP4430_MODULEMODE_MASK	(0x3 << 0)
+
 /*
  * CLKCTRL_IDLEST_*: possible values for the CM_*_CLKCTRL.IDLEST bitfield:
  *
diff --git a/arch/arm/mach-omap2/powerdomain-common.c b/arch/arm/mach-omap2/powerdomain-common.c
index c0aeabf..c40e5f0 100644
--- a/arch/arm/mach-omap2/powerdomain-common.c
+++ b/arch/arm/mach-omap2/powerdomain-common.c
@@ -17,7 +17,6 @@
 #include "pm.h"
 #include "cm.h"
 #include "cm-regbits-34xx.h"
-#include "cm-regbits-44xx.h"
 #include "prm-regbits-34xx.h"
 #include "prm-regbits-44xx.h"
 
-- 
1.7.9.5
