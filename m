From: balbi@ti.com (Felipe Balbi)
Date: Sun, 16 Jan 2011 12:46:23 +0200
Subject: [PATCH 2/2] arm: omap: remove duplicated headers
In-Reply-To: <1295174783-4099-1-git-send-email-balbi@ti.com>
References: <1295174783-4099-1-git-send-email-balbi@ti.com>
Message-ID: <1295174783-4099-2-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A few headers are included twice, remove them.

Found the following errors using make includecheck:
arch/arm/mach-omap2/clock44xx_data.c: prm44xx.h is
included more than once.
arch/arm/mach-omap2/clockdomains44xx_data.c: cm1_44xx.h
is included more than once.
arch/arm/mach-omap2/clockdomains44xx_data.c: cm2_44xx.h
is included more than once.
arch/arm/mach-omap2/powerdomain2xxx_3xxx.c: prm-regbits-34xx.h
is included more than once.

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-omap at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c        |    1 -
 arch/arm/mach-omap2/clockdomains44xx_data.c |    2 --
 arch/arm/mach-omap2/powerdomain2xxx_3xxx.c  |    1 -
 3 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index e8cb32f..de9ec8d 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -34,7 +34,6 @@
 #include "cm2_44xx.h"
 #include "cm-regbits-44xx.h"
 #include "prm44xx.h"
-#include "prm44xx.h"
 #include "prm-regbits-44xx.h"
 #include "control.h"
 #include "scrm44xx.h"
diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c b/arch/arm/mach-omap2/clockdomains44xx_data.c
index 51920fc..10622c9 100644
--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -30,8 +30,6 @@
 #include "cm1_44xx.h"
 #include "cm2_44xx.h"
 
-#include "cm1_44xx.h"
-#include "cm2_44xx.h"
 #include "cm-regbits-44xx.h"
 #include "prm44xx.h"
 #include "prcm44xx.h"
diff --git a/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c b/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
index d523389..cf600e2 100644
--- a/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
@@ -19,7 +19,6 @@
 #include <plat/prcm.h>
 
 #include "powerdomain.h"
-#include "prm-regbits-34xx.h"
 #include "prm.h"
 #include "prm-regbits-24xx.h"
 #include "prm-regbits-34xx.h"
-- 
1.7.3.4.598.g85356
