From: yalin.wang2010@gmail.com (yalin wang)
Date: Fri, 16 Oct 2015 18:46:07 +0800
Subject: [PATCH] arm64: change to use memmove in efi-stub
Message-ID: <1444992367-11121-1-git-send-email-yalin.wang2010@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change to use memmove(), in case the dest address overlap with the
source address.

Signed-off-by: yalin wang <yalin.wang2010@gmail.com>
---
 arch/arm64/kernel/efi-stub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/efi-stub.c b/arch/arm64/kernel/efi-stub.c
index 816120e..b6dc44b 100644
--- a/arch/arm64/kernel/efi-stub.c
+++ b/arch/arm64/kernel/efi-stub.c
@@ -59,7 +59,7 @@ efi_status_t __init handle_kernel_image(efi_system_table_t *sys_table_arg,
 			}
 			*image_addr = *reserve_addr + TEXT_OFFSET;
 		}
-		memcpy((void *)*image_addr, old_image_addr, kernel_size);
+		memmove((void *)*image_addr, old_image_addr, kernel_size);
 		*reserve_size = kernel_memsize;
 	}
 
-- 
1.9.1
