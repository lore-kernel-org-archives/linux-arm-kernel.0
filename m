From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  5 Sep 2016 10:23:17 +0100
Subject: [PATCH] arm64: kernel: re-export _cpu_resume() from sleep.S
Message-ID: <1473067397-2648-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit b5fe242972ef ("arm64: kernel: fix style issues in sleep.S")
changed the linkage of _cpu_resume() to local, even though the symbol
is also referenced from hibernate.c. So revert this change.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/sleep.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index 0f7e0b2ac64c..b8799e7c79de 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -107,7 +107,7 @@ ENDPROC(cpu_resume)
 	.ltorg
 	.popsection
 
-_cpu_resume:
+ENTRY(_cpu_resume)
 	mrs	x1, mpidr_el1
 	adr_l	x8, mpidr_hash		// x8 = struct mpidr_hash virt address
 
-- 
2.7.4
