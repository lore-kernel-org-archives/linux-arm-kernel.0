From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat,  5 Jul 2014 13:12:58 +0200
Subject: [PATCH v2 1/4] clocksource: move PXA timer to clocksource framework
Message-ID: <1404558781-9537-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move time.c from arch/arm/mach-pxa/time.c to
drivers/clocksource/pxa_timer.c.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/Makefile                                  | 2 +-
 drivers/clocksource/Makefile                                | 1 +
 arch/arm/mach-pxa/time.c => drivers/clocksource/pxa_timer.c | 0
 3 files changed, 2 insertions(+), 1 deletion(-)
 rename arch/arm/mach-pxa/time.c => drivers/clocksource/pxa_timer.c (100%)

diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
index 648867a..2fe1824 100644
--- a/arch/arm/mach-pxa/Makefile
+++ b/arch/arm/mach-pxa/Makefile
@@ -4,7 +4,7 @@
 
 # Common support (must be linked before board specific support)
 obj-y				+= clock.o devices.o generic.o irq.o \
-				   time.o reset.o
+				   reset.o
 obj-$(CONFIG_PM)		+= pm.o sleep.o standby.o
 
 # Generic drivers that other drivers may depend upon
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 800b130..fc61ef8 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835_timer.o
 obj-$(CONFIG_ARCH_MARCO)	+= timer-marco.o
 obj-$(CONFIG_ARCH_MOXART)	+= moxart_timer.o
 obj-$(CONFIG_ARCH_MXS)		+= mxs_timer.o
+obj-$(CONFIG_ARCH_PXA)		+= pxa_timer.o
 obj-$(CONFIG_ARCH_PRIMA2)	+= timer-prima2.o
 obj-$(CONFIG_ARCH_U300)		+= timer-u300.o
 obj-$(CONFIG_SUN4I_TIMER)	+= sun4i_timer.o
diff --git a/arch/arm/mach-pxa/time.c b/drivers/clocksource/pxa_timer.c
similarity index 100%
rename from arch/arm/mach-pxa/time.c
rename to drivers/clocksource/pxa_timer.c
-- 
2.0.0.rc2
