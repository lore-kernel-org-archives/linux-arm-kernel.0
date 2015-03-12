From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 12 Mar 2015 18:38:10 +0100
Subject: [RFT/RFC PATCH 4/6] ARM: use bl_far to call
 __hyp_stub_install_secondary from the .data section
In-Reply-To: <1426181892-15440-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1426181892-15440-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1426181892-15440-5-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/kernel/sleep.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index e1e60e5a7a27..0ea3813fedce 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -128,7 +128,7 @@ ENDPROC(cpu_resume_after_mmu)
 ENTRY(cpu_resume)
 ARM_BE8(setend be)			@ ensure we are in BE mode
 #ifdef CONFIG_ARM_VIRT_EXT
-	bl	__hyp_stub_install_secondary
+	bl_far	__hyp_stub_install_secondary
 #endif
 	safe_svcmode_maskall r1
 	mov	r1, #0
-- 
1.8.3.2
