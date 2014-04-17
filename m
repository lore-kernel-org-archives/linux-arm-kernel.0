From: will.deacon@arm.com (Will Deacon)
Date: Thu, 17 Apr 2014 12:27:56 +0100
Subject: [PATCH] ARM: rwsem: use asm-generic rwsem implementation
Message-ID: <1397734076-11999-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

asm-generic offers an atomic-add based rwsem implementation, which
can avoid the need for heavier, spinlock-based synchronisation on the
fast path.

This patch makes use of the optimised implementation for ARM CPUs.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/Kconfig            | 5 +----
 arch/arm/include/asm/Kbuild | 1 +
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ec962e0b2c9d..b5bf06757052 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -165,12 +165,9 @@ config TRACE_IRQFLAGS_SUPPORT
 	bool
 	default y
 
-config RWSEM_GENERIC_SPINLOCK
-	bool
-	default y
-
 config RWSEM_XCHGADD_ALGORITHM
 	bool
+	default y
 
 config ARCH_HAS_ILOG2_U32
 	bool
diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index 23e728ecf8ab..f5a357601983 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -21,6 +21,7 @@ generic-y += parport.h
 generic-y += poll.h
 generic-y += preempt.h
 generic-y += resource.h
+generic-y += rwsem.h
 generic-y += sections.h
 generic-y += segment.h
 generic-y += sembuf.h
-- 
1.9.1
