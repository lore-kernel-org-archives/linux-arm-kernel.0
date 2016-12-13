From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 14 Dec 2016 10:21:09 +1100
Subject: [GIT PULL] arm64 updates for 4.10
In-Reply-To: <20161213192156.GA12471@e104818-lin.cambridge.arm.com>
References: <20161213192156.GA12471@e104818-lin.cambridge.arm.com>
Message-ID: <20161214102109.41c522f1@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Tue, 13 Dec 2016 19:21:59 +0000 Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> Please pull the arm64 updates for 4.10 below.
> 
> The patches touch the generic include/linux/thread_info.h to factor out
> struct restart_block into a separate include/linux/restart_block.h file
> (needed for arm64 moving thread_info off stack; acked by Andy
> Lutomirski).
> 
> There is also a small refactoring touching drivers/irqchip/irq-gic-v3.c
> and additional watchpoint lengths added to
> include/uapi/linux/hw_breakpoint.h.

I have also been carrying a merge fix up patch due to a conflict in the
merge of the arm64 tree with commit

  272d01bd790f ("arm64: Fix circular include of asm/lse.h through linux/jump_label.h")

from v4.9-rc5:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 22 Nov 2016 10:30:40 +1100
Subject: [PATCH] arm64: merge fix for code movement to cpucaps.h

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/arm64/include/asm/cpucaps.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 87b446535185..4174f09678c4 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -34,7 +34,8 @@
 #define ARM64_HAS_32BIT_EL0			13
 #define ARM64_HYP_OFFSET_LOW			14
 #define ARM64_MISMATCHED_CACHE_LINE_SIZE	15
+#define ARM64_HAS_NO_FPSIMD			16
 
-#define ARM64_NCAPS				16
+#define ARM64_NCAPS				17
 
 #endif /* __ASM_CPUCAPS_H */
-- 
2.10.2

-- 
Cheers,
Stephen Rothwell
