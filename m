From: wangnan0@huawei.com (Wang Nan)
Date: Thu, 12 Feb 2015 20:21:30 +0800
Subject: [RFC PATCH v2 25/26] early kprobes: introduce kconfig option to
 support early kprobe on ftrace.
In-Reply-To: <1423743476-11927-1-git-send-email-wangnan0@huawei.com>
References: <1423743476-11927-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1423743690-13118-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On platform (like x86) which supports CONFIG_KPROBE_ON_FTRACE, makes
early kprobe depend on it so we are able to probe function entries.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 arch/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 06dff4b..7225386 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -47,7 +47,7 @@ config KPROBES
 	  If in doubt, say "N".
 
 config EARLY_KPROBES
-	depends on KPROBES && OPTPROBES
+	depends on KPROBES && OPTPROBES && (KPROBES_ON_FTRACE || !HAVE_KPROBES_ON_FTRACE)
 	def_bool y
 
 config NR_EARLY_KPROBES_SLOTS
-- 
1.8.4
