From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 11 Jul 2016 21:00:46 +0200
Subject: [PATCH v2 2/2] efi/arm*: esrt: add missing call to efi_esrt_init()
In-Reply-To: <1468263646-28184-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1468263646-28184-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1468263646-28184-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ESRT support is built by default for all architectures that define
CONFIG_EFI. However, this support was not wired up yet for ARM/arm64,
since efi_esrt_init() was never called. So add the missing call.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/arm-init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
index 5a2df3fefccc..e0a511d4074f 100644
--- a/drivers/firmware/efi/arm-init.c
+++ b/drivers/firmware/efi/arm-init.c
@@ -247,6 +247,7 @@ void __init efi_init(void)
 
 	reserve_regions();
 	efi_memattr_init();
+	efi_esrt_init();
 	efi_memmap_unmap();
 
 	memblock_reserve(params.mmap & PAGE_MASK,
-- 
1.9.1
