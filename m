From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 17 May 2018 16:01:28 +0900
Subject: [PATCH] ARM: remove no-op macro VMLINUX_SYMBOL()
Message-ID: <1526540488-28243-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

VMLINUX_SYMBOL() is no-op unless CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
is defined.  It has ever been selected only by BLACKFIN and METAG.
VMLINUX_SYMBOL() is unneeded for ARM-specific code.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

KernelVersion: 4.17-rc5

 arch/arm/kernel/vmlinux.lds.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/vmlinux.lds.h b/arch/arm/kernel/vmlinux.lds.h
index 71281e0..ae5fdff 100644
--- a/arch/arm/kernel/vmlinux.lds.h
+++ b/arch/arm/kernel/vmlinux.lds.h
@@ -27,24 +27,24 @@
 
 #define PROC_INFO							\
 		. = ALIGN(4);						\
-		VMLINUX_SYMBOL(__proc_info_begin) = .;			\
+		__proc_info_begin = .;					\
 		*(.proc.info.init)					\
-		VMLINUX_SYMBOL(__proc_info_end) = .;
+		__proc_info_end = .;
 
 #define HYPERVISOR_TEXT							\
-		VMLINUX_SYMBOL(__hyp_text_start) = .;			\
+		__hyp_text_start = .;					\
 		*(.hyp.text)						\
-		VMLINUX_SYMBOL(__hyp_text_end) = .;
+		__hyp_text_end = .;
 
 #define IDMAP_TEXT							\
 		ALIGN_FUNCTION();					\
-		VMLINUX_SYMBOL(__idmap_text_start) = .;			\
+		__idmap_text_start = .;					\
 		*(.idmap.text)						\
-		VMLINUX_SYMBOL(__idmap_text_end) = .;			\
+		__idmap_text_end = .;					\
 		. = ALIGN(PAGE_SIZE);					\
-		VMLINUX_SYMBOL(__hyp_idmap_text_start) = .;		\
+		__hyp_idmap_text_start = .;				\
 		*(.hyp.idmap.text)					\
-		VMLINUX_SYMBOL(__hyp_idmap_text_end) = .;
+		__hyp_idmap_text_end = .;
 
 #define ARM_DISCARD							\
 		*(.ARM.exidx.exit.text)					\
-- 
2.7.4
