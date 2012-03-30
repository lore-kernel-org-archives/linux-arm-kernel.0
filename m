From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Fri, 30 Mar 2012 14:42:30 -0400
Subject: [PATCH] ARM: imx: fix compile error on missing arm_pm_idle
Message-ID: <1333132950-28357-1-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This shows up in imx_v6_v7_defconfig build:

arch/arm/mach-imx/mm-imx3.c: In function 'imx31_init_early':
arch/arm/mach-imx/mm-imx3.c:138: error: 'arm_pm_idle' undeclared
arch/arm/mach-imx/mm-imx5.c: In function 'imx51_init_early':
arch/arm/mach-imx/mm-imx5.c:105: error: 'arm_pm_idle' undeclared
arch/arm/mach-imx/mm-imx3.c: In function 'imx35_init_early':
arch/arm/mach-imx/mm-imx3.c:210: error: 'arm_pm_idle' undeclared
arch/arm/mach-imx/mm-imx5.c: In function 'imx51_init_early':
arch/arm/mach-imx/mm-imx5.c:105: error: 'arm_pm_idle' undeclared

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
index d534d7f..7412738 100644
--- a/arch/arm/mach-imx/mm-imx3.c
+++ b/arch/arm/mach-imx/mm-imx3.c
@@ -21,6 +21,7 @@
 #include <linux/err.h>
 
 #include <asm/pgtable.h>
+#include <asm/system_misc.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/map.h>
 
diff --git a/arch/arm/mach-imx/mm-imx5.c b/arch/arm/mach-imx/mm-imx5.c
index 51af9fa..05250ae 100644
--- a/arch/arm/mach-imx/mm-imx5.c
+++ b/arch/arm/mach-imx/mm-imx5.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/clk.h>
 
+#include <asm/system_misc.h>
 #include <asm/mach/map.h>
 
 #include <mach/hardware.h>
-- 
1.7.9.1
