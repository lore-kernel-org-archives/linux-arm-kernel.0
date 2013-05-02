From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 2 May 2013 18:16:50 +0200
Subject: [PATCH 2/7] ARM: u300: remove deps from debug macro
In-Reply-To: <1367511416-4312-1-git-send-email-linus.walleij@stericsson.com>
References: <1367511416-4312-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1367511416-4312-3-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This rids the dependency to <mach/hardware.h> (which is an
implicit dependency to <mach/u300-regs.h>) from the U300
debug macro. Take this opportunity to update the file
header.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/include/debug/u300.S | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/debug/u300.S b/arch/arm/include/debug/u300.S
index 8ae8e4a..6f04f08 100644
--- a/arch/arm/include/debug/u300.S
+++ b/arch/arm/include/debug/u300.S
@@ -1,14 +1,11 @@
 /*
- *
- * arch-arm/mach-u300/include/mach/debug-macro.S
- *
- *
- * Copyright (C) 2006-2009 ST-Ericsson AB
+ * Copyright (C) 2006-2013 ST-Ericsson AB
  * License terms: GNU General Public License (GPL) version 2
  * Debugging macro include header.
  * Author: Linus Walleij <linus.walleij@stericsson.com>
  */
-#include <mach/hardware.h>
+#define U300_SLOW_PER_PHYS_BASE		0xc0010000
+#define U300_SLOW_PER_VIRT_BASE		0xff000000
 
 	.macro	addruart, rp, rv, tmp
 	/* If we move the address using MMU, use this. */
-- 
1.7.11.3
