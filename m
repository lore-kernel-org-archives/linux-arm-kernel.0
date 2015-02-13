From: wangnan0@huawei.com (Wang Nan)
Date: Fri, 13 Feb 2015 13:41:17 +0800
Subject: [RFC PATCH v3 25/26] early kprobes: introduce kconfig option to
 support early kprobe on ftrace.
In-Reply-To: <1423805941-61407-1-git-send-email-wangnan0@huawei.com>
References: <1423805941-61407-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1423806077-62523-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On platform (like x86) which supports CONFIG_KPROBE_ON_FTRACE, makes
early kprobe depend on it so we are able to probe function entries.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 arch/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 32e9f4a..79f809d 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -48,7 +48,7 @@ config KPROBES
 
 config EARLY_KPROBES
 	bool "Enable kprobes at very early booting stage"
-	depends on KPROBES && OPTPROBES
+	depends on KPROBES && OPTPROBES && (KPROBES_ON_FTRACE || !HAVE_KPROBES_ON_FTRACE)
 	def_bool y
 	help
 	  Enable kprobe at very early booting stage.
-- 
1.8.4
