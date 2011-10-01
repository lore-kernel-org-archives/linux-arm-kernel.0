From: arnd@arndb.de (Arnd Bergmann)
Date: Sat,  1 Oct 2011 22:03:44 +0200
Subject: [PATCH 12/26] ARM: pxa: pxa95x/saarb depends on pxa3xx code
In-Reply-To: <1317499438-14058-1-git-send-email-arnd@arndb.de>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
Message-ID: <1317499438-14058-13-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

saarb uses pxa3xx_map_io and pxa3xx_handle_irq, which are part
of the pxa3xx code. This makes sure the necessary header and
implementation is used when building the board file.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/Makefile |    2 +-
 arch/arm/mach-pxa/saarb.c  |    2 ++
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
index cc39d17..be0f7df 100644
--- a/arch/arm/mach-pxa/Makefile
+++ b/arch/arm/mach-pxa/Makefile
@@ -19,7 +19,7 @@ endif
 obj-$(CONFIG_PXA25x)		+= mfp-pxa2xx.o clock-pxa2xx.o pxa2xx.o pxa25x.o
 obj-$(CONFIG_PXA27x)		+= mfp-pxa2xx.o clock-pxa2xx.o pxa2xx.o pxa27x.o
 obj-$(CONFIG_PXA3xx)		+= mfp-pxa3xx.o clock-pxa3xx.o pxa3xx.o smemc.o pxa3xx-ulpi.o
-obj-$(CONFIG_PXA95x)		+= mfp-pxa3xx.o clock-pxa3xx.o pxa95x.o smemc.o
+obj-$(CONFIG_PXA95x)		+= mfp-pxa3xx.o clock-pxa3xx.o pxa3xx.o pxa95x.o smemc.o
 obj-$(CONFIG_CPU_PXA300)	+= pxa300.o
 obj-$(CONFIG_CPU_PXA320)	+= pxa320.o
 obj-$(CONFIG_CPU_PXA930)	+= pxa930.o
diff --git a/arch/arm/mach-pxa/saarb.c b/arch/arm/mach-pxa/saarb.c
index ebd6379..829c514 100644
--- a/arch/arm/mach-pxa/saarb.c
+++ b/arch/arm/mach-pxa/saarb.c
@@ -25,6 +25,8 @@
 #include <mach/mfp-pxa930.h>
 #include <mach/gpio.h>
 
+#include <mach/pxa930.h>
+
 #include "generic.h"
 
 #define SAARB_NR_IRQS	(IRQ_BOARD_START + 40)
-- 
1.7.5.4
