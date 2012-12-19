From: alekskartashov@parallels.com (Alexander Kartashov)
Date: Wed, 19 Dec 2012 20:44:29 +0400
Subject: [PATCH 2/3] kcmp: Drop x86 dependancy
In-Reply-To: <1355935470-21001-1-git-send-email-alekskartashov@parallels.com>
References: <20689.54803.684081.31731@pilspetsen.it.uu.se>
 <1355935470-21001-1-git-send-email-alekskartashov@parallels.com>
Message-ID: <1355935470-21001-3-git-send-email-alekskartashov@parallels.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyrill Gorcunov <gorcunov@openvz.org>

Signed-off-by: Cyrill Gorcunov <gorcunov@openvz.org>
Signed-off-by: Alexander Kartashov <alekskartashov@parallels.com>
---
 kernel/Makefile |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/Makefile b/kernel/Makefile
index 86e3285..9f7a139 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -25,9 +25,7 @@ endif
 obj-y += sched/
 obj-y += power/
 
-ifeq ($(CONFIG_CHECKPOINT_RESTORE),y)
-obj-$(CONFIG_X86) += kcmp.o
-endif
+obj-$(CONFIG_CHECKPOINT_RESTORE) += kcmp.o
 obj-$(CONFIG_FREEZER) += freezer.o
 obj-$(CONFIG_PROFILING) += profile.o
 obj-$(CONFIG_STACKTRACE) += stacktrace.o
-- 
1.7.9.5
