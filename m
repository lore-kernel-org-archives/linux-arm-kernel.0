From: arm-kernel@ml.breakpoint.cc (Sebastian Andrzej Siewior)
Date: Mon, 12 Aug 2013 22:03:01 +0200
Subject: [PATCH 2/2 v2] arm: Allow forced irq threading
In-Reply-To: <alpine.LFD.2.02.1302142256520.22263@ionos>
References: <20130214205204.109023136@linutronix.de>
 <20130214205304.993009840@linutronix.de>
 <20130214214931.GK17833@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1302142256520.22263@ionos>
Message-ID: <20130812200301.GB4181@breakpoint.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Gleixner <tglx@linutronix.de>

All timer interrupts and the perf interrupt are marked NO_THREAD, so
its safe to allow forced interrupt threading.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
On Thu, Feb 14, 2013 at 11:04:48PM +0100, Thomas Gleixner wrote:
> On Thu, 14 Feb 2013, Russell King - ARM Linux wrote:
> 
> > What effect does this have on IRQ latency, particularly on the slower CPUs?
> 
> It does not affect anything unless you add "threadirqs" to the kernel
> command line. This command line argument puts the kernel into forced
> irq threading mode. Otherwise it just works as now.

I reposted the patch since it no longer applies clean on v3.11-rc5. From what
tglx explained, I don't think there are any outstanding issues, are there?

 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 43594d5..405e4c0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -20,6 +20,7 @@ config ARM
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
 	select HARDIRQS_SW_RESEND
+	select IRQ_FORCED_THREADING
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_SECCOMP_FILTER
-- 
1.8.4.rc1
