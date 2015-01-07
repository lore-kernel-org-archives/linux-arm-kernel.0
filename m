From: wangnan0@huawei.com (Wang Nan)
Date: Wed, 7 Jan 2015 15:35:42 +0800
Subject: [RFC PATCH 05/11] kprobes: Add an KPROBE_FLAG_EARLY for early kprobe.
In-Reply-To: <1420616086-42692-1-git-send-email-wangnan0@huawei.com>
References: <1420616086-42692-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1420616142-42937-1-git-send-email-wangnan0@huawei.com>
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
index 1ab5475..fa0de88 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -128,6 +128,7 @@ struct kprobe {
 				   * this flag is only for optimized_kprobe.
 				   */
 #define KPROBE_FLAG_FTRACE	8 /* probe is using ftrace */
+#define KPROBE_FLAG_EARLY	16 /* early kprobe */
 
 /* Has this kprobe gone ? */
 static inline int kprobe_gone(struct kprobe *p)
-- 
1.8.4
