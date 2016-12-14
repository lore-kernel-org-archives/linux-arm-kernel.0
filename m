From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 14 Dec 2016 10:33:45 +0900
Subject: [PATCH] iopoll: include <linux/ktime.h> instead of <linux/hrtimer.h>
Message-ID: <1481679225-10885-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The timer APIs this header needs are ktime_get(), ktime_add_us(),
and ktime_compare().  So, including <linux/ktime.h> seems enough.
This commit will cut unnecessary header file parsing.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

I was not quite sure whom I should send this patch to.
I am sending this to Will Deacon because commit 54c523127bcc
("iopoll: Introduce memory-mapped IO polling macros") was applied
by him.


 include/linux/iopoll.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
index 1c30014..d29e1e2 100644
--- a/include/linux/iopoll.h
+++ b/include/linux/iopoll.h
@@ -17,7 +17,7 @@
 
 #include <linux/kernel.h>
 #include <linux/types.h>
-#include <linux/hrtimer.h>
+#include <linux/ktime.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/io.h>
-- 
2.7.4
