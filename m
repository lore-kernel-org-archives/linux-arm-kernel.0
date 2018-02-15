From: will.deacon@arm.com (Will Deacon)
Date: Thu, 15 Feb 2018 15:29:32 +0000
Subject: [RFC PATCH 2/5] asm-generic: Avoid including linux/kernel.h in
 asm-generic/bug.h
In-Reply-To: <1518708575-12284-1-git-send-email-will.deacon@arm.com>
References: <1518708575-12284-1-git-send-email-will.deacon@arm.com>
Message-ID: <1518708575-12284-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

asm-generic/bug.h unnecessarily includes linux/kernel.h whereas it can
get away with linux/types.h instead. lib/errseq.c relies on this transitive
include, so update it to include linux/kernel.h instead.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/asm-generic/bug.h | 2 +-
 lib/errseq.c              | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 963b755d19b0..ffda1247f639 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -15,7 +15,7 @@
 #endif
 
 #ifndef __ASSEMBLY__
-#include <linux/kernel.h>
+#include <linux/types.h>
 
 #ifdef CONFIG_BUG
 
diff --git a/lib/errseq.c b/lib/errseq.c
index df782418b333..ef3b10516eab 100644
--- a/lib/errseq.c
+++ b/lib/errseq.c
@@ -3,6 +3,7 @@
 #include <linux/bug.h>
 #include <linux/atomic.h>
 #include <linux/errseq.h>
+#include <linux/kernel.h>
 
 /*
  * An errseq_t is a way of recording errors in one place, and allowing any
-- 
2.1.4
