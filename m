From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 22 Oct 2014 16:21:47 +0200
Subject: [PATCH 04/10] arm64/efi: reserve regions of type ACPI_MEMORY_NVS
In-Reply-To: <1413987713-30528-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1413987713-30528-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1413987713-30528-5-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Memory regions of type ACPI_MEMORY_NVS should be preserved
by the OS, so make sure we reserve them at boot.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/efi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 95c49ebc660d..71ea4fc0aa8a 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -132,6 +132,7 @@ static __init int is_reserve_region(efi_memory_desc_t *md)
 		return 1;
 
 	if (md->type == EFI_ACPI_RECLAIM_MEMORY ||
+	    md->type == EFI_ACPI_MEMORY_NVS ||
 	    md->type == EFI_RESERVED_TYPE)
 		return 1;
 
-- 
1.8.3.2
