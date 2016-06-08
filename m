From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed,  8 Jun 2016 18:29:05 +0100
Subject: [PATCH] ARM: imx: fix missing cpuidle.h include
Message-ID: <1465406945-2974-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the missing declaration of imx5_cpuidle_init() by including
the cpuidle.h it is declared in. Fixes:

arch/arm/mach-imx/cpuidle-imx5.c:33:12: warning: symbol 'imx5_cpuidle_init' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mach-imx/cpuidle-imx5.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-imx/cpuidle-imx5.c b/arch/arm/mach-imx/cpuidle-imx5.c
index 3feca52..6fff6fa 100644
--- a/arch/arm/mach-imx/cpuidle-imx5.c
+++ b/arch/arm/mach-imx/cpuidle-imx5.c
@@ -10,6 +10,8 @@
 #include <linux/module.h>
 #include <asm/system_misc.h>
 
+#include "cpuidle.h"
+
 static int imx5_cpuidle_enter(struct cpuidle_device *dev,
 			      struct cpuidle_driver *drv, int index)
 {
-- 
2.8.1
