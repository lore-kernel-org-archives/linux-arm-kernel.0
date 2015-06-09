From: robh@kernel.org (Rob Herring)
Date: Tue,  9 Jun 2015 13:26:41 -0500
Subject: [PATCH 15/15] arm64: remove ununsed set_irq_flags
In-Reply-To: <1433874401-27161-1-git-send-email-robh@kernel.org>
References: <1433874401-27161-1-git-send-email-robh@kernel.org>
Message-ID: <1433874401-27161-16-git-send-email-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that all users of set_irq_flags and custom flags are converted to
genirq functions, the ARM specific set_irq_flags can be removed.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm64/include/asm/hardirq.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm64/include/asm/hardirq.h b/arch/arm64/include/asm/hardirq.h
index 6aae421..1679d22 100644
--- a/arch/arm64/include/asm/hardirq.h
+++ b/arch/arm64/include/asm/hardirq.h
@@ -47,9 +47,4 @@ static inline void ack_bad_irq(unsigned int irq)
 	irq_err_count++;
 }
 
-/*
- * No arch-specific IRQ flags.
- */
-#define set_irq_flags(irq, flags)
-
 #endif /* __ASM_HARDIRQ_H */
-- 
2.1.0
