From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 17 Jun 2013 18:34:05 +0200
Subject: [PATCH v2 20/38] ARM: SAMSUNG: pm: Include most of mach/ headers
 conditionally
In-Reply-To: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
References: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
Message-ID: <1371486863-12398-21-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since it is illegal to include mach/ headers from source files outside
of respective mach-* directory and DT-only Samsung platforms might not
have all of them anyway, this patches makes inclusion of them
conditional, based on CONFIG_SAMSUNG_ATAGS.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/pm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-samsung/pm.c b/arch/arm/plat-samsung/pm.c
index 53210ec..d76ab72 100644
--- a/arch/arm/plat-samsung/pm.c
+++ b/arch/arm/plat-samsung/pm.c
@@ -21,13 +21,17 @@
 
 #include <asm/cacheflush.h>
 #include <asm/suspend.h>
-#include <mach/hardware.h>
-#include <mach/map.h>
 
 #include <plat/regs-serial.h>
+
+#ifdef CONFIG_SAMSUNG_ATAGS
+#include <mach/hardware.h>
+#include <mach/map.h>
 #include <mach/regs-clock.h>
 #include <mach/regs-irq.h>
 #include <mach/irqs.h>
+#endif
+
 #include <asm/irq.h>
 
 #include <plat/pm.h>
-- 
1.8.2.1
