From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed,  7 Nov 2012 12:22:48 +0100
Subject: [PATCH 04/10] arm: at91 move at91_aic.h to arch/arm/mach-at91
In-Reply-To: <1352287374-25176-1-git-send-email-plagnioj@jcrosoft.com>
References: <20121107111235.GH20063@game.jcrosoft.org>
 <1352287374-25176-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1352287374-25176-4-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

as this is only used board old style board old mach code

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/{include/mach => }/at91_aic.h |    0
 arch/arm/mach-at91/at91rm9200.c                  |    2 +-
 arch/arm/mach-at91/at91sam9260.c                 |    2 +-
 arch/arm/mach-at91/at91sam9261.c                 |    2 +-
 arch/arm/mach-at91/at91sam9263.c                 |    2 +-
 arch/arm/mach-at91/at91sam9g45.c                 |    2 +-
 arch/arm/mach-at91/at91sam9rl.c                  |    2 +-
 arch/arm/mach-at91/at91x40.c                     |    3 ++-
 arch/arm/mach-at91/board-1arm.c                  |    2 +-
 arch/arm/mach-at91/board-afeb-9260v1.c           |    3 +--
 arch/arm/mach-at91/board-cam60.c                 |    2 +-
 arch/arm/mach-at91/board-carmeva.c               |    2 +-
 arch/arm/mach-at91/board-cpu9krea.c              |    2 +-
 arch/arm/mach-at91/board-cpuat91.c               |    2 +-
 arch/arm/mach-at91/board-csb337.c                |    2 +-
 arch/arm/mach-at91/board-csb637.c                |    2 +-
 arch/arm/mach-at91/board-dt.c                    |    3 +--
 arch/arm/mach-at91/board-eb01.c                  |    2 +-
 arch/arm/mach-at91/board-eb9200.c                |    3 +--
 arch/arm/mach-at91/board-ecbat91.c               |    2 +-
 arch/arm/mach-at91/board-eco920.c                |    2 +-
 arch/arm/mach-at91/board-flexibity.c             |    2 +-
 arch/arm/mach-at91/board-foxg20.c                |    2 +-
 arch/arm/mach-at91/board-gsia18s.c               |    2 +-
 arch/arm/mach-at91/board-kafa.c                  |    2 +-
 arch/arm/mach-at91/board-kb9202.c                |    2 +-
 arch/arm/mach-at91/board-neocore926.c            |    2 +-
 arch/arm/mach-at91/board-pcontrol-g20.c          |    2 +-
 arch/arm/mach-at91/board-picotux200.c            |    2 +-
 arch/arm/mach-at91/board-qil-a9260.c             |    2 +-
 arch/arm/mach-at91/board-rm9200dk.c              |    2 +-
 arch/arm/mach-at91/board-rm9200ek.c              |    2 +-
 arch/arm/mach-at91/board-rsi-ews.c               |    2 +-
 arch/arm/mach-at91/board-sam9-l9260.c            |    2 +-
 arch/arm/mach-at91/board-sam9260ek.c             |    2 +-
 arch/arm/mach-at91/board-sam9261ek.c             |    2 +-
 arch/arm/mach-at91/board-sam9263ek.c             |    2 +-
 arch/arm/mach-at91/board-sam9g20ek.c             |    2 +-
 arch/arm/mach-at91/board-sam9m10g45ek.c          |    2 +-
 arch/arm/mach-at91/board-sam9rlek.c              |    3 ++-
 arch/arm/mach-at91/board-snapper9260.c           |    2 +-
 arch/arm/mach-at91/board-stamp9g20.c             |    2 +-
 arch/arm/mach-at91/board-usb-a926x.c             |    2 +-
 arch/arm/mach-at91/board-yl-9200.c               |    2 +-
 arch/arm/mach-at91/irq.c                         |    2 +-
 arch/arm/mach-at91/pm.c                          |    2 +-
 46 files changed, 47 insertions(+), 48 deletions(-)
 rename arch/arm/mach-at91/{include/mach => }/at91_aic.h (100%)

diff --git a/arch/arm/mach-at91/include/mach/at91_aic.h b/arch/arm/mach-at91/at91_aic.h
similarity index 100%
rename from arch/arm/mach-at91/include/mach/at91_aic.h
rename to arch/arm/mach-at91/at91_aic.h
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 5269825..aeac7cf 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -17,11 +17,11 @@
 #include <asm/mach/map.h>
 #include <asm/system_misc.h>
 #include <mach/at91rm9200.h>
-#include <mach/at91_aic.h>
 #include <mach/at91_pmc.h>
 #include <mach/at91_st.h>
 #include <mach/cpu.h>
 
+#include "at91_aic.h"
 #include "soc.h"
 #include "generic.h"
 #include "clock.h"
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index f820261..bb2e17c 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -20,10 +20,10 @@
 #include <mach/cpu.h>
 #include <mach/at91_dbgu.h>
 #include <mach/at91sam9260.h>
-#include <mach/at91_aic.h>
 #include <mach/at91_pmc.h>
 #include <mach/at91_rstc.h>
 
+#include "at91_aic.h"
 #include "soc.h"
 #include "generic.h"
 #include "clock.h"
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index 04295c0..09009d8 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -19,10 +19,10 @@
 #include <asm/system_misc.h>
 #include <mach/cpu.h>
 #include <mach/at91sam9261.h>
-#include <mach/at91_aic.h>
 #include <mach/at91_pmc.h>
 #include <mach/at91_rstc.h>
 
+#include "at91_aic.h"
 #include "soc.h"
 #include "generic.h"
 #include "clock.h"
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index d6f9c23..0c86aa8 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -18,10 +18,10 @@
 #include <asm/mach/map.h>
 #include <asm/system_misc.h>
 #include <mach/at91sam9263.h>
-#include <mach/at91_aic.h>
 #include <mach/at91_pmc.h>
 #include <mach/at91_rstc.h>
 
+#include "at91_aic.h"
 #include "soc.h"
 #include "generic.h"
 #include "clock.h"
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 84af1b5..098fe16 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -18,10 +18,10 @@
 #include <asm/mach/map.h>
 #include <asm/system_misc.h>
 #include <mach/at91sam9g45.h>
-#include <mach/at91_aic.h>
 #include <mach/at91_pmc.h>
 #include <mach/cpu.h>
 
+#include "at91_aic.h"
 #include "soc.h"
 #include "generic.h"
 #include "clock.h"
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index 72e9084..5cd076b 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -19,10 +19,10 @@
 #include <mach/cpu.h>
 #include <mach/at91_dbgu.h>
 #include <mach/at91sam9rl.h>
-#include <mach/at91_aic.h>
 #include <mach/at91_pmc.h>
 #include <mach/at91_rstc.h>
 
+#include "at91_aic.h"
 #include "soc.h"
 #include "generic.h"
 #include "clock.h"
diff --git a/arch/arm/mach-at91/at91x40.c b/arch/arm/mach-at91/at91x40.c
index bb7f544..19ca793 100644
--- a/arch/arm/mach-at91/at91x40.c
+++ b/arch/arm/mach-at91/at91x40.c
@@ -18,9 +18,10 @@
 #include <asm/system_misc.h>
 #include <asm/mach/arch.h>
 #include <mach/at91x40.h>
-#include <mach/at91_aic.h>
 #include <mach/at91_st.h>
 #include <mach/timex.h>
+
+#include "at91_aic.h"
 #include "generic.h"
 
 /*
diff --git a/arch/arm/mach-at91/board-1arm.c b/arch/arm/mach-at91/board-1arm.c
index 0f22d25..b99b575 100644
--- a/arch/arm/mach-at91/board-1arm.c
+++ b/arch/arm/mach-at91/board-1arm.c
@@ -35,8 +35,8 @@
 #include <asm/mach/irq.h>
 
 #include <mach/cpu.h>
-#include <mach/at91_aic.h>
 
+#include "at91_aic.h"
 #include "board.h"
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-afeb-9260v1.c b/arch/arm/mach-at91/board-afeb-9260v1.c
index 7935673..854b979 100644
--- a/arch/arm/mach-at91/board-afeb-9260v1.c
+++ b/arch/arm/mach-at91/board-afeb-9260v1.c
@@ -43,8 +43,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/at91_aic.h>
-
+#include "at91_aic.h"
 #include "board.h"
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-cam60.c b/arch/arm/mach-at91/board-cam60.c
index 51dec43..28a18ce 100644
--- a/arch/arm/mach-at91/board-cam60.c
+++ b/arch/arm/mach-at91/board-cam60.c
@@ -38,9 +38,9 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
 
+#include "at91_aic.h"
 #include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-carmeva.c b/arch/arm/mach-at91/board-carmeva.c
index 2811763..c17bb53 100644
--- a/arch/arm/mach-at91/board-carmeva.c
+++ b/arch/arm/mach-at91/board-carmeva.c
@@ -35,8 +35,8 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
-#include <mach/at91_aic.h>
 
+#include "at91_aic.h"
 #include "board.h"
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-cpu9krea.c b/arch/arm/mach-at91/board-cpu9krea.c
index 9e6316d..8474324 100644
--- a/arch/arm/mach-at91/board-cpu9krea.c
+++ b/arch/arm/mach-at91/board-cpu9krea.c
@@ -40,11 +40,11 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
-#include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91sam9260_matrix.h>
 #include <mach/at91_matrix.h>
 
+#include "at91_aic.h"
 #include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-cpuat91.c b/arch/arm/mach-at91/board-cpuat91.c
index e74d395..2a7af78 100644
--- a/arch/arm/mach-at91/board-cpuat91.c
+++ b/arch/arm/mach-at91/board-cpuat91.c
@@ -36,11 +36,11 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/at91_aic.h>
 #include <mach/at91rm9200_mc.h>
 #include <mach/at91_ramc.h>
 #include <mach/cpu.h>
 
+#include "at91_aic.h"
 #include "board.h"
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-csb337.c b/arch/arm/mach-at91/board-csb337.c
index e4063bd..78e0250 100644
--- a/arch/arm/mach-at91/board-csb337.c
+++ b/arch/arm/mach-at91/board-csb337.c
@@ -38,8 +38,8 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
-#include <mach/at91_aic.h>
 
+#include "at91_aic.h"
 #include "board.h"
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-csb637.c b/arch/arm/mach-at91/board-csb637.c
index 306e7b6..ec0f3ab 100644
--- a/arch/arm/mach-at91/board-csb637.c
+++ b/arch/arm/mach-at91/board-csb637.c
@@ -35,8 +35,8 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
-#include <mach/at91_aic.h>
 
+#include "at91_aic.h"
 #include "board.h"
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-dt.c b/arch/arm/mach-at91/board-dt.c
index 7ba737d..03f028e 100644
--- a/arch/arm/mach-at91/board-dt.c
+++ b/arch/arm/mach-at91/board-dt.c
@@ -15,14 +15,13 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 
-#include <mach/at91_aic.h>
-
 #include <asm/setup.h>
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
+#include "at91_aic.h"
 #include "board.h"
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-eb01.c b/arch/arm/mach-at91/board-eb01.c
index f6b85f0..b489388 100644
--- a/arch/arm/mach-at91/board-eb01.c
+++ b/arch/arm/mach-at91/board-eb01.c
@@ -27,8 +27,8 @@
 #include <mach/hardware.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <mach/at91_aic.h>
 
+#include "at91_aic.h"
 #include "board.h"
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-eb9200.c b/arch/arm/mach-at91/board-eb9200.c
index 6e53817..9f5e71c 100644
--- a/arch/arm/mach-at91/board-eb9200.c
+++ b/arch/arm/mach-at91/board-eb9200.c
@@ -35,8 +35,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/at91_aic.h>
-
+#include "at91_aic.h"
 #include "board.h"
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-ecbat91.c b/arch/arm/mach-at91/board-ecbat91.c
index df23145..ef69e0e 100644
--- a/arch/arm/mach-at91/board-ecbat91.c
+++ b/arch/arm/mach-at91/board-ecbat91.c
@@ -38,8 +38,8 @@
 #include <asm/mach/irq.h>
 
 #include <mach/cpu.h>
-#include <mach/at91_aic.h>
 
+#include "at91_aic.h"
 #include "board.h"
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-eco920.c b/arch/arm/mach-at91/board-eco920.c
index 771e58b..50f3d37 100644
--- a/arch/arm/mach-at91/board-eco920.c
+++ b/arch/arm/mach-at91/board-eco920.c
@@ -24,11 +24,11 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/at91_aic.h>
 #include <mach/at91rm9200_mc.h>
 #include <mach/at91_ramc.h>
 #include <mach/cpu.h>
 
+#include "at91_aic.h"
 #include "board.h"
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-flexibity.c b/arch/arm/mach-at91/board-flexibity.c
index 2df0fe4..5d44eba 100644
--- a/arch/arm/mach-at91/board-flexibity.c
+++ b/arch/arm/mach-at91/board-flexibity.c
@@ -33,8 +33,8 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
-#include <mach/at91_aic.h>
 
+#include "at91_aic.h"
 #include "board.h"
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-foxg20.c b/arch/arm/mach-at91/board-foxg20.c
index 18e1777..191d37c 100644
--- a/arch/arm/mach-at91/board-foxg20.c
+++ b/arch/arm/mach-at91/board-foxg20.c
@@ -41,9 +41,9 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
 
+#include "at91_aic.h"
 #include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-gsia18s.c b/arch/arm/mach-at91/board-gsia18s.c
index 0fefddc..842add7 100644
--- a/arch/arm/mach-at91/board-gsia18s.c
+++ b/arch/arm/mach-at91/board-gsia18s.c
@@ -30,11 +30,11 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/gsia18s.h>
 #include <mach/stamp9g20.h>
 
+#include "at91_aic.h"
 #include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-kafa.c b/arch/arm/mach-at91/board-kafa.c
index 920cf4c..9a43d1e 100644
--- a/arch/arm/mach-at91/board-kafa.c
+++ b/arch/arm/mach-at91/board-kafa.c
@@ -34,9 +34,9 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/at91_aic.h>
 #include <mach/cpu.h>
 
+#include "at91_aic.h"
 #include "board.h"
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-kb9202.c b/arch/arm/mach-at91/board-kb9202.c
index 2d37837..f168bec 100644
--- a/arch/arm/mach-at91/board-kb9202.c
+++ b/arch/arm/mach-at91/board-kb9202.c
@@ -36,10 +36,10 @@
 #include <asm/mach/irq.h>
 
 #include <mach/cpu.h>
-#include <mach/at91_aic.h>
 #include <mach/at91rm9200_mc.h>
 #include <mach/at91_ramc.h>
 
+#include "at91_aic.h"
 #include "board.h"
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-neocore926.c b/arch/arm/mach-at91/board-neocore926.c
index 935d11c..bc7a1c4 100644
--- a/arch/arm/mach-at91/board-neocore926.c
+++ b/arch/arm/mach-at91/board-neocore926.c
@@ -44,9 +44,9 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
-#include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
 
+#include "at91_aic.h"
 #include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-pcontrol-g20.c b/arch/arm/mach-at91/board-pcontrol-g20.c
index e1e0766..977fa78 100644
--- a/arch/arm/mach-at91/board-pcontrol-g20.c
+++ b/arch/arm/mach-at91/board-pcontrol-g20.c
@@ -29,10 +29,10 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/stamp9g20.h>
 
+#include "at91_aic.h"
 #include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-picotux200.c b/arch/arm/mach-at91/board-picotux200.c
index a4a1d0f..4938f1c 100644
--- a/arch/arm/mach-at91/board-picotux200.c
+++ b/arch/arm/mach-at91/board-picotux200.c
@@ -37,10 +37,10 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/at91_aic.h>
 #include <mach/at91rm9200_mc.h>
 #include <mach/at91_ramc.h>
 
+#include "at91_aic.h"
 #include "board.h"
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-qil-a9260.c b/arch/arm/mach-at91/board-qil-a9260.c
index a816fb3..c4bdea7 100644
--- a/arch/arm/mach-at91/board-qil-a9260.c
+++ b/arch/arm/mach-at91/board-qil-a9260.c
@@ -40,10 +40,10 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
-#include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91_shdwc.h>
 
+#include "at91_aic.h"
 #include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-rm9200dk.c b/arch/arm/mach-at91/board-rm9200dk.c
index a91b03c..9e5061b 100644
--- a/arch/arm/mach-at91/board-rm9200dk.c
+++ b/arch/arm/mach-at91/board-rm9200dk.c
@@ -39,10 +39,10 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
-#include <mach/at91_aic.h>
 #include <mach/at91rm9200_mc.h>
 #include <mach/at91_ramc.h>
 
+#include "at91_aic.h"
 #include "board.h"
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-rm9200ek.c b/arch/arm/mach-at91/board-rm9200ek.c
index 7b0be62..58277db 100644
--- a/arch/arm/mach-at91/board-rm9200ek.c
+++ b/arch/arm/mach-at91/board-rm9200ek.c
@@ -39,10 +39,10 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
-#include <mach/at91_aic.h>
 #include <mach/at91rm9200_mc.h>
 #include <mach/at91_ramc.h>
 
+#include "at91_aic.h"
 #include "board.h"
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-rsi-ews.c b/arch/arm/mach-at91/board-rsi-ews.c
index bc5d88a..2e8b833 100644
--- a/arch/arm/mach-at91/board-rsi-ews.c
+++ b/arch/arm/mach-at91/board-rsi-ews.c
@@ -25,10 +25,10 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
-#include <mach/at91_aic.h>
 
 #include <linux/gpio.h>
 
+#include "at91_aic.h"
 #include "board.h"
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-sam9-l9260.c b/arch/arm/mach-at91/board-sam9-l9260.c
index caea7e2..b75fbf6 100644
--- a/arch/arm/mach-at91/board-sam9-l9260.c
+++ b/arch/arm/mach-at91/board-sam9-l9260.c
@@ -37,9 +37,9 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
 
+#include "at91_aic.h"
 #include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-sam9260ek.c b/arch/arm/mach-at91/board-sam9260ek.c
index ac2c949..d0d5fe6 100644
--- a/arch/arm/mach-at91/board-sam9260ek.c
+++ b/arch/arm/mach-at91/board-sam9260ek.c
@@ -41,11 +41,11 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
-#include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91_shdwc.h>
 #include <mach/system_rev.h>
 
+#include "at91_aic.h"
 #include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-sam9261ek.c b/arch/arm/mach-at91/board-sam9261ek.c
index 06251bb..5850eb4 100644
--- a/arch/arm/mach-at91/board-sam9261ek.c
+++ b/arch/arm/mach-at91/board-sam9261ek.c
@@ -45,11 +45,11 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
-#include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91_shdwc.h>
 #include <mach/system_rev.h>
 
+#include "at91_aic.h"
 #include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-sam9263ek.c b/arch/arm/mach-at91/board-sam9263ek.c
index 533c23a..b8443ae 100644
--- a/arch/arm/mach-at91/board-sam9263ek.c
+++ b/arch/arm/mach-at91/board-sam9263ek.c
@@ -44,11 +44,11 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
-#include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91_shdwc.h>
 #include <mach/system_rev.h>
 
+#include "at91_aic.h"
 #include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-sam9g20ek.c b/arch/arm/mach-at91/board-sam9g20ek.c
index 4c6f6e9..7b51238 100644
--- a/arch/arm/mach-at91/board-sam9g20ek.c
+++ b/arch/arm/mach-at91/board-sam9g20ek.c
@@ -43,10 +43,10 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/system_rev.h>
 
+#include "at91_aic.h"
 #include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
index 364a4bf..6b2a983 100644
--- a/arch/arm/mach-at91/board-sam9m10g45ek.c
+++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
@@ -42,11 +42,11 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91_shdwc.h>
 #include <mach/system_rev.h>
 
+#include "at91_aic.h"
 #include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-sam9rlek.c b/arch/arm/mach-at91/board-sam9rlek.c
index 5693caf..6bd8853 100644
--- a/arch/arm/mach-at91/board-sam9rlek.c
+++ b/arch/arm/mach-at91/board-sam9rlek.c
@@ -30,10 +30,11 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
-#include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91_shdwc.h>
 
+
+#include "at91_aic.h"
 #include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-snapper9260.c b/arch/arm/mach-at91/board-snapper9260.c
index b79b56e..9877150 100644
--- a/arch/arm/mach-at91/board-snapper9260.c
+++ b/arch/arm/mach-at91/board-snapper9260.c
@@ -32,9 +32,9 @@
 #include <asm/mach/arch.h>
 
 #include <mach/hardware.h>
-#include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
 
+#include "at91_aic.h"
 #include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-stamp9g20.c b/arch/arm/mach-at91/board-stamp9g20.c
index 5756462..48a962b 100644
--- a/arch/arm/mach-at91/board-stamp9g20.c
+++ b/arch/arm/mach-at91/board-stamp9g20.c
@@ -25,9 +25,9 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
 
+#include "at91_aic.h"
 #include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-usb-a926x.c b/arch/arm/mach-at91/board-usb-a926x.c
index 013dfb6..c93f906 100644
--- a/arch/arm/mach-at91/board-usb-a926x.c
+++ b/arch/arm/mach-at91/board-usb-a926x.c
@@ -41,10 +41,10 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
-#include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91_shdwc.h>
 
+#include "at91_aic.h"
 #include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-yl-9200.c b/arch/arm/mach-at91/board-yl-9200.c
index 5d3a40f..8673aeb 100644
--- a/arch/arm/mach-at91/board-yl-9200.c
+++ b/arch/arm/mach-at91/board-yl-9200.c
@@ -43,11 +43,11 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
-#include <mach/at91_aic.h>
 #include <mach/at91rm9200_mc.h>
 #include <mach/at91_ramc.h>
 #include <mach/cpu.h>
 
+#include "at91_aic.h"
 #include "board.h"
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/irq.c b/arch/arm/mach-at91/irq.c
index febc2ee..8e21026 100644
--- a/arch/arm/mach-at91/irq.c
+++ b/arch/arm/mach-at91/irq.c
@@ -42,7 +42,7 @@
 #include <asm/mach/irq.h>
 #include <asm/mach/map.h>
 
-#include <mach/at91_aic.h>
+#include "at91_aic.h"
 
 void __iomem *at91_aic_base;
 static struct irq_domain *at91_aic_domain;
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 5315f05..e8cb6b8 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -25,10 +25,10 @@
 #include <asm/mach/time.h>
 #include <asm/mach/irq.h>
 
-#include <mach/at91_aic.h>
 #include <mach/at91_pmc.h>
 #include <mach/cpu.h>
 
+#include "at91_aic.h"
 #include "generic.h"
 #include "pm.h"
 
-- 
1.7.10.4
