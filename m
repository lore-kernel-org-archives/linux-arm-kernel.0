From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 21 Jun 2016 13:42:28 +0100
Subject: [PATCH] ARM: prima2: fix missing common.h in pm.c
Message-ID: <1466512948-21081-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sirfsoc_pm_init() function is declared in common.h but
the header is not included in pm.c where it is defined. Fix
the following warning by including common.h:

arch/arm/mach-prima2/pm.c:148:12: warning: symbol 'sirfsoc_pm_init' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Barry Song <baohua@kernel.org>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mach-prima2/pm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-prima2/pm.c b/arch/arm/mach-prima2/pm.c
index 83e94c9..74c551a 100644
--- a/arch/arm/mach-prima2/pm.c
+++ b/arch/arm/mach-prima2/pm.c
@@ -20,6 +20,7 @@
 #include <asm/suspend.h>
 #include <asm/hardware/cache-l2x0.h>
 
+#include "common.h"
 #include "pm.h"
 
 /*
-- 
2.8.1
