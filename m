From: roy.franz@linaro.org (Roy Franz)
Date: Fri,  9 Aug 2013 16:26:14 -0700
Subject: [PATCH 13/16] resolve warnings found on ARM compile
In-Reply-To: <1376090777-20090-1-git-send-email-roy.franz@linaro.org>
References: <1376090777-20090-1-git-send-email-roy.franz@linaro.org>
Message-ID: <1376090777-20090-14-git-send-email-roy.franz@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2 unused labels
1 "value computed is not used"


Signed-off-by: Roy Franz <roy.franz@linaro.org>
---
 drivers/firmware/efi/efi-stub-helper.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/efi-stub-helper.c b/drivers/firmware/efi/efi-stub-helper.c
index 4bb542f..3e82cb0 100644
--- a/drivers/firmware/efi/efi-stub-helper.c
+++ b/drivers/firmware/efi/efi-stub-helper.c
@@ -166,7 +166,6 @@ again:
 		*addr = max_addr;
 	}
 
-free_pool:
 	efi_call_phys1(sys_table_arg->boottime->free_pool, map);
 
 fail:
@@ -242,7 +241,6 @@ static efi_status_t efi_low_alloc(efi_system_table_t *sys_table_arg,
 	if (i == map_size / desc_size)
 		status = EFI_NOT_FOUND;
 
-free_pool:
 	efi_call_phys1(sys_table_arg->boottime->free_pool, map);
 fail:
 	return status;
@@ -357,7 +355,7 @@ static efi_status_t handle_cmdline_files(efi_system_table_t *sys_table_arg,
 
 			if (*str == '/') {
 				*p++ = '\\';
-				*str++;
+				str++;
 			} else {
 				*p++ = *str++;
 			}
-- 
1.7.10.4
