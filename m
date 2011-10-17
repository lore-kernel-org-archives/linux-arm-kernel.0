From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 17 Oct 2011 14:15:09 +0800
Subject: [PATCH 4/5] arm/imx: explicitly includes mach/hardware.h in pm-imx27.c
In-Reply-To: <1318832110-29289-1-git-send-email-shawn.guo@linaro.org>
References: <1318832110-29289-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1318832110-29289-5-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pm-imx27.c references a number of things requiring the explicit
inclusion of mach/hardware.h.  Otherwise, when indirect inclusion
to mach/hardware.h gets cleaned up, we will see the following
compile error.

  CC      arch/arm/mach-imx/pm-imx27.o
arch/arm/mach-imx/pm-imx27.c: In function ?mx27_suspend_enter?:
arch/arm/mach-imx/pm-imx27.c:22:3: error: implicit declaration of function ?IOMEM?
arch/arm/mach-imx/pm-imx27.c:22:3: error: implicit declaration of function ?IMX_IO_P2V?
arch/arm/mach-imx/pm-imx27.c: In function ?mx27_pm_init?:
arch/arm/mach-imx/pm-imx27.c:42:2: error: implicit declaration of function ?cpu_is_mx27?

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/pm-imx27.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/pm-imx27.c b/arch/arm/mach-imx/pm-imx27.c
index acf1769..e455d2f 100644
--- a/arch/arm/mach-imx/pm-imx27.c
+++ b/arch/arm/mach-imx/pm-imx27.c
@@ -11,7 +11,7 @@
 #include <linux/suspend.h>
 #include <linux/io.h>
 #include <mach/system.h>
-#include <mach/mx27.h>
+#include <mach/hardware.h>
 
 static int mx27_suspend_enter(suspend_state_t state)
 {
-- 
1.7.4.1
