From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 2 May 2013 18:16:53 +0200
Subject: [PATCH 5/7] ARM: u300: localize <mach/u300-regs.h>
In-Reply-To: <1367511416-4312-1-git-send-email-linus.walleij@stericsson.com>
References: <1367511416-4312-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1367511416-4312-6-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This register base file is now only used in the machine
itself so move it down into mach-u300.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-u300/core.c                         | 3 +--
 arch/arm/mach-u300/regulator.c                    | 2 +-
 arch/arm/mach-u300/{include/mach => }/u300-regs.h | 0
 3 files changed, 2 insertions(+), 3 deletions(-)
 rename arch/arm/mach-u300/{include/mach => }/u300-regs.h (100%)

diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index 9a46426..87fdadb 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -25,9 +25,8 @@
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
 
-#include <mach/u300-regs.h>
-
 #include "timer.h"
+#include "u300-regs.h"
 
 /*
  * SYSCON addresses applicable to the core machine.
diff --git a/arch/arm/mach-u300/regulator.c b/arch/arm/mach-u300/regulator.c
index ab7d7a5..1cbe88c 100644
--- a/arch/arm/mach-u300/regulator.c
+++ b/arch/arm/mach-u300/regulator.c
@@ -17,7 +17,7 @@
 #include <linux/regulator/consumer.h>
 /* Those are just for writing in syscon */
 #include <linux/io.h>
-#include <mach/u300-regs.h>
+#include "u300-regs.h"
 
 /* Power Management Control 16bit (R/W) */
 #define U300_SYSCON_PMCR					(0x50)
diff --git a/arch/arm/mach-u300/include/mach/u300-regs.h b/arch/arm/mach-u300/u300-regs.h
similarity index 100%
rename from arch/arm/mach-u300/include/mach/u300-regs.h
rename to arch/arm/mach-u300/u300-regs.h
-- 
1.7.11.3
