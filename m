From: wangnan0@huawei.com (Wang Nan)
Date: Mon, 2 Mar 2015 22:24:47 +0800
Subject: [RFC PATCH v4 09/34] early kprobes: x86: add definition for
 vmlinux.lds use.
In-Reply-To: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
References: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1425306312-3437-10-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch defines MAX_OPTINSN_SIZE, MAX_INSN_SIZE and
KPROBE_OPCODE_SIZE for x86 for vmlinux.lds.S use.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 arch/x86/kernel/vmlinux.lds.S | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 00bf300..e46d877 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -29,6 +29,16 @@
 
 #undef i386     /* in case the preprocessor is a 32bit one */
 
+#ifdef CONFIG_EARLY_KPROBES
+# define MAX_INSN_SIZE 16
+# define RELATIVE_ADDR_SIZE 4
+# define RELATIVEJUMP_SIZE 5
+# define KPROBE_OPCODE_SIZE 1
+# define MAX_OPTIMIZED_LENGTH (MAX_INSN_SIZE + RELATIVE_ADDR_SIZE)
+# define MAX_OPTINSN_SIZE ((optprobe_template_end - optprobe_template_entry) + \
+	MAX_OPTIMIZED_LENGTH + RELATIVEJUMP_SIZE)
+#endif
+
 OUTPUT_FORMAT(CONFIG_OUTPUT_FORMAT, CONFIG_OUTPUT_FORMAT, CONFIG_OUTPUT_FORMAT)
 
 #ifdef CONFIG_X86_32
-- 
1.8.4
