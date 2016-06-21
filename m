From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 21 Jun 2016 13:13:11 +0100
Subject: [PATCH] ARM: imx6: fix missing <soc/imx/cpuidle.h> in cpuidle-imx6q.c
Message-ID: <1466511191-31967-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The <soc/imx/cpuidle.h> file has declarations of two funcitons
exported from cpuidle-imx6q.c but it is not included. Fix the
following warnings by adding the include:

arch/arm/mach-imx/cpuidle-imx6q.c:71:6: warning: symbol 'imx6q_cpuidle_fec_irqs_used' was not declared. Should it be static?
arch/arm/mach-imx/cpuidle-imx6q.c:76:6: warning: symbol 'imx6q_cpuidle_fec_irqs_unused' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mach-imx/cpuidle-imx6q.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-imx/cpuidle-imx6q.c b/arch/arm/mach-imx/cpuidle-imx6q.c
index c3cc8ca..ad0d9ed 100644
--- a/arch/arm/mach-imx/cpuidle-imx6q.c
+++ b/arch/arm/mach-imx/cpuidle-imx6q.c
@@ -10,6 +10,8 @@
 #include <linux/module.h>
 #include <asm/cpuidle.h>
 
+#include <soc/imx/cpuidle.h>
+
 #include "common.h"
 #include "cpuidle.h"
 #include "hardware.h"
-- 
2.8.1
