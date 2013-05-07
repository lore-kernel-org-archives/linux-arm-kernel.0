From: holt@sgi.com (Robin Holt)
Date: Tue,  7 May 2013 09:39:47 -0500
Subject: [PATCH -v8 03/11] Remove -stable friendly PF_THREAD_BOUND define
In-Reply-To: <1367937595-32241-1-git-send-email-holt@sgi.com>
References: <1367937595-32241-1-git-send-email-holt@sgi.com>
Message-ID: <1367937595-32241-4-git-send-email-holt@sgi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the prior patch's #define for easier backporting to the stable
releases.

Signed-off-by: Robin Holt <holt@sgi.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Russ Anderson <rja@sgi.com>
Cc: Robin Holt <holt@sgi.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: the arch/x86 maintainers <x86@kernel.org>
Cc: Arm Mailing List <linux-arm-kernel@lists.infradead.org>
---
 kernel/sys.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 14640d7..91d2d4e 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -362,11 +362,6 @@ int unregister_reboot_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL(unregister_reboot_notifier);
 
-/* Add backwards compatibility for stable trees. */
-#ifndef PF_NO_SETAFFINITY
-#define PF_NO_SETAFFINITY		PF_THREAD_BOUND
-#endif
-
 static void migrate_to_reboot_cpu(void)
 {
 	/* The boot cpu is always logical cpu 0 */
-- 
1.8.2.1
