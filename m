From: wangnan0@huawei.com (Wang Nan)
Date: Thu, 12 Feb 2015 20:20:24 +0800
Subject: [RFC PATCH v2 12/26] early kprobes: Add an KPROBE_FLAG_EARLY for
 early kprobe.
In-Reply-To: <1423743476-11927-1-git-send-email-wangnan0@huawei.com>
References: <1423743476-11927-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1423743624-12541-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce a KPROBE_FLAG_EARLY for futher expansion. KPROBE_FLAG_EARLY
indicates a kprobe is installed at very early stage, its resources
should be allocated statically.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 include/linux/kprobes.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index e1c8307..8d2e754 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -130,6 +130,7 @@ struct kprobe {
 				   * this flag is only for optimized_kprobe.
 				   */
 #define KPROBE_FLAG_FTRACE	8 /* probe is using ftrace */
+#define KPROBE_FLAG_EARLY	16 /* early kprobe */
 
 /* Has this kprobe gone ? */
 static inline int kprobe_gone(struct kprobe *p)
-- 
1.8.4
