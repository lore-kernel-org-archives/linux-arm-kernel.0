From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue,  1 Dec 2015 13:20:40 +0100
Subject: [PATCH] arm64: update linker script to increased L1_CACHE_BYTES value
Message-ID: <1448972440-32633-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bring the linker script in line with the recent increase of
L1_CACHE_BYTES to 128. Replace the hardcoded value of 64 with the
symbolic constant.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/vmlinux.lds.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 1ee2c3937d4e..3388970fbc0f 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -5,6 +5,7 @@
  */
 
 #include <asm-generic/vmlinux.lds.h>
+#include <asm/cache.h>
 #include <asm/kernel-pgtable.h>
 #include <asm/thread_info.h>
 #include <asm/memory.h>
@@ -140,7 +141,7 @@ SECTIONS
 		ARM_EXIT_KEEP(EXIT_DATA)
 	}
 
-	PERCPU_SECTION(64)
+	PERCPU_SECTION(L1_CACHE_BYTES)
 
 	. = ALIGN(PAGE_SIZE);
 	__init_end = .;
-- 
1.9.1
