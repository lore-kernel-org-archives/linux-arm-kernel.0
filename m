From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed,  7 Nov 2012 12:22:51 +0100
Subject: [PATCH 07/10] arm: at91: move at91_shdwc.h to arch/arm/mach-at91
In-Reply-To: <1352287374-25176-1-git-send-email-plagnioj@jcrosoft.com>
References: <20121107111235.GH20063@game.jcrosoft.org>
 <1352287374-25176-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1352287374-25176-7-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is only used by old boards style or via core code.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/{include/mach => }/at91_shdwc.h |    0
 arch/arm/mach-at91/board-qil-a9260.c               |    2 +-
 arch/arm/mach-at91/board-sam9260ek.c               |    2 +-
 arch/arm/mach-at91/board-sam9261ek.c               |    2 +-
 arch/arm/mach-at91/board-sam9263ek.c               |    2 +-
 arch/arm/mach-at91/board-sam9m10g45ek.c            |    2 +-
 arch/arm/mach-at91/board-sam9rlek.c                |    2 +-
 arch/arm/mach-at91/board-usb-a926x.c               |    2 +-
 arch/arm/mach-at91/pm.c                            |    2 +-
 arch/arm/mach-at91/setup.c                         |    2 +-
 10 files changed, 9 insertions(+), 9 deletions(-)
 rename arch/arm/mach-at91/{include/mach => }/at91_shdwc.h (100%)

diff --git a/arch/arm/mach-at91/include/mach/at91_shdwc.h b/arch/arm/mach-at91/at91_shdwc.h
similarity index 100%
rename from arch/arm/mach-at91/include/mach/at91_shdwc.h
rename to arch/arm/mach-at91/at91_shdwc.h
diff --git a/arch/arm/mach-at91/board-qil-a9260.c b/arch/arm/mach-at91/board-qil-a9260.c
index c4bdea7..33b1628 100644
--- a/arch/arm/mach-at91/board-qil-a9260.c
+++ b/arch/arm/mach-at91/board-qil-a9260.c
@@ -41,9 +41,9 @@
 
 #include <mach/hardware.h>
 #include <mach/at91sam9_smc.h>
-#include <mach/at91_shdwc.h>
 
 #include "at91_aic.h"
+#include "at91_shdwc.h"
 #include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-sam9260ek.c b/arch/arm/mach-at91/board-sam9260ek.c
index d0d5fe6..f0135cd 100644
--- a/arch/arm/mach-at91/board-sam9260ek.c
+++ b/arch/arm/mach-at91/board-sam9260ek.c
@@ -42,10 +42,10 @@
 
 #include <mach/hardware.h>
 #include <mach/at91sam9_smc.h>
-#include <mach/at91_shdwc.h>
 #include <mach/system_rev.h>
 
 #include "at91_aic.h"
+#include "at91_shdwc.h"
 #include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-sam9261ek.c b/arch/arm/mach-at91/board-sam9261ek.c
index 5850eb4..13ebaa8 100644
--- a/arch/arm/mach-at91/board-sam9261ek.c
+++ b/arch/arm/mach-at91/board-sam9261ek.c
@@ -46,10 +46,10 @@
 
 #include <mach/hardware.h>
 #include <mach/at91sam9_smc.h>
-#include <mach/at91_shdwc.h>
 #include <mach/system_rev.h>
 
 #include "at91_aic.h"
+#include "at91_shdwc.h"
 #include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-sam9263ek.c b/arch/arm/mach-at91/board-sam9263ek.c
index b8443ae..89b9608 100644
--- a/arch/arm/mach-at91/board-sam9263ek.c
+++ b/arch/arm/mach-at91/board-sam9263ek.c
@@ -45,10 +45,10 @@
 
 #include <mach/hardware.h>
 #include <mach/at91sam9_smc.h>
-#include <mach/at91_shdwc.h>
 #include <mach/system_rev.h>
 
 #include "at91_aic.h"
+#include "at91_shdwc.h"
 #include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
index 6b2a983..e4cc375 100644
--- a/arch/arm/mach-at91/board-sam9m10g45ek.c
+++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
@@ -43,10 +43,10 @@
 #include <asm/mach/irq.h>
 
 #include <mach/at91sam9_smc.h>
-#include <mach/at91_shdwc.h>
 #include <mach/system_rev.h>
 
 #include "at91_aic.h"
+#include "at91_shdwc.h"
 #include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-sam9rlek.c b/arch/arm/mach-at91/board-sam9rlek.c
index 6bd8853..377a109 100644
--- a/arch/arm/mach-at91/board-sam9rlek.c
+++ b/arch/arm/mach-at91/board-sam9rlek.c
@@ -31,10 +31,10 @@
 
 #include <mach/hardware.h>
 #include <mach/at91sam9_smc.h>
-#include <mach/at91_shdwc.h>
 
 
 #include "at91_aic.h"
+#include "at91_shdwc.h"
 #include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-usb-a926x.c b/arch/arm/mach-at91/board-usb-a926x.c
index c93f906..c1060f9 100644
--- a/arch/arm/mach-at91/board-usb-a926x.c
+++ b/arch/arm/mach-at91/board-usb-a926x.c
@@ -42,9 +42,9 @@
 
 #include <mach/hardware.h>
 #include <mach/at91sam9_smc.h>
-#include <mach/at91_shdwc.h>
 
 #include "at91_aic.h"
+#include "at91_shdwc.h"
 #include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index e8cb6b8..3455740 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -37,7 +37,7 @@
  */
 
 #include <mach/at91_rstc.h>
-#include <mach/at91_shdwc.h>
+#include "at91_shdwc.h"
 
 static void __init show_reset_status(void)
 {
diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index 0b32c81..8a66979 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -18,8 +18,8 @@
 #include <mach/cpu.h>
 #include <mach/at91_dbgu.h>
 #include <mach/at91_pmc.h>
-#include <mach/at91_shdwc.h>
 
+#include "at91_shdwc.h"
 #include "soc.h"
 #include "generic.h"
 
-- 
1.7.10.4
