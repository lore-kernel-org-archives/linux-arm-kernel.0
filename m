From: jarkko.nikula@bitmer.com (Jarkko Nikula)
Date: Fri, 21 Oct 2011 14:04:03 +0300
Subject: [PATCH arm-soc.git/for-next] ARM: l2x0: Fix merge typo with "ARM:
	l2x0: add empty l2x0_of_init"
Message-ID: <1319195043-20268-1-git-send-email-jarkko.nikula@bitmer.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix build error "error: implicit declaration of function 'l2x0_init'" if
CONFIG_OF is not set. This looks like to be caused by some manual typo when
committing or merging as this is not in the original patch.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Rob Herring <rob.herring@calxeda.com>
---
See commits 5260f15 and d94527d, tree version and the original patch
http://lists.infradead.org/pipermail/linux-arm-kernel/2011-August/063478.html
I'm ok if those commits are dropped and replaced with original one.
---
 arch/arm/include/asm/hardware/cache-l2x0.h |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
index e38ac93..662563d 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -101,7 +101,6 @@
 #define L2X0_ADDR_FILTER_EN		1
 
 #ifndef __ASSEMBLY__
-#if defined(CONFIG_CACHE_L2X0) && defined(CONFIG_OF)
 extern void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask);
 #if defined(CONFIG_CACHE_L2X0) && defined(CONFIG_OF)
 extern int l2x0_of_init(__u32 aux_val, __u32 aux_mask);
@@ -130,6 +129,4 @@ struct l2x0_regs {
 
 extern struct l2x0_regs l2x0_saved_regs;
 
-#endif /* __ASSEMBLY__ */
-
 #endif
-- 
1.7.6.3
