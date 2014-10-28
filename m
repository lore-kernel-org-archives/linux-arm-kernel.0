From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 28 Oct 2014 17:18:38 +0100
Subject: [PATCH v2 05/10] arm64/efi: drop redundant set_bit(EFI_CONFIG_TABLES)
In-Reply-To: <1414513123-20400-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1414513123-20400-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1414513123-20400-6-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The EFI_CONFIG_TABLES bit already gets set by efi_config_init(),
so there is no reason to set it again after this function returns
successfully.

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/efi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 2e829148fb36..558572ef1ea3 100644
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
