Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEEBC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 10:52:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49CE6206BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 10:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iCPCyEvV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49CE6206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OO5NTVet9YyaiJeRWG2b92e1ndxAA6ang5Q5vzmD1ZQ=; b=iCPCyEvVWOgRuN
	AckYlAg8FNHJKYUry0YPtDi5HGGQQJFsqo08HQIErwht7irdXkpWmRR5t8QO9o5ZEeonYVJS0Eicy
	rfTfZmpbOGuHYabHDRSp2UIgvtDra9dDh7IxYRIvb2Ag15pZcohk8LCKoa+RzEuOCAkcF2Bo0p+Lk
	oxsZohfwWhOdjb4N1vO6XOqCwACa7byVdU0pnHhQe49H/apBJIlDE/UmcxPm4nXo4JKXmlwygd7Rm
	4NB/79vP6NgfIFzq9mAVX70HgLhyNVSZvmwCd6T+rj3eKjReykEgP9PdIbn4CSoh5qYLyqU4GdXPm
	dMyPPdNhM5C28xxwdyHQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxUvH-0006ot-GA; Sat, 23 Feb 2019 10:52:47 +0000
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxUvD-0006ol-2z; Sat, 23 Feb 2019 10:52:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 580B72029B174; Sat, 23 Feb 2019 11:52:40 +0100 (CET)
Date: Sat, 23 Feb 2019 11:52:40 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC][PATCH] objtool: STAC/CLAC validation
Message-ID: <20190223105240.GZ32534@hirez.programming.kicks-ass.net>
References: <20190219090409.GW32494@hirez.programming.kicks-ass.net>
 <20190219124808.GG8501@fuggles.cambridge.arm.com>
 <f8e99706-4e3b-68ec-7a3e-6e6dd876ad2f@zytor.com>
 <cb221e71-243d-fdbd-1d18-b175bc88979b@arm.com>
 <alpine.DEB.2.21.1902212231490.1612@nanos.tec.linutronix.de>
 <CAHk-=wh1B9eRG=gj7wsFVC5XNEedk8Edive-2cQok6T2dNq2aQ@mail.gmail.com>
 <alpine.DEB.2.21.1902221853330.1666@nanos.tec.linutronix.de>
 <20190222222635.GK14054@worktop.programming.kicks-ass.net>
 <CALCETrV0XAv_tuw3WzQG+dx0iKEahw9V6DLACq4PtNQrkJBwhw@mail.gmail.com>
 <20190223083706.GE32477@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190223083706.GE32477@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Brian Gerst <brgerst@gmail.com>,
 Julien Thierry <julien.thierry@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Will Deacon <will.deacon@arm.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 valentin.schneider@arm.com, Ingo Molnar <mingo@redhat.com>,
 James Morse <james.morse@arm.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>,
 "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Feb 23, 2019 at 09:37:06AM +0100, Peter Zijlstra wrote:
> On Fri, Feb 22, 2019 at 03:55:25PM -0800, Andy Lutomirski wrote:
> > On Fri, Feb 22, 2019 at 2:26 PM Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > >   arch/x86/entry/entry_64.o: warning: objtool: .altinstr_replacement+0xb1: redundant CLAC
> > 
> > Does objtool understand altinstr?
> 
> Yep, otherwise it would've never found any of the STAC/CLAC instructions
> to begin with, they're all alternatives. The emitted code is all NOPs.
> 
> > If it understands that this is an
> > altinstr associated with a not-actually-a-fuction (i.e. END not
> > ENDPROC) piece of code, it could suppress this warning.
> 
> Using readelf on entry_64.o the symbol type appears to be STT_NOTYPE for
> these 'functions', so yes, I can try and ignore this warning for those.
> 
> > > +#define AC_SAFE(func) \
> > > +       static void __used __section(.discard.ac_safe) \
> > > +               *__func_ac_safe_##func = func
> > 
> > Are we okay with annotating function *declarations* in a way that
> > their addresses get taken whenever the declaration is processed?  It
> > would be nice if we could avoid this.
> > 
> > I'm wondering if we can just change the code that does getreg() and
> > load_gs_index() so it doesn't do it with AC set.  Also, what about
> > paravirt kernels?  They'll call into PV code for load_gs_index() with
> > AC set.
> 
> Fixing that code would be fine; but we need that annotation regardless,
> read Linus' email a little further back, he wants things like
> copy_{to,from}_user_unsafe().
> 
> Those really would need to be marked AC-safe, there's no inlining that.
> 
> That said, yes these annotations _suck_. But it's what we had and works,
> I'm just copying it (from STACK_FRAME_NON_STANDARD).
> 
> That said; maybe we can do something like:
> 
> #define AC_SAFE(func)						\
> 	asm (".pushsection .discard.ac_safe_sym\n\t"		\
> 	     "999: .ascii \"" #func "\"\n\t"			\
> 	     ".popsection\n\t"					\
> 	     ".pushsection .discard.ac_safe\n\t"		\
> 	     _ASM_PTR " 999b\n\t"				\
> 	     ".popsection")
> 
> I just don't have a clue on how to read that in objtool; weak elf foo.
> I'll see if I can make it work.

Fixed all that. Should probably also convert that NON_STANDARD stuff to
this new shiny thing.

Retained the ptrace muck because it's a nice test case, your patch is
obviously a better fix there.

Haven't bothered looking at alternatives yet, this is a
defconfig+tracing build.

Weekend now.

---
 arch/x86/include/asm/special_insns.h |   2 +
 arch/x86/kernel/ptrace.c             |   3 +-
 include/linux/frame.h                |  38 ++++++++++++
 tools/objtool/Makefile               |   2 +-
 tools/objtool/arch.h                 |   6 +-
 tools/objtool/arch/x86/decode.c      |  22 ++++++-
 tools/objtool/check.c                | 117 ++++++++++++++++++++++++++++++++++-
 tools/objtool/check.h                |   2 +-
 tools/objtool/elf.h                  |   1 +
 9 files changed, 187 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 43c029cdc3fe..cd31e4433f4c 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -5,6 +5,7 @@
 
 #ifdef __KERNEL__
 
+#include <linux/frame.h>
 #include <asm/nops.h>
 
 /*
@@ -135,6 +136,7 @@ static inline void native_wbinvd(void)
 }
 
 extern asmlinkage void native_load_gs_index(unsigned);
+AC_SAFE(native_load_gs_index);
 
 static inline unsigned long __read_cr4(void)
 {
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 4b8ee05dd6ad..e278b4055a8b 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -420,7 +420,7 @@ static int putreg(struct task_struct *child,
 	return 0;
 }
 
-static unsigned long getreg(struct task_struct *task, unsigned long offset)
+static notrace unsigned long getreg(struct task_struct *task, unsigned long offset)
 {
 	switch (offset) {
 	case offsetof(struct user_regs_struct, cs):
@@ -444,6 +444,7 @@ static unsigned long getreg(struct task_struct *task, unsigned long offset)
 
 	return *pt_regs_access(task_pt_regs(task), offset);
 }
+AC_SAFE(getreg);
 
 static int genregs_get(struct task_struct *target,
 		       const struct user_regset *regset,
diff --git a/include/linux/frame.h b/include/linux/frame.h
index 02d3ca2d9598..870a894bc586 100644
--- a/include/linux/frame.h
+++ b/include/linux/frame.h
@@ -21,4 +21,42 @@
 
 #endif /* CONFIG_STACK_VALIDATION */
 
+#if defined(CONFIG_STACK_VALIDATION)
+/*
+ * This macro marks functions as AC-safe, that is, it is safe to call from an
+ * EFLAGS.AC enabled region (typically user_access_begin() /
+ * user_access_end()).
+ *
+ * These functions in turn will only call AC-safe functions themselves (which
+ * precludes tracing, including __fentry__ and scheduling, including
+ * preempt_enable).
+ *
+ * AC-safe functions will obviously also not change EFLAGS.AC themselves.
+ */
+#define AC_SAFE(func)						\
+	asm (".pushsection .discard.ac_safe_sym, \"S\", @3\n\t"	\
+	     "999: .ascii \"" #func "\"\n\t"			\
+	     "     .byte 0\n\t"					\
+	     ".popsection\n\t"					\
+	     ".pushsection .discard.ac_safe\n\t"		\
+	     ".long 999b - .\n\t"				\
+	     ".popsection")
+
+/*
+ * SHT_STRTAB sayeth:
+ *
+ * - The initial byte of a string table is \0. This allows an string offset
+ *   value of zero to denote the NULL string.
+ *
+ * Works just fine without this, but since we set the proper section type, lets
+ * not confuse anybody reading this.
+ */
+asm(".pushsection .discard.ac_safe_sym, \"S\", @3\n\t"
+    ".byte 0\n\t"
+    ".popsection\n\t");
+
+#else
+#define AC_SAFE(func)
+#endif
+
 #endif /* _LINUX_FRAME_H */
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index c9d038f91af6..5a64e5fb9d7a 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -31,7 +31,7 @@ INCLUDES := -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi \
 	    -I$(srctree)/tools/objtool/arch/$(ARCH)/include
 WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed
-CFLAGS   += -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES)
+CFLAGS   += -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) -ggdb3
 LDFLAGS  += -lelf $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
 
 # Allow old libelf to be used:
diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
index b0d7dc3d71b5..9795d83cbc01 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -33,7 +33,11 @@
 #define INSN_STACK		8
 #define INSN_BUG		9
 #define INSN_NOP		10
-#define INSN_OTHER		11
+#define INSN_STAC		11
+#define INSN_CLAC		12
+#define INSN_STD		13
+#define INSN_CLD		14
+#define INSN_OTHER		15
 #define INSN_LAST		INSN_OTHER
 
 enum op_dest_type {
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 540a209b78ab..bee32ad53ecf 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -369,7 +369,19 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
 
 	case 0x0f:
 
-		if (op2 >= 0x80 && op2 <= 0x8f) {
+		if (op2 == 0x01) {
+
+			if (modrm == 0xca) {
+
+				*type = INSN_CLAC;
+
+			} else if (modrm == 0xcb) {
+
+				*type = INSN_STAC;
+
+			}
+
+		} else if (op2 >= 0x80 && op2 <= 0x8f) {
 
 			*type = INSN_JUMP_CONDITIONAL;
 
@@ -444,6 +456,14 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
 		*type = INSN_CALL;
 		break;
 
+	case 0xfc:
+		*type = INSN_CLD;
+		break;
+
+	case 0xfd:
+		*type = INSN_STD;
+		break;
+
 	case 0xff:
 		if (modrm_reg == 2 || modrm_reg == 3)
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0414a0d52262..3dedfa19cb09 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -451,6 +451,41 @@ static void add_ignores(struct objtool_file *file)
 	}
 }
 
+static int add_ac_safe(struct objtool_file *file)
+{
+	struct section *sec_sym, *sec;
+	struct symbol *func;
+	struct rela *rela;
+	const char *name;
+
+	sec = find_section_by_name(file->elf, ".rela.discard.ac_safe");
+	if (!sec)
+		return 0;
+
+	sec_sym = find_section_by_name(file->elf, ".discard.ac_safe_sym");
+	if (!sec_sym) {
+		WARN("missing AC-safe symbols");
+		return -1;
+	}
+
+	list_for_each_entry(rela, &sec->rela_list, list) {
+		if (rela->sym->type != STT_SECTION) {
+			WARN("unexpected relocation symbol type in %s", sec->name);
+			return -1;
+		}
+
+		name = elf_strptr(file->elf->elf, sec_sym->idx, rela->addend);
+
+		func = find_symbol_by_name(file->elf, name);
+		if (!func)
+			continue;
+
+		func->ac_safe = true;
+	}
+
+	return 0;
+}
+
 /*
  * FIXME: For now, just ignore any alternatives which add retpolines.  This is
  * a temporary hack, as it doesn't allow ORC to unwind from inside a retpoline.
@@ -695,6 +730,7 @@ static int handle_group_alt(struct objtool_file *file,
 		last_new_insn = insn;
 
 		insn->ignore = orig_insn->ignore_alts;
+		insn->func = orig_insn->func;
 
 		if (insn->type != INSN_JUMP_CONDITIONAL &&
 		    insn->type != INSN_JUMP_UNCONDITIONAL)
@@ -1239,6 +1275,10 @@ static int decode_sections(struct objtool_file *file)
 
 	add_ignores(file);
 
+	ret = add_ac_safe(file);
+	if (ret)
+		return ret;
+
 	ret = add_nospec_ignores(file);
 	if (ret)
 		return ret;
@@ -1902,6 +1942,15 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 		switch (insn->type) {
 
 		case INSN_RETURN:
+			if (state.ac) {
+				WARN_FUNC("return with AC set", sec, insn->offset);
+				return 1;
+			}
+			if (state.df) {
+				WARN_FUNC("return with DF set", sec, insn->offset);
+				return 1;
+			}
+
 			if (func && has_modified_stack_frame(&state)) {
 				WARN_FUNC("return with modified stack frame",
 					  sec, insn->offset);
@@ -1917,6 +1966,17 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 			return 0;
 
 		case INSN_CALL:
+			if ((state.ac_safe || state.ac) && !insn->call_dest->ac_safe) {
+				WARN_FUNC("call to %s() with AC set", sec, insn->offset,
+						insn->call_dest->name);
+				return 1;
+			}
+			if (state.df) {
+				WARN_FUNC("call to %s() with DF set", sec, insn->offset,
+						insn->call_dest->name);
+				return 1;
+			}
+
 			if (is_fentry_call(insn))
 				break;
 
@@ -1926,8 +1986,25 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 			if (ret == -1)
 				return 1;
 
-			/* fallthrough */
+			if (!no_fp && func && !has_valid_stack_frame(&state)) {
+				WARN_FUNC("call without frame pointer save/setup",
+					  sec, insn->offset);
+				return 1;
+			}
+			break;
+
 		case INSN_CALL_DYNAMIC:
+			if ((state.ac_safe || state.ac) && !insn->call_dest->ac_safe) {
+				WARN_FUNC("call to %s() with AC set", sec, insn->offset,
+						insn->call_dest->name);
+				return 1;
+			}
+			if (state.df) {
+				WARN_FUNC("call to %s() with DF set", sec, insn->offset,
+						insn->call_dest->name);
+				return 1;
+			}
+
 			if (!no_fp && func && !has_valid_stack_frame(&state)) {
 				WARN_FUNC("call without frame pointer save/setup",
 					  sec, insn->offset);
@@ -1980,6 +2057,42 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 
 			break;
 
+		case INSN_STAC:
+			if (state.ac_safe || state.ac) {
+				WARN_FUNC("recursive STAC", sec, insn->offset);
+				return 1;
+			}
+			state.ac = true;
+			break;
+
+		case INSN_CLAC:
+			if (!state.ac && insn->func) {
+				WARN_FUNC("redundant CLAC", sec, insn->offset);
+				return 1;
+			}
+			if (state.ac_safe) {
+				WARN_FUNC("AC-safe clears AC", sec, insn->offset);
+				return 1;
+			}
+			state.ac = false;
+			break;
+
+		case INSN_STD:
+			if (state.df) {
+				WARN_FUNC("recursive STD", sec, insn->offset);
+				return 1;
+			}
+			state.df = true;
+			break;
+
+		case INSN_CLD:
+			if (!state.df && insn->func) {
+				WARN_FUNC("redundant CLD", sec, insn->offset);
+				return 1;
+			}
+			state.df = false;
+			break;
+
 		default:
 			break;
 		}
@@ -2141,6 +2254,8 @@ static int validate_functions(struct objtool_file *file)
 			if (!insn || insn->ignore)
 				continue;
 
+			state.ac_safe = func->ac_safe;
+
 			ret = validate_branch(file, insn, state);
 			warnings += ret;
 		}
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index e6e8a655b556..602634792151 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -31,7 +31,7 @@ struct insn_state {
 	int stack_size;
 	unsigned char type;
 	bool bp_scratch;
-	bool drap, end;
+	bool drap, end, ac, ac_safe, df;
 	int drap_reg, drap_offset;
 	struct cfi_reg vals[CFI_NUM_REGS];
 };
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index bc97ed86b9cd..064c3df31e40 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -62,6 +62,7 @@ struct symbol {
 	unsigned long offset;
 	unsigned int len;
 	struct symbol *pfunc, *cfunc;
+	bool ac_safe;
 };
 
 struct rela {

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
