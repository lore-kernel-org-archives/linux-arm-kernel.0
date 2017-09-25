From: marco.franchi@nxp.com (Marco Franchi)
Date: Mon, 25 Sep 2017 15:55:58 -0300
Subject: [PATCH 3/4] ARM: imx: cpuidle-imx5: Include "cpuidle.h" header file
In-Reply-To: <1506365759-28768-1-git-send-email-marco.franchi@nxp.com>
References: <1506365759-28768-1-git-send-email-marco.franchi@nxp.com>
Message-ID: <1506365759-28768-3-git-send-email-marco.franchi@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following build warning is seen with W=1:

warning: no previous prototype for ?imx5_cpuidle_init? 
[-Wmissing-prototypes] int __init imx5_cpuidle_init(void)

Fix this warning by including "cpuidle.h".

Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
---
 arch/arm/mach-imx/cpuidle-imx5.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/cpuidle-imx5.c b/arch/arm/mach-imx/cpuidle-imx5.c
index 3feca52..db01276 100644
--- a/arch/arm/mach-imx/cpuidle-imx5.c
+++ b/arch/arm/mach-imx/cpuidle-imx5.c
@@ -9,6 +9,7 @@
 #include <linux/cpuidle.h>
 #include <linux/module.h>
 #include <asm/system_misc.h>
+#include "cpuidle.h"
 
 static int imx5_cpuidle_enter(struct cpuidle_device *dev,
 			      struct cpuidle_driver *drv, int index)
-- 
2.7.4
