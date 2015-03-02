From: wangnan0@huawei.com (Wang Nan)
Date: Mon, 2 Mar 2015 22:24:55 +0800
Subject: [RFC PATCH v4 17/34] early kprobes: run kprobes smoke test for early
 kprobes.
In-Reply-To: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
References: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1425306312-3437-18-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We are able to use early kprobes. Do some small test for early kprobes.
Note that, previous patches makes init_test_probes() behaviors
differently when kprobe_is_early().

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 kernel/kprobes.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 7dbe8b2..4b7b20a 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2258,6 +2258,10 @@ void init_kprobes_early(void)
 		err = register_module_notifier(&kprobe_module_nb);
 
 	kprobes_initialized = (err == 0);
+#ifdef CONFIG_EARLY_KPROBES
+	if (!err)
+		init_test_probes();
+#endif
 }
 
 static int __init init_kprobes(void)
-- 
1.8.4
