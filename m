From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 13 Mar 2015 16:21:18 +0100
Subject: [PATCH] arm64: put __boot_cpu_mode label after alignment instead of
 before
Message-ID: <1426260078-20720-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Another one for the big head.S spring cleaning: the label should
be after the .align or it may point to the padding.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/head.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 3e300bfb0089..9c856f2aa7a5 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -557,8 +557,8 @@ ENDPROC(set_cpu_boot_mode_flag)
  * zeroing of .bss would clobber it.
  */
 	.pushsection	.data..cacheline_aligned
-ENTRY(__boot_cpu_mode)
 	.align	L1_CACHE_SHIFT
+ENTRY(__boot_cpu_mode)
 	.long	BOOT_CPU_MODE_EL2
 	.long	0
 	.popsection
-- 
1.8.3.2
