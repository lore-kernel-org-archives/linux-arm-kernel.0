From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri,  6 Jan 2012 16:48:34 +0100
Subject: [PATCH 1/2] at91 : move pm.h header to arch/arm/include/asm
Message-ID: <1325864915-794-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the location of the pm.h header file to the include directory,
so it can be included from another place from the current one.

That will allow the next patch which moves the cpuidle code to the
drivers/cpuidle directory.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/{mach-at91/pm.h => include/asm/at91_pm.h} |    0
 arch/arm/mach-at91/cpuidle.c                       |    2 +-
 arch/arm/mach-at91/pm.c                            |    2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/arm/{mach-at91/pm.h => include/asm/at91_pm.h} (100%)

diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/include/asm/at91_pm.h
similarity index 100%
rename from arch/arm/mach-at91/pm.h
rename to arch/arm/include/asm/at91_pm.h
diff --git a/arch/arm/mach-at91/cpuidle.c b/arch/arm/mach-at91/cpuidle.c
index a851e6c..8281eec 100644
--- a/arch/arm/mach-at91/cpuidle.c
+++ b/arch/arm/mach-at91/cpuidle.c
@@ -21,7 +21,7 @@
 #include <linux/io.h>
 #include <linux/export.h>
 
-#include "pm.h"
+#include <asm/at91_pm.h>
 
 #define AT91_MAX_STATES	2
 
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 62ad955..86bc243 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -21,6 +21,7 @@
 #include <linux/io.h>
 
 #include <asm/irq.h>
+#include <asm/at91_pm.h>
 #include <linux/atomic.h>
 #include <asm/mach/time.h>
 #include <asm/mach/irq.h>
@@ -29,7 +30,6 @@
 #include <mach/cpu.h>
 
 #include "generic.h"
-#include "pm.h"
 
 /*
  * Show the reason for the previous system reset.
-- 
1.7.4.1
