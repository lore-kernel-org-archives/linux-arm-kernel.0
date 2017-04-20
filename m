From: strongbox8@zoho.com (Perr Zhang)
Date: Thu, 20 Apr 2017 12:55:56 +0800
Subject: [PATCH] arm: alignment: update comments on /proc/cpu/alignment
Message-ID: <1492664156-6136-1-git-send-email-strongbox8@zoho.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The path name in the comment is out of date, update it.

Signed-off-by: Perr Zhang <strongbox8@zoho.com>
---
 arch/arm/mm/alignment.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index 2c96190..db9c2cf 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -33,8 +33,12 @@
 
 /*
  * 32-bit misaligned trap handler (c) 1998 San Mehat (CCC) -July 1998
- * /proc/sys/debug/alignment, modified and integrated into
- * Linux 2.1 by Russell King
+ * /proc/cpu/alignment, modified and integrated into Linux 2.1 by Russell King
+ * Note:
+ *     The path name may be different for very old versions of Linux,
+ *     i.e, /proc/sys/debug/alignment for Linux 2.1.
+ *     This was relocated because it was in conflict with sysctl(/proc/sys/)
+ *     and it doesn't contain sysctl information.
  *
  * Speed optimisations and better fault handling by Russell King.
  *
@@ -985,10 +989,8 @@ static int __init noalign_setup(char *__unused)
 __setup("noalign", noalign_setup);
 
 /*
- * This needs to be done after sysctl_init, otherwise sys/ will be
- * overwritten.  Actually, this shouldn't be in sys/ at all since
- * it isn't a sysctl, and it doesn't contain sysctl information.
- * We now locate it in /proc/cpu/alignment instead.
+ * Refer to Documentation/arm/mem_alignment for
+ * usage of /proc/cpu/alignment.
  */
 static int __init alignment_init(void)
 {
-- 
1.9.3
