From: will.deacon@arm.com (Will Deacon)
Date: Mon, 25 Mar 2013 18:19:12 +0000
Subject: [PATCH 2/2] ARM: tegra: use CS_LAR_KEY definition instead of
 0xC5ACCE55
In-Reply-To: <1364235552-17851-1-git-send-email-will.deacon@arm.com>
References: <1364235552-17851-1-git-send-email-will.deacon@arm.com>
Message-ID: <1364235552-17851-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When enabling coresight on secondary cores for tegra, make use of our
fancy new definition for the magic lock code.

Cc: Stephen Warren <swarren@wwwdotorg.org>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-tegra/headsmp.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/headsmp.S b/arch/arm/mach-tegra/headsmp.S
index fd473f2..d2747fe 100644
--- a/arch/arm/mach-tegra/headsmp.S
+++ b/arch/arm/mach-tegra/headsmp.S
@@ -1,6 +1,7 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 
+#include <asm/hardware/coresight.h>
 #include "sleep.h"
 
         .section ".text.head", "ax"
@@ -8,7 +9,7 @@
 ENTRY(tegra_secondary_startup)
         bl      v7_invalidate_l1
 	/* Enable coresight */
-	mov32	r0, 0xC5ACCE55
+	mov32	r0, CS_LAR_KEY
 	mcr	p14, 0, r0, c7, c12, 6
         b       secondary_startup
 ENDPROC(tegra_secondary_startup)
-- 
1.8.0
