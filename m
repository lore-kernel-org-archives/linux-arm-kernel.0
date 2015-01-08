From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu,  8 Jan 2015 18:48:31 +0000
Subject: [PATCH v5 5/8] arm64/efi: set EFI_ALLOC_ALIGN to 64 KB
In-Reply-To: <1420742914-2404-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1420742914-2404-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1420742914-2404-6-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set EFI_ALLOC_ALIGN to 64 KB so that all allocations done by the stub
are naturally compatible with a 64 KB granule kernel.

Acked-by: Leif Lindholm <leif.lindholm@linaro.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/efi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index a34fd3b12e2b..71291253114f 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -44,4 +44,6 @@ extern void efi_idmap_init(void);
 
 #define efi_call_early(f, ...) sys_table_arg->boottime->f(__VA_ARGS__)
 
+#define EFI_ALLOC_ALIGN		SZ_64K
+
 #endif /* _ASM_EFI_H */
-- 
1.8.3.2
