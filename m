From: wangnan0@huawei.com (Wang Nan)
Date: Fri, 13 Feb 2015 13:41:08 +0800
Subject: [RFC PATCH v3 21/26] early kprobes: add CONFIG_EARLY_KPROBES option.
In-Reply-To: <1423805941-61407-1-git-send-email-wangnan0@huawei.com>
References: <1423805941-61407-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1423806068-62359-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable early kprobes in Kconfig.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 arch/Kconfig | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 05d7a8a..32e9f4a 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -46,6 +46,21 @@ config KPROBES
 	  for kernel debugging, non-intrusive instrumentation and testing.
 	  If in doubt, say "N".
 
+config EARLY_KPROBES
+	bool "Enable kprobes at very early booting stage"
+	depends on KPROBES && OPTPROBES
+	def_bool y
+	help
+	  Enable kprobe at very early booting stage.
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
