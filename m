From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed,  7 Nov 2012 12:22:53 +0100
Subject: [PATCH 09/10] arm: at91: move reset controller header to
 arm/arm/mach-at91
In-Reply-To: <1352287374-25176-1-git-send-email-plagnioj@jcrosoft.com>
References: <20121107111235.GH20063@game.jcrosoft.org>
 <1352287374-25176-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1352287374-25176-9-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/{include/mach => }/at91_rstc.h |    0
 arch/arm/mach-at91/at91sam9260.c                  |    2 +-
 arch/arm/mach-at91/at91sam9261.c                  |    2 +-
 arch/arm/mach-at91/at91sam9263.c                  |    2 +-
 arch/arm/mach-at91/at91sam9_alt_reset.S           |    2 +-
 arch/arm/mach-at91/at91sam9g45_reset.S            |    3 +--
 arch/arm/mach-at91/at91sam9rl.c                   |    2 +-
 arch/arm/mach-at91/pm.c                           |    2 +-
 8 files changed, 7 insertions(+), 8 deletions(-)
 rename arch/arm/mach-at91/{include/mach => }/at91_rstc.h (100%)

diff --git a/arch/arm/mach-at91/include/mach/at91_rstc.h b/arch/arm/mach-at91/at91_rstc.h
similarity index 100%
rename from arch/arm/mach-at91/include/mach/at91_rstc.h
rename to arch/arm/mach-at91/at91_rstc.h
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index bb2e17c..9942984 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -21,9 +21,9 @@
 #include <mach/at91_dbgu.h>
 #include <mach/at91sam9260.h>
 #include <mach/at91_pmc.h>
-#include <mach/at91_rstc.h>
 
 #include "at91_aic.h"
+#include "at91_rstc.h"
 #include "soc.h"
 #include "generic.h"
 #include "clock.h"
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index 09009d8..c583ba2 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -20,9 +20,9 @@
 #include <mach/cpu.h>
 #include <mach/at91sam9261.h>
 #include <mach/at91_pmc.h>
-#include <mach/at91_rstc.h>
 
 #include "at91_aic.h"
+#include "at91_rstc.h"
 #include "soc.h"
 #include "generic.h"
 #include "clock.h"
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index 0c86aa8..500ee19 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -19,9 +19,9 @@
 #include <asm/system_misc.h>
 #include <mach/at91sam9263.h>
 #include <mach/at91_pmc.h>
-#include <mach/at91_rstc.h>
 
 #include "at91_aic.h"
+#include "at91_rstc.h"
 #include "soc.h"
 #include "generic.h"
 #include "clock.h"
diff --git a/arch/arm/mach-at91/at91sam9_alt_reset.S b/arch/arm/mach-at91/at91sam9_alt_reset.S
index 7af2e10..f039538 100644
--- a/arch/arm/mach-at91/at91sam9_alt_reset.S
+++ b/arch/arm/mach-at91/at91sam9_alt_reset.S
@@ -16,7 +16,7 @@
 #include <linux/linkage.h>
 #include <mach/hardware.h>
 #include <mach/at91_ramc.h>
-#include <mach/at91_rstc.h>
+#include "at91_rstc.h"
 
 			.arm
 
diff --git a/arch/arm/mach-at91/at91sam9g45_reset.S b/arch/arm/mach-at91/at91sam9g45_reset.S
index 9d45718..721a1a3 100644
--- a/arch/arm/mach-at91/at91sam9g45_reset.S
+++ b/arch/arm/mach-at91/at91sam9g45_reset.S
@@ -13,8 +13,7 @@
 #include <linux/linkage.h>
 #include <mach/hardware.h>
 #include <mach/at91_ramc.h>
-#include <mach/at91_rstc.h>
-
+#include "at91_rstc.h"
 			.arm
 
 			.globl	at91sam9g45_restart
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index 5cd076b..97dd8f1 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -20,9 +20,9 @@
 #include <mach/at91_dbgu.h>
 #include <mach/at91sam9rl.h>
 #include <mach/at91_pmc.h>
-#include <mach/at91_rstc.h>
 
 #include "at91_aic.h"
+#include "at91_rstc.h"
 #include "soc.h"
 #include "generic.h"
 #include "clock.h"
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 3455740..adb6db8 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -36,7 +36,7 @@
  * Show the reason for the previous system reset.
  */
 
-#include <mach/at91_rstc.h>
+#include "at91_rstc.h"
 #include "at91_shdwc.h"
 
 static void __init show_reset_status(void)
-- 
1.7.10.4
