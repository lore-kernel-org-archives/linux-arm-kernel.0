From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed,  9 May 2018 16:46:26 +0900
Subject: [PATCH] arm64: remove no-op macro VMLINUX_SYMBOL()
Message-ID: <1525851986-28631-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

VMLINUX_SYMBOL() is no-op unless CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
is defined.  It has ever been selected only by BLACKFIN and METAG.
VMLINUX_SYMBOL() is unneeded for ARM64-specific code.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/kernel/vmlinux.lds.S | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 0221aca..605d1b6 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -34,25 +34,25 @@ jiffies = jiffies_64;
 	 *    4 KB (see related ASSERT() below)		\
 	 */						\
 	. = ALIGN(SZ_4K);				\
-	VMLINUX_SYMBOL(__hyp_idmap_text_start) = .;	\
+	__hyp_idmap_text_start = .;			\
 	*(.hyp.idmap.text)				\
-	VMLINUX_SYMBOL(__hyp_idmap_text_end) = .;	\
-	VMLINUX_SYMBOL(__hyp_text_start) = .;		\
+	__hyp_idmap_text_end = .;			\
+	__hyp_text_start = .;				\
 	*(.hyp.text)					\
-	VMLINUX_SYMBOL(__hyp_text_end) = .;
+	__hyp_text_end = .;
 
 #define IDMAP_TEXT					\
 	. = ALIGN(SZ_4K);				\
-	VMLINUX_SYMBOL(__idmap_text_start) = .;		\
+	__idmap_text_start = .;				\
 	*(.idmap.text)					\
-	VMLINUX_SYMBOL(__idmap_text_end) = .;
+	__idmap_text_end = .;
 
 #ifdef CONFIG_HIBERNATION
 #define HIBERNATE_TEXT					\
 	. = ALIGN(SZ_4K);				\
-	VMLINUX_SYMBOL(__hibernate_exit_text_start) = .;\
+	__hibernate_exit_text_start = .;		\
 	*(.hibernate_exit.text)				\
-	VMLINUX_SYMBOL(__hibernate_exit_text_end) = .;
+	__hibernate_exit_text_end = .;
 #else
 #define HIBERNATE_TEXT
 #endif
@@ -60,10 +60,10 @@ jiffies = jiffies_64;
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 #define TRAMP_TEXT					\
 	. = ALIGN(PAGE_SIZE);				\
-	VMLINUX_SYMBOL(__entry_tramp_text_start) = .;	\
+	__entry_tramp_text_start = .;			\
 	*(.entry.tramp.text)				\
 	. = ALIGN(PAGE_SIZE);				\
-	VMLINUX_SYMBOL(__entry_tramp_text_end) = .;
+	__entry_tramp_text_end = .;
 #else
 #define TRAMP_TEXT
 #endif
-- 
2.7.4
