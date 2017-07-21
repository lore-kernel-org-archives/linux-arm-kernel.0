From: mhiramat@kernel.org (Masami Hiramatsu)
Date: Fri, 21 Jul 2017 23:57:31 +0900
Subject: [PATCH] arm: mark kprobe templates as arrays, not single elements.
Message-ID: <150064904147.7445.9734335187475096313.stgit@devbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As same as commit 54a7d50b9205 ("x86: mark kprobe templates
as character arrays, not single characters") did, to prevent
miss detection of the string fortification, make the
template symbols as kprobe_opecode_t arrays, instead of
single kprobe_opecode_t. Unlike x86, arm has not supported
the string fortification (ARCH_HAS_FORTIFY_SOURCE),
so this is a kind of preventive patch.

Original issue was reported at https://lkml.org/lkml/2017/7/19/1425

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/arm/include/asm/kprobes.h |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/kprobes.h b/arch/arm/include/asm/kprobes.h
index 5965545..cf1cde4 100644
--- a/arch/arm/include/asm/kprobes.h
+++ b/arch/arm/include/asm/kprobes.h
@@ -54,15 +54,15 @@ int kprobe_exceptions_notify(struct notifier_block *self,
 			     unsigned long val, void *data);
 
 /* optinsn template addresses */
-extern __visible kprobe_opcode_t optprobe_template_entry;
-extern __visible kprobe_opcode_t optprobe_template_val;
-extern __visible kprobe_opcode_t optprobe_template_call;
-extern __visible kprobe_opcode_t optprobe_template_end;
-extern __visible kprobe_opcode_t optprobe_template_sub_sp;
-extern __visible kprobe_opcode_t optprobe_template_add_sp;
-extern __visible kprobe_opcode_t optprobe_template_restore_begin;
-extern __visible kprobe_opcode_t optprobe_template_restore_orig_insn;
-extern __visible kprobe_opcode_t optprobe_template_restore_end;
+extern __visible kprobe_opcode_t optprobe_template_entry[];
+extern __visible kprobe_opcode_t optprobe_template_val[];
+extern __visible kprobe_opcode_t optprobe_template_call[];
+extern __visible kprobe_opcode_t optprobe_template_end[];
+extern __visible kprobe_opcode_t optprobe_template_sub_sp[];
+extern __visible kprobe_opcode_t optprobe_template_add_sp[];
+extern __visible kprobe_opcode_t optprobe_template_restore_begin[];
+extern __visible kprobe_opcode_t optprobe_template_restore_orig_insn[];
+extern __visible kprobe_opcode_t optprobe_template_restore_end[];
 
 #define MAX_OPTIMIZED_LENGTH	4
 #define MAX_OPTINSN_SIZE				\
