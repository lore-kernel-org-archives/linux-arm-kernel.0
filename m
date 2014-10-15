From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Wed, 15 Oct 2014 16:50:04 +0400
Subject: [PATCH 1/2] clocksource: enable pxa_timer for SA-1100 platform
Message-ID: <1413377405-7503-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SA-11x0 platform used the same IP block as was used on PXA. Consequently
it makes sense to have only one driver. Enable pxa_timer clocksource for
StrongARM platform.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/clocksource/Kconfig  | 6 ++++++
 drivers/clocksource/Makefile | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index cfd6519..fd99b08 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -216,4 +216,10 @@ config CLKSRC_VERSATILE
 	  ARM Versatile, RealView and Versatile Express reference
 	  platforms.
 
+config CLKSRC_PXA
+	def_bool y if ARCH_PXA || ARCH_SA1100
+	help
+	  This enables OST0 support available on PXA and SA-11x0
+	  platforms.
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 7fd9fd1..6d9822e 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -20,7 +20,7 @@ obj-$(CONFIG_ARCH_CLPS711X)	+= clps711x-timer.o
 obj-$(CONFIG_ARCH_MARCO)	+= timer-marco.o
 obj-$(CONFIG_ARCH_MOXART)	+= moxart_timer.o
 obj-$(CONFIG_ARCH_MXS)		+= mxs_timer.o
-obj-$(CONFIG_ARCH_PXA)		+= pxa_timer.o
+obj-$(CONFIG_CLKSRC_PXA)	+= pxa_timer.o
 obj-$(CONFIG_ARCH_PRIMA2)	+= timer-prima2.o
 obj-$(CONFIG_ARCH_U300)		+= timer-u300.o
 obj-$(CONFIG_SUN4I_TIMER)	+= sun4i_timer.o
-- 
2.1.1
