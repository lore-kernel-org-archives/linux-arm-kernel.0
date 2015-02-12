From: wangnan0@huawei.com (Wang Nan)
Date: Thu, 12 Feb 2015 20:21:10 +0800
Subject: [RFC PATCH v2 21/26] early kprobes: add CONFIG_EARLY_KPROBES option.
In-Reply-To: <1423743476-11927-1-git-send-email-wangnan0@huawei.com>
References: <1423743476-11927-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1423743670-12943-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable early kprobes in Kconfig.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 arch/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 05d7a8a..06dff4b 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -46,6 +46,18 @@ config KPROBES
 	  for kernel debugging, non-intrusive instrumentation and testing.
 	  If in doubt, say "N".
 
+config EARLY_KPROBES
+	depends on KPROBES && OPTPROBES
+	def_bool y
+
+config NR_EARLY_KPROBES_SLOTS
+	int "Number of possible early kprobes"
+	range 1 64
+	default 16
+	depends on EARLY_KPROBES
+	help
+	  Number of early kprobes slots.
+
 config JUMP_LABEL
        bool "Optimize very unlikely/likely branches"
        depends on HAVE_ARCH_JUMP_LABEL
-- 
1.8.4
