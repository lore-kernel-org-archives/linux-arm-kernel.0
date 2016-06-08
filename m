From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed,  8 Jun 2016 17:54:57 +0100
Subject: [PATCH] ARM: tegra: fix missing include <soc/tegra/cpuidle.h>
Message-ID: <1465404897-16654-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The prototype of tegra_cpuidle_pcie_irqs_in_use() is missing
from the cpuidle.c file, it is defined in <soc/tegra/cpuidle.h>
so add that include to avoid the following warning:

arch/arm/mach-tegra/cpuidle.c:51:6: warning: symbol 'tegra_cpuidle_pcie_irqs_in_use' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-tegra at vger.kernel.org
---
 arch/arm/mach-tegra/cpuidle.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-tegra/cpuidle.c b/arch/arm/mach-tegra/cpuidle.c
index 3165631..b8e4568 100644
--- a/arch/arm/mach-tegra/cpuidle.c
+++ b/arch/arm/mach-tegra/cpuidle.c
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 
 #include <soc/tegra/fuse.h>
+#include <soc/tegra/cpuidle.h>
 
 #include "cpuidle.h"
 
-- 
2.8.1
