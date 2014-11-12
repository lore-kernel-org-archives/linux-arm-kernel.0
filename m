From: geoff@infradead.org (Geoff Levand)
Date: Wed, 12 Nov 2014 12:27:30 -0800
Subject: [PATCH] efi: Fix free_end build warning
Message-ID: <1415824050.15847.9.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initialize the free_end variable to zero.  Fixes build warnings
like these:

  arch/arm64/kernel/efi.c: warning: ?free_end? may be used uninitialized in this function

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
Got this with the latest arm64/for-next/core branch.  Please consider.

-Geoff 

 arch/arm64/kernel/efi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 4f39a18..83fc53c 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -239,6 +239,7 @@ static void __init free_boot_services(void)
 	 * want to keep for UEFI.
 	 */
 
+	free_end = 0;
 	keep_end = 0;
 	free_start = 0;
 
-- 
1.9.1
