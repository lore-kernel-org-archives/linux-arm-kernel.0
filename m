From: alekskartashov@parallels.com (Alexander Kartashov)
Date: Wed, 19 Dec 2012 17:27:55 +0400
Subject: [PATCH 1/3] kcmp: Include linux/ptrace.h
In-Reply-To: <1355923677-18249-1-git-send-email-alekskartashov@parallels.com>
References: <1355923677-18249-1-git-send-email-alekskartashov@parallels.com>
Message-ID: <1355923677-18249-2-git-send-email-alekskartashov@parallels.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyrill Gorcunov <gorcunov@openvz.org>

This makes it compile on s390. After all the ptrace_may_access
(which we use this file) is declared exactly in linux/ptrace.h.

This is preparatory work to wire this syscall up on all archs.

Original-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Cyrill Gorcunov <gorcunov@openvz.org>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Eric W. Biederman <ebiederm@xmission.com>
CC: Pavel Emelyanov <xemul@parallels.com>
CC: Alexander Kartashov <alekskartashov@parallels.com>
Signed-off-by: Alexander Kartashov <alekskartashov@parallels.com>
---
 kernel/kcmp.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/kcmp.c b/kernel/kcmp.c
index 30b7b22..e30ac0f 100644
--- a/kernel/kcmp.c
+++ b/kernel/kcmp.c
@@ -4,6 +4,7 @@
 #include <linux/string.h>
 #include <linux/random.h>
 #include <linux/module.h>
+#include <linux/ptrace.h>
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/cache.h>
-- 
1.7.9.5
