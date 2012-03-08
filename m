From: tony@atomide.com (Tony Lindgren)
Date: Thu, 8 Mar 2012 10:49:23 -0800
Subject: [PATCH] ARM: OMAP2+: Fix build for omap4 only builds with missing
 include of linux/bug.h
Message-ID: <20120308184923.GV12083@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Found few more with randconfig generated .configs:

In file included from arch/arm/mach-omap2/prm-regbits-34xx.h:17,
                 from arch/arm/mach-omap2/vc.c:18:
arch/arm/mach-omap2/prm2xxx_3xxx.h: In function ?omap2_prm_read_mod_reg?:
arch/arm/mach-omap2/prm2xxx_3xxx.h:239: error: implicit declaration of function ?WARN?

In file included from arch/arm/mach-omap2/powerdomain44xx.c:22:
arch/arm/mach-omap2/prm2xxx_3xxx.h: In function ?omap2_prm_read_mod_reg?:
arch/arm/mach-omap2/prm2xxx_3xxx.h:239: error: implicit declaration of function ?WARN?

This is because omap2_prm functions are currently just stubs for
omap4 only builds.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/powerdomain44xx.c
+++ b/arch/arm/mach-omap2/powerdomain44xx.c
@@ -15,6 +15,7 @@
 #include <linux/io.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
+#include <linux/bug.h>
 
 #include "powerdomain.h"
 #include <plat/prcm.h>
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/bug.h>
 
 #include <plat/cpu.h>
 
