From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue,  7 Jun 2016 20:03:46 +0100
Subject: [PATCH 2/5] mvebu: fix missing include of common.h in pm.c
In-Reply-To: <1465326229-24787-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465326229-24787-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1465326229-24787-3-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mvebu_pm_suspend_init() is missing a definition, so
include common.h which defines this function into pm.c to
fix the following warning:

arch/arm/mach-mvebu/pm.c:235:12: warning: symbol 'mvebu_pm_suspend_init' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/mach-mvebu/pm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mvebu/pm.c b/arch/arm/mach-mvebu/pm.c
index 8d32bf7..2990c52 100644
--- a/arch/arm/mach-mvebu/pm.c
+++ b/arch/arm/mach-mvebu/pm.c
@@ -23,6 +23,7 @@
 #include <asm/suspend.h>
 
 #include "coherency.h"
+#include "common.h"
 #include "pmsu.h"
 
 #define SDRAM_CONFIG_OFFS                  0x0
-- 
2.8.1
