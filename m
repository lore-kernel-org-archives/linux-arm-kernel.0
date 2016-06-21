From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 21 Jun 2016 12:57:13 +0100
Subject: [PATCH] ARM: highbank: fix missing core.h include
Message-ID: <1466510233-8409-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pm code is missing the declaration of highbank_pm_init()
so include the local core.h it is defined in to fix the following
warning:

arch/arm/mach-highbank/pm.c:54:13: warning: symbol 'highbank_pm_init' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Rob Herring <robh@kernel.org>
Cc: linux-arm-kernel at lists.infradead.org

cC:
---
 arch/arm/mach-highbank/pm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-highbank/pm.c b/arch/arm/mach-highbank/pm.c
index 4003116..3580dde 100644
--- a/arch/arm/mach-highbank/pm.c
+++ b/arch/arm/mach-highbank/pm.c
@@ -23,6 +23,8 @@
 
 #include <uapi/linux/psci.h>
 
+#include "core.h"
+
 #define HIGHBANK_SUSPEND_PARAM \
 	((0 << PSCI_0_2_POWER_STATE_ID_SHIFT) | \
 	 (1 << PSCI_0_2_POWER_STATE_AFFL_SHIFT) | \
-- 
2.8.1
