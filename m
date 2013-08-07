From: roy.franz@linaro.org (Roy Franz)
Date: Tue,  6 Aug 2013 20:45:07 -0700
Subject: [PATCH 11/17] Move EFI_READ_CHUNK_SIZE define to shared location.
In-Reply-To: <1375847113-24884-1-git-send-email-roy.franz@linaro.org>
References: <1375847113-24884-1-git-send-email-roy.franz@linaro.org>
Message-ID: <1375847113-24884-12-git-send-email-roy.franz@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This #define is only used the the shared code, so move
it there.

Signed-off-by: Roy Franz <roy.franz@linaro.org>
---
 arch/x86/boot/compressed/eboot.h       |    1 -
 drivers/firmware/efi/efi-stub-helper.c |    2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.h b/arch/x86/boot/compressed/eboot.h
index faa0bdf..bafbd94 100644
--- a/arch/x86/boot/compressed/eboot.h
+++ b/arch/x86/boot/compressed/eboot.h
@@ -12,7 +12,6 @@
 #define DESC_TYPE_CODE_DATA	(1 << 0)
 
 #define EFI_PAGE_SIZE		(1UL << EFI_PAGE_SHIFT)
-#define EFI_READ_CHUNK_SIZE	(1024 * 1024)
 
 #define EFI_CONSOLE_OUT_DEVICE_GUID    \
 	EFI_GUID(0xd3b36f2c, 0xd551, 0x11d4, 0x9a, 0x46, 0x0, 0x90, 0x27, \
diff --git a/drivers/firmware/efi/efi-stub-helper.c b/drivers/firmware/efi/efi-stub-helper.c
index 0a41638..521a4c4 100644
--- a/drivers/firmware/efi/efi-stub-helper.c
+++ b/drivers/firmware/efi/efi-stub-helper.c
@@ -9,7 +9,7 @@
  * under the terms of the GNU General Public License version 2.
  *
  */
-
+#define EFI_READ_CHUNK_SIZE	(1024 * 1024)
 
 struct file_info {
 	efi_file_handle_t *handle;
-- 
1.7.10.4
