From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 15 Apr 2014 20:16:03 +0200
Subject: [PATCH 5/5] ARM: iwmmxt: allow to build iWMMXt on Marvell PJ4B
In-Reply-To: <1397585763-23482-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <20140414151236.75f8816d@skate>
 <1397585763-23482-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1397585763-23482-6-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some Marvell PJ4B CPUs also implement iWMMXt extensions. With a
proper check for iWMMXt coprocessors now in place, enable it by
default on PJ4B. While at it, also allow to manually select
the corresponding Kconfig option.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Chao Xie <xiechao.mail@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/Kconfig         | 6 +++---
 arch/arm/kernel/Makefile | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ab438cb5af55..fcf36d11f922 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1110,9 +1110,9 @@ config ARM_NR_BANKS
 	default 8
 
 config IWMMXT
-	bool "Enable iWMMXt support" if !CPU_PJ4
-	depends on CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_PJ4
-	default y if PXA27x || PXA3xx || ARCH_MMP || CPU_PJ4
+	bool "Enable iWMMXt support"
+	depends on CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_PJ4 || CPU_PJ4B
+	default y if PXA27x || PXA3xx || ARCH_MMP || CPU_PJ4 || CPU_PJ4B
 	help
 	  Enable support for iWMMXt context switching at run time if
 	  running on a CPU that supports it.
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index a766bcbaf8ad..040619c32d68 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -79,6 +79,7 @@ obj-$(CONFIG_CPU_XSCALE)	+= xscale-cp0.o
 obj-$(CONFIG_CPU_XSC3)		+= xscale-cp0.o
 obj-$(CONFIG_CPU_MOHAWK)	+= xscale-cp0.o
 obj-$(CONFIG_CPU_PJ4)		+= pj4-cp0.o
+obj-$(CONFIG_CPU_PJ4B)		+= pj4-cp0.o
 obj-$(CONFIG_IWMMXT)		+= iwmmxt.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_regs.o
 obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o perf_event_cpu.o
-- 
1.9.1
