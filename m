From: sundar.iyer@stericsson.com (Sundar Iyer)
Date: Fri, 21 Jan 2011 10:56:15 +0530
Subject: [PATCH 1/4] mach-ux500: fix ux500 build error
In-Reply-To: <1295587578-14461-1-git-send-email-sundar.iyer@stericsson.com>
References: <1295587578-14461-1-git-send-email-sundar.iyer@stericsson.com>
Message-ID: <1295587578-14461-2-git-send-email-sundar.iyer@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include ab8500 regulators for DB8500 SoC by default
and fix build issues

Signed-off-by: Sundar Iyer <sundar.iyer@stericsson.com>
---
 arch/arm/mach-ux500/Makefile |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index 12052e8..84dc03e 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -4,14 +4,14 @@
 
 obj-y				:= clock.o cpu.o devices.o devices-common.o
 obj-$(CONFIG_UX500_SOC_DB5500)	+= cpu-db5500.o dma-db5500.o
-obj-$(CONFIG_UX500_SOC_DB8500)	+= cpu-db8500.o devices-db8500.o prcmu.o
+obj-$(CONFIG_UX500_SOC_DB8500)	+= cpu-db8500.o devices-db8500.o prcmu.o \
+				   board-mop500-regulators.o
 obj-$(CONFIG_MACH_U8500_MOP)	+= board-mop500.o board-mop500-sdi.o \
-				board-mop500-keypads.o
+				   board-mop500-keypads.o
 obj-$(CONFIG_MACH_U5500)	+= board-u5500.o board-u5500-sdi.o
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
 obj-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
-obj-$(CONFIG_REGULATOR_AB8500)	+= board-mop500-regulators.o
 obj-$(CONFIG_U5500_MODEM_IRQ)	+= modem-irq-db5500.o
 obj-$(CONFIG_U5500_MBOX)	+= mbox-db5500.o
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq.o
-- 
1.7.2.dirty
