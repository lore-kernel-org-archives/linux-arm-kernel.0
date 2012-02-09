From: b-cousson@ti.com (Cousson, Benoit)
Date: Thu, 9 Feb 2012 20:01:09 +0100
Subject: [PATCH] ARM: OMAP2+: Fix prm2xxx_3xxx.c INT_34XX_PRCM_MPU_IRQ build
 error
Message-ID: <4F3417F5.2090901@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If CONFIG_OF is not defined, the following error will happen.

arch/arm/mach-omap2/prm2xxx_3xxx.c:41:11: error:
 ?INT_34XX_PRCM_MPU_IRQ? undeclared here (not in a function)

This is due to some hidden headers path from linux/of.h to plat/irqs.h
already reported by Russell for prm4xxx.c.

Add the #include <plat/irqs.h> in prm2xxx_3xxx.c to avoid depending
of that hidden dependency that should probably not exist in theory.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/prm2xxx_3xxx.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index c1c4d86..09e2916 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -18,6 +18,7 @@
 
 #include "common.h"
 #include <plat/cpu.h>
+#include <plat/irqs.h>
 #include <plat/prcm.h>
 
 #include "vp.h"
-- 
1.7.5.4
