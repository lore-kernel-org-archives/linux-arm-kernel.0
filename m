From: will.deacon@arm.com (Will Deacon)
Date: Tue, 19 Jun 2018 13:22:54 +0100
Subject: [PATCH] arm: Hook up SYNC_CORE functionality for sys_membarrier()
Message-ID: <1529410974-18929-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exception return implies context synchronization, so we can hook up the
SYNC_CORE option to sys_membarrier() simply by selecting the Kconfig option,
just like we've done for arm64 already.

Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Orion Hodson <oth@google.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 54eeb8d00bc6..b0ac18547370 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -9,6 +9,7 @@ config ARM
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_KCOV
+	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_PTE_SPECIAL if ARM_LPAE
 	select ARCH_HAS_PHYS_TO_DMA
 	select ARCH_HAS_SET_MEMORY
-- 
2.1.4
