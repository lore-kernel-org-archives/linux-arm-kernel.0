From: will.deacon@arm.com (Will Deacon)
Date: Tue, 19 Jul 2016 15:07:40 +0100
Subject: [PATCH 4/4] arm64: debug: remove unused local_dbg_{enable,
 disable} macros
In-Reply-To: <1468937260-23988-1-git-send-email-will.deacon@arm.com>
References: <1468937260-23988-1-git-send-email-will.deacon@arm.com>
Message-ID: <1468937260-23988-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The debug enable/disable macros are not used anywhere in the kernel, so
remove them from irqflags.h

Reported-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/irqflags.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
index 11cc941bd107..8c581281fa12 100644
--- a/arch/arm64/include/asm/irqflags.h
+++ b/arch/arm64/include/asm/irqflags.h
@@ -110,8 +110,5 @@ static inline int arch_irqs_disabled_flags(unsigned long flags)
 		: : "r" (flags) : "memory");				\
 	} while (0)
 
-#define local_dbg_enable()	asm("msr	daifclr, #8" : : : "memory")
-#define local_dbg_disable()	asm("msr	daifset, #8" : : : "memory")
-
 #endif
 #endif
-- 
2.1.4
