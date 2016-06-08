From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed,  8 Jun 2016 18:01:49 +0100
Subject: [PATCH] ARM: tegra: fix missing common.h include
Message-ID: <1465405309-19011-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix two missing function protoypes by including common.h
where they are defined. Fixes:

arch/arm/mach-tegra/hotplug.c:24:5: warning: symbol 'tegra_cpu_kill' was not declared. Should it be static?
arch/arm/mach-tegra/hotplug.c:40:6: warning: symbol 'tegra_cpu_die' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-tegra at vger.kernel.org
---
 arch/arm/mach-tegra/hotplug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-tegra/hotplug.c b/arch/arm/mach-tegra/hotplug.c
index 1b12989..8ec7078 100644
--- a/arch/arm/mach-tegra/hotplug.c
+++ b/arch/arm/mach-tegra/hotplug.c
@@ -17,6 +17,7 @@
 
 #include <asm/smp_plat.h>
 
+#include "common.h"
 #include "sleep.h"
 
 static void (*tegra_hotplug_shutdown)(void);
-- 
2.8.1
