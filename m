From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 26 Oct 2015 12:53:17 +0900
Subject: [PATCH] arm64: remove bogus TASK_SIZE_64 check
Message-ID: <1445831597-5680-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The comparison between TASK_SIZE_64 and MODULES_VADDR does not
make any sense on arm64, it is simply something that has been
carried over from the ARM port which arm64 is based on. So drop it.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/memory.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 11ccf6c09533..37f3538a2924 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -70,10 +70,6 @@
 
 #define TASK_UNMAPPED_BASE	(PAGE_ALIGN(TASK_SIZE / 4))
 
-#if TASK_SIZE_64 > MODULES_VADDR
-#error Top of 64-bit user space clashes with start of module space
-#endif
-
 /*
  * Physical vs virtual RAM address space conversion.  These are
  * private definitions which should NOT be used outside memory.h
-- 
2.1.4
