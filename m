From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 22 Oct 2014 16:21:48 +0200
Subject: [PATCH 05/10] arm64/efi: drop redundant set_bit(EFI_CONFIG_TABLES)
In-Reply-To: <1413987713-30528-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1413987713-30528-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1413987713-30528-6-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The EFI_CONFIG_TABLES bit already gets set by efi_config_init(),
so there is no reason to set it again after this function returns
successfully.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/efi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 71ea4fc0aa8a..51522ab0c6da 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -112,8 +112,6 @@ static int __init uefi_init(void)
 		efi.systab->hdr.revision & 0xffff, vendor);
 
 	retval = efi_config_init(NULL);
-	if (retval == 0)
-		set_bit(EFI_CONFIG_TABLES, &efi.flags);
 
 out:
 	early_memunmap(efi.systab,  sizeof(efi_system_table_t));
-- 
1.8.3.2
