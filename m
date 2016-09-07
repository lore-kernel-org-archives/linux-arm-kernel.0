From: robin.murphy@arm.com (Robin Murphy)
Date: Wed,  7 Sep 2016 16:02:31 +0100
Subject: [PATCH] arm64: Remove shadowed asm-generic headers
Message-ID: <4c44ef91680ce29dd1c45ef8de846d94f197d381.1473260551.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We've grown our own versions of bug.h, ftrace.h, pci.h and topology.h,
so generating the generic ones as well is unnecessary and a potential
source of build hiccups. At the very least, having them present has
confused my source-indexing tool, and that simply will not do.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm64/include/asm/Kbuild | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index f43d2c44c765..b7cc08abdb26 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -1,4 +1,3 @@
-generic-y += bug.h
 generic-y += bugs.h
 generic-y += clkdev.h
 generic-y += cputime.h
@@ -10,7 +9,6 @@ generic-y += dma-contiguous.h
 generic-y += early_ioremap.h
 generic-y += emergency-restart.h
 generic-y += errno.h
-generic-y += ftrace.h
 generic-y += hw_irq.h
 generic-y += ioctl.h
 generic-y += ioctls.h
@@ -27,7 +25,6 @@ generic-y += mman.h
 generic-y += msgbuf.h
 generic-y += msi.h
 generic-y += mutex.h
-generic-y += pci.h
 generic-y += poll.h
 generic-y += preempt.h
 generic-y += resource.h
@@ -45,7 +42,6 @@ generic-y += swab.h
 generic-y += switch_to.h
 generic-y += termbits.h
 generic-y += termios.h
-generic-y += topology.h
 generic-y += trace_clock.h
 generic-y += types.h
 generic-y += unaligned.h
-- 
2.8.1.dirty
