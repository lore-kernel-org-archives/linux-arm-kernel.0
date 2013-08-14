From: arm-kernel@ml.breakpoint.cc (Sebastian Andrzej Siewior)
Date: Wed, 14 Aug 2013 16:43:57 +0200
Subject: [PATCH 2/2 v3] arm: Allow forced irq threading
In-Reply-To: <520B5725.7000907@ti.com>
References: <20130214205204.109023136@linutronix.de>
 <20130214205304.993009840@linutronix.de>
 <20130214214931.GK17833@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1302142256520.22263@ionos>
 <20130812200301.GB4181@breakpoint.cc> <520B5725.7000907@ti.com>
Message-ID: <20130814144357.GA4269@breakpoint.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Gleixner <tglx@linutronix.de>

All timer interrupts and the perf interrupt are marked NO_THREAD, so
its safe to allow forced interrupt threading.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 43594d5..6858b3a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -52,6 +52,7 @@ config ARM
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UID16
+	select IRQ_FORCED_THREADING
 	select KTIME_SCALAR
 	select PERF_USE_VMALLOC
 	select RTC_LIB
-- 
1.8.4.rc1
