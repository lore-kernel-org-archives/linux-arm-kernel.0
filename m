From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 30 Mar 2012 18:26:43 -0300
Subject: [PATCH] ARM: mach-imx: Include <asm/system_misc.h>
Message-ID: <1333142803-24183-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following build error:

arch/arm/mach-imx/mm-imx3.c:138:2: error: 'arm_pm_idle' undeclared (first use in this function)
arch/arm/mach-imx/mm-imx3.c:210:2: error: 'arm_pm_idle' undeclared (first use in this function)
make[2]: *** [arch/arm/mach-imx/mm-imx3.o] Error 1
arch/arm/mach-imx/mm-imx5.c:105:2: error: 'arm_pm_idle' undeclared (first use in this function)

This was caused by commit 4a3ea24 (ARM: plat-mxc: hook special idle handlers to arm_pm_idle)

Include <asm/system_misc.h> to avoid the build error.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
This applies against linux-next
 arch/arm/mach-imx/mm-imx3.c |    1 +
 arch/arm/mach-imx/mm-imx5.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
index d534d7f..1da77fa 100644
--- a/arch/arm/mach-imx/mm-imx3.c
+++ b/arch/arm/mach-imx/mm-imx3.c
@@ -23,6 +23,7 @@
 #include <asm/pgtable.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/map.h>
+#include <asm/system_misc.h>
 
 #include <mach/common.h>
 #include <mach/devices-common.h>
diff --git a/arch/arm/mach-imx/mm-imx5.c b/arch/arm/mach-imx/mm-imx5.c
index 51af9fa..ac8e35c 100644
--- a/arch/arm/mach-imx/mm-imx5.c
+++ b/arch/arm/mach-imx/mm-imx5.c
@@ -16,6 +16,7 @@
 #include <linux/clk.h>
 
 #include <asm/mach/map.h>
+#include <asm/system_misc.h>
 
 #include <mach/hardware.h>
 #include <mach/common.h>
-- 
1.7.1
