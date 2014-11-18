From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 18 Nov 2014 13:57:12 +0100
Subject: [PATCH v3 13/13] arm64/efi: set EFI_ALLOC_ALIGN to 64 KB
In-Reply-To: <1416315432-8534-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1416315432-8534-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1416315432-8534-14-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set EFI_ALLOC_ALIGN to 64 KB so that all allocations done by the stub
are naturally compatible with a 64 KB granule kernel.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/efi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 5420ad5a4c63..18d4a764d630 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -48,6 +48,8 @@ extern void efi_init(void);
 
 #define efi_call_early(f, ...) sys_table_arg->boottime->f(__VA_ARGS__)
 
+#define EFI_ALLOC_ALIGN		SZ_64K
+
 void efi_set_pgd(struct mm_struct *mm);
 
 #endif /* _ASM_EFI_H */
-- 
1.8.3.2
