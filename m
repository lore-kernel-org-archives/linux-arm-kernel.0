From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Jul 2017 17:51:46 +0200
Subject: [PATCH 08/12] ARM: sirf: mark sirfsoc_init_late as __maybe_unused
In-Reply-To: <20170720154616.3250481-1-arnd@arndb.de>
References: <20170720154616.3250481-1-arnd@arndb.de>
Message-ID: <20170720155209.3250880-5-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sirfsoc_init_late is called by each of the three individual
SoC definitions, but in a randconfig build, we can encounter
a situation where they are all disabled:

arch/arm/mach-prima2/common.c:18:123: warning: 'sirfsoc_init_late' defined but not used [-Wunused-function]

While that is not a useful configuration, the warning also
doesn't help, so this patch marks the function as __maybe_unused
to let the compiler know it is there intentionally.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Originally submitted Feb 2016, but it got lost
---
 arch/arm/mach-prima2/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-prima2/common.c b/arch/arm/mach-prima2/common.c
index 8cadb302a7d2..ffe05c27087e 100644
--- a/arch/arm/mach-prima2/common.c
+++ b/arch/arm/mach-prima2/common.c
@@ -15,7 +15,7 @@
 #include <linux/of_platform.h>
 #include "common.h"
 
-static void __init sirfsoc_init_late(void)
+static void __init __maybe_unused sirfsoc_init_late(void)
 {
 	sirfsoc_pm_init();
 }
-- 
2.9.0
