From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 10 Mar 2016 12:40:01 +0700
Subject: [PATCH 1/8] efi: make install_configuration_table() boot service
 usable
In-Reply-To: <1457588408-19309-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1457588408-19309-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1457588408-19309-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch redeclares efi_boot_services_t::install_configuration_table
as a function pointer so that the boot service is callable as a function.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 include/linux/efi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index e747eb08b2be..8ba6eb7863aa 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -283,7 +283,7 @@ typedef struct {
 	void *register_protocol_notify;
 	void *locate_handle;
 	void *locate_device_path;
-	void *install_configuration_table;
+	efi_status_t (*install_configuration_table)(efi_guid_t *, void *);
 	void *load_image;
 	void *start_image;
 	void *exit;
-- 
1.9.1
