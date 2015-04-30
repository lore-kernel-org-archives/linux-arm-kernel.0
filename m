From: shenwei.wang@freescale.com (Shenwei Wang)
Date: Thu, 30 Apr 2015 09:44:33 -0500
Subject: [PATCH 18/18] ARM: imx: Move time.c into drivers/clocksources
In-Reply-To: <1430405073-13106-1-git-send-email-shenwei.wang@freescale.com>
References: <1430405073-13106-1-git-send-email-shenwei.wang@freescale.com>
Message-ID: <1430405073-13106-19-git-send-email-shenwei.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The time.c was moved from arch/arm/mach-imx to
drivers/clocksources, and its name was changed
to timer-gpt.c.

Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
---
 arch/arm/mach-imx/Makefile                                  | 2 +-
 drivers/clocksource/Makefile                                | 1 +
 arch/arm/mach-imx/time.c => drivers/clocksource/timer-gpt.c | 0
 3 files changed, 2 insertions(+), 1 deletion(-)
 rename arch/arm/mach-imx/time.c => drivers/clocksource/timer-gpt.c (100%)

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 0622ced..08dc2f1 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -1,4 +1,4 @@
-obj-y := time.o cpu.o system.o irq-common.o
+obj-y := cpu.o system.o irq-common.o
 
 obj-$(CONFIG_SOC_IMX1) += mm-imx1.o
 obj-$(CONFIG_SOC_IMX21) += mm-imx21.o
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 5b85f6a..28bb2e6 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -52,3 +52,4 @@ obj-$(CONFIG_ARCH_INTEGRATOR_AP)	+= timer-integrator-ap.o
 obj-$(CONFIG_CLKSRC_VERSATILE)		+= versatile.o
 obj-$(CONFIG_CLKSRC_MIPS_GIC)		+= mips-gic-timer.o
 obj-$(CONFIG_ASM9260_TIMER)		+= asm9260_timer.o
+obj-$(CONFIG_ARCH_MXC)			+= timer-gpt.o
diff --git a/arch/arm/mach-imx/time.c b/drivers/clocksource/timer-gpt.c
similarity index 100%
rename from arch/arm/mach-imx/time.c
rename to drivers/clocksource/timer-gpt.c
-- 
1.9.1
