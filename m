From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 21 Jun 2016 13:51:18 +0100
Subject: [PATCH] ARM: prima2: fix missing common.h include in hotplug.c
Message-ID: <1466513478-31441-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sirfsoc_cpu_die() function is declared in common.h but
the header is not included in hotplug.c where is it defined.

Include common.h to fix the following sparse warning:

arch/arm/mach-prima2/hotplug.c:35:6: warning: symbol 'sirfsoc_cpu_die' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Barry Song <baohua@kernel.org>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mach-prima2/hotplug.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-prima2/hotplug.c b/arch/arm/mach-prima2/hotplug.c
index a728c78..97ea2f5 100644
--- a/arch/arm/mach-prima2/hotplug.c
+++ b/arch/arm/mach-prima2/hotplug.c
@@ -12,6 +12,8 @@
 
 #include <asm/smp_plat.h>
 
+#include "common.h"
+
 static inline void platform_do_lowpower(unsigned int cpu)
 {
 	/* we put the platform to just WFI */
-- 
2.8.1
