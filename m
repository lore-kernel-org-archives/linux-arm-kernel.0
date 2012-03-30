From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 30 Mar 2012 14:24:49 +0800
Subject: [PATCH] =?UTF-8?q?ARM:=20imx:=20fix=20=E2=80=98arm=5Fpm=5Fidle=E2=80?=
 =?UTF-8?q?=99=20undeclared=20error?=
Message-ID: <1333088689-16135-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing #include <asm/system_misc.h> to fix the following compile
error.

  CC      arch/arm/mach-imx/mm-imx5.o
arch/arm/mach-imx/mm-imx5.c: In function ?imx51_init_early?:
arch/arm/mach-imx/mm-imx5.c:105:2: error: ?arm_pm_idle? undeclared (first use in this function)
arch/arm/mach-imx/mm-imx5.c:105:2: note: each undeclared identifier is reported only once for each function it appears in

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/mm-imx3.c |    1 +
 arch/arm/mach-imx/mm-imx5.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

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
1.7.5.4
