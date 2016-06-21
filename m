From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 21 Jun 2016 13:05:51 +0100
Subject: [PATCH] ARM: keystone: fix missing keystone.h in pm_domain.c
Message-ID: <1466510751-23913-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The declaration of keystone_pm_runtime_init() is not included
from keystone.h in pm_domain.c. Including the file fixes the
following sparse warning:

arch/arm/mach-keystone/pm_domain.c:37:12: warning: symbol 'keystone_pm_runtime_init' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mach-keystone/pm_domain.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-keystone/pm_domain.c b/arch/arm/mach-keystone/pm_domain.c
index e283939..8cbb357 100644
--- a/arch/arm/mach-keystone/pm_domain.c
+++ b/arch/arm/mach-keystone/pm_domain.c
@@ -18,6 +18,8 @@
 #include <linux/platform_device.h>
 #include <linux/of.h>
 
+#include "keystone.h"
+
 static struct dev_pm_domain keystone_pm_domain = {
 	.ops = {
 		USE_PM_CLK_RUNTIME_OPS
-- 
2.8.1
