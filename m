From: hector.oron@gmail.com (Hector Oron)
Date: Mon,  5 Dec 2011 12:54:17 +0000
Subject: [PATCH] ARM: mxc: cpufreq.c: include missing module.h header
Message-ID: <1323089657-25832-1-git-send-email-hector.oron@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  Fixes a fail to build with following message:

     CC [M]  arch/arm/plat-mxc/cpufreq.o
   arch/arm/plat-mxc/cpufreq.c:203:15: error: expected
   declaration specifiers or '...' before string constant
   arch/arm/plat-mxc/cpufreq.c:204:20: error: expected
   declaration specifiers or '...' before string constant
   arch/arm/plat-mxc/cpufreq.c:205:16: error: expected
   declaration specifiers or '...' before string constant

Signed-off-by: Hector Oron <hector.oron@gmail.com>
---
 arch/arm/plat-mxc/cpufreq.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/cpufreq.c b/arch/arm/plat-mxc/cpufreq.c
index 74aac96..e3073be 100644
--- a/arch/arm/plat-mxc/cpufreq.c
+++ b/arch/arm/plat-mxc/cpufreq.c
@@ -20,6 +20,7 @@
 #include <linux/cpufreq.h>
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 #include <mach/hardware.h>
 #include <mach/clock.h>
-- 
1.7.7.3
