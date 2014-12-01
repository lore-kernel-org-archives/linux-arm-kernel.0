From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue,  2 Dec 2014 02:47:23 +0300
Subject: [PATCH v2 1/4] clocksource: enable pxa_timer for SA-1100 platform
In-Reply-To: <1417477646-14278-1-git-send-email-dbaryshkov@gmail.com>
References: <1417477646-14278-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1417477646-14278-2-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SA-11x0 platform used the same IP block as was used on PXA. Consequently
it makes sense to have only one driver. Enable pxa_timer clocksource for
StrongARM platform.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/clocksource/Kconfig  | 6 ++++++
 drivers/clocksource/Makefile | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 9042060..46fdca1 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -223,4 +223,10 @@ config CLKSRC_VERSATILE
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
index 756f6f1..0b55b40 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -21,7 +21,7 @@ obj-$(CONFIG_ARCH_CLPS711X)	+= clps711x-timer.o
 obj-$(CONFIG_ARCH_MARCO)	+= timer-marco.o
 obj-$(CONFIG_ARCH_MOXART)	+= moxart_timer.o
 obj-$(CONFIG_ARCH_MXS)		+= mxs_timer.o
-obj-$(CONFIG_ARCH_PXA)		+= pxa_timer.o
+obj-$(CONFIG_CLKSRC_PXA)	+= pxa_timer.o
 obj-$(CONFIG_ARCH_PRIMA2)	+= timer-prima2.o
 obj-$(CONFIG_ARCH_U300)		+= timer-u300.o
 obj-$(CONFIG_SUN4I_TIMER)	+= sun4i_timer.o
-- 
2.1.3
