Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B885CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:58:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 882B5207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CY1DQ7pS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SrzmrG4I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 882B5207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eiX3Ef/NT8ib4kI4YmEBvlT62AymqwT1hw2puMMsvQs=; b=CY1DQ7pS47DBSw
	HfseHROhqYowk8iCM9oZvcPIvn3J+CIQGIsFVeNq10uMioFsHCUAUcz/nVXfj9bIAk+8bHOg1qfTy
	JbJTNQuX3bOyouFrPfXcepyNb/OwmZZgBdz2KacjqjWHAPDHEgvfHiWXXjFsSY0VTeU+HtYu9VImj
	TaJb+eNQ1ho3LRHiHZoXtw5V6Zgt/i2YFJwy51yS3pTT8kAB3UnOUaqVzN6/jwi8N4u3XJvoQv3an
	YqOrRDUYqYJj1H/+WV+oZxgmG81lvryuWhZo+hncPCX6WyHFBz1/dRymqISaHv8Hc7W8KaFit5xF/
	IosEcblnLEA8zEUkGm4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxAPW-00047p-MA; Fri, 22 Feb 2019 12:58:38 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxAPL-0003tK-6e
 for linux-arm-kernel@bombadil.infradead.org; Fri, 22 Feb 2019 12:58:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CfFko118cyzouCp4+3aL/LVdFcmqxlb4j3aW2IUziX4=; b=SrzmrG4ISF8nLIEcGAncPhtaV
 ybnvXcuYcMCu7R4mKtWKaQ10JnLORt62AWYsCRgGI0N82kVHGpf2K+WTvsrj1nrNlebAd1ypB9RNd
 By2g/22L1MaijzgNatIfslAxqpP/3ugBH3aNiZg3y2gzzWQhEqbp3DOXzeo/bJ9Xd8Yorj9gYi4gU
 dwmG4TrbvRMQfImeDnezznpgXdMP94ITivWI2Sl39VuaNCNFKIufW4GXhgpXCuoNiSF6ABKdi/k+L
 hnxYQ4KWrEkWPw7MGf2AEp5HXalN0ZDbtsqVDYmzvOybzrLX1KTr/DQ8IH9rtCRr7FqGDLvSj4Yjl
 MYCPktuqw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxAPG-0002d5-7X; Fri, 22 Feb 2019 12:58:22 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id CA78D299F9ED6; Fri, 22 Feb 2019 13:58:18 +0100 (CET)
Date: Fri, 22 Feb 2019 13:58:18 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
Message-ID: <20190222125818.GX32494@hirez.programming.kicks-ass.net>
References: <20190214101429.GD32494@hirez.programming.kicks-ass.net>
 <20ABBED1-E505-45F6-8520-FB93786DF9A9@zytor.com>
 <20190216103044.GR32494@hirez.programming.kicks-ass.net>
 <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
 <20190219090409.GW32494@hirez.programming.kicks-ass.net>
 <20190219124808.GG8501@fuggles.cambridge.arm.com>
 <f8e99706-4e3b-68ec-7a3e-6e6dd876ad2f@zytor.com>
 <cb221e71-243d-fdbd-1d18-b175bc88979b@arm.com>
 <alpine.DEB.2.21.1902212231490.1612@nanos.tec.linutronix.de>
 <CAHk-=wh1B9eRG=gj7wsFVC5XNEedk8Edive-2cQok6T2dNq2aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHk-=wh1B9eRG=gj7wsFVC5XNEedk8Edive-2cQok6T2dNq2aQ@mail.gmail.com>
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
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Denys Vlasenko <dvlasenk@redhat.com>,
 Brian Gerst <brgerst@gmail.com>, Julien Thierry <julien.thierry@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, valentin.schneider@arm.com,
 Will Deacon <will.deacon@arm.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>,
 James Morse <james.morse@arm.com>, Andrew Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 21, 2019 at 02:08:11PM -0800, Linus Torvalds wrote:
> On Thu, Feb 21, 2019 at 1:35 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > IMNSHO any call inside a AC region is a bug lurking round the corner. The
> > only thing which is tolerable is an exception of some sort.
> >
> > Enforce that with objtool. End of story.
> 
> Not quite that simple.
> 
> There are some use cases where you really do want a call - albeit to
> special functions - inside the AC region.
> 
> The prime example of this is likely "filldir()" in fs/readdir.c, which
> is actually somewhat important for some loads (eg samba).
> 
> And the whole AC thing made it horribly horribly slow because readdir
> is one of those things that doesn't just copy one value (or one
> structure) to user space, but writes several different things.
> 
> Kind of like signal frame setup does.
> 
> You may not realize that right now signal frame setup *does* actually
> do a call with AC set. See ia32_setup_rt_frame() that does
> 
>         put_user_try {
> ...
>                 compat_save_altstack_ex(&frame->uc.uc_stack, regs->sp);
> ...
>         } put_user_catch(err);
> 
> is a macro, but inside that macro is a call to sas_ss_reset().
> 
> Now, that is an inline function, so it hopefully doesn't actually
> cause a call. But it's "only" an inline function, not "always_inline".
> We did already have (and I rejected, for now) patches that made those
> inlines not very strong...

That one does indeed not generate a call, but:

arch/x86/ia32/ia32_signal.o: warning: objtool: ia32_restore_sigcontext()+0x38: call to native_load_gs_index() with AC set

I've yet to look at detectoring __preempt_count mucking.

---
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
diff --git a/include/linux/frame.h b/include/linux/frame.h
index 02d3ca2d9598..644662d8b8e8 100644
--- a/include/linux/frame.h
+++ b/include/linux/frame.h
@@ -15,9 +15,14 @@
 	static void __used __section(.discard.func_stack_frame_non_standard) \
 		*__func_stack_frame_non_standard_##func = func
 
+#define AC_SAFE(func) \
+	static void __used __section(.discard.ac_safe) \
+		*__func_ac_safe_##func = func
+
 #else /* !CONFIG_STACK_VALIDATION */
 
 #define STACK_FRAME_NON_STANDARD(func)
+#define AC_SAFE(func)
 
 #endif /* CONFIG_STACK_VALIDATION */
 
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
index b0d7dc3d71b5..48327099466d 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -33,7 +33,9 @@
 #define INSN_STACK		8
 #define INSN_BUG		9
 #define INSN_NOP		10
-#define INSN_OTHER		11
+#define INSN_STAC		11
+#define INSN_CLAC		12
+#define INSN_OTHER		13
 #define INSN_LAST		INSN_OTHER
 
 enum op_dest_type {
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 540a209b78ab..d1e99d1460a5 100644
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
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0414a0d52262..6fef157e244b 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -127,6 +127,24 @@ static bool ignore_func(struct objtool_file *file, struct symbol *func)
 	return false;
 }
 
+static bool ac_safe_func(struct objtool_file *file, struct symbol *func)
+{
+	struct rela *rela;
+
+	/* check for AC_SAFE */
+	if (file->ac_safe && file->ac_safe->rela)
+		list_for_each_entry(rela, &file->ac_safe->rela->rela_list, list) {
+			if (rela->sym->type == STT_SECTION &&
+			    rela->sym->sec == func->sec &&
+			    rela->addend == func->offset)
+				return true;
+			if (/* rela->sym->type == STT_FUNC && */ rela->sym == func)
+				return true;
+		}
+
+	return false;
+}
+
 /*
  * This checks to see if the given function is a "noreturn" function.
  *
@@ -439,6 +457,8 @@ static void add_ignores(struct objtool_file *file)
 
 	for_each_sec(file, sec) {
 		list_for_each_entry(func, &sec->symbol_list, list) {
+			func->ac_safe = ac_safe_func(file, func);
+
 			if (func->type != STT_FUNC)
 				continue;
 
@@ -1897,11 +1917,16 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 				if (ret)
 					return 1;
 			}
-		}
+		} else printf("ponies\n");
 
 		switch (insn->type) {
 
 		case INSN_RETURN:
+			if (state.ac) {
+				WARN_FUNC("return with AC set", sec, insn->offset);
+				return 1;
+			}
+
 			if (func && has_modified_stack_frame(&state)) {
 				WARN_FUNC("return with modified stack frame",
 					  sec, insn->offset);
@@ -1917,6 +1942,12 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 			return 0;
 
 		case INSN_CALL:
+			if (state.ac && !insn->call_dest->ac_safe) {
+				WARN_FUNC("call to %s() with AC set", sec, insn->offset,
+						insn->call_dest->name);
+				return 1;
+			}
+
 			if (is_fentry_call(insn))
 				break;
 
@@ -1928,6 +1959,11 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 
 			/* fallthrough */
 		case INSN_CALL_DYNAMIC:
+			if (state.ac && !insn->call_dest->ac_safe) {
+				WARN_FUNC("call to %s() with AC set", sec, insn->offset,
+						insn->call_dest->name);
+				return 1;
+			}
 			if (!no_fp && func && !has_valid_stack_frame(&state)) {
 				WARN_FUNC("call without frame pointer save/setup",
 					  sec, insn->offset);
@@ -1980,6 +2016,14 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 
 			break;
 
+		case INSN_STAC:
+			state.ac = true;
+			break;
+
+		case INSN_CLAC:
+			state.ac = false;
+			break;
+
 		default:
 			break;
 		}
@@ -2198,6 +2242,7 @@ int check(const char *_objname, bool orc)
 	INIT_LIST_HEAD(&file.insn_list);
 	hash_init(file.insn_hash);
 	file.whitelist = find_section_by_name(file.elf, ".discard.func_stack_frame_non_standard");
+	file.ac_safe = find_section_by_name(file.elf, ".discard.ac_safe");
 	file.c_file = find_section_by_name(file.elf, ".comment");
 	file.ignore_unreachables = no_unreachable;
 	file.hints = false;
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index e6e8a655b556..d4ae59454fff 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -31,7 +31,7 @@ struct insn_state {
 	int stack_size;
 	unsigned char type;
 	bool bp_scratch;
-	bool drap, end;
+	bool drap, end, ac;
 	int drap_reg, drap_offset;
 	struct cfi_reg vals[CFI_NUM_REGS];
 };
@@ -61,6 +61,7 @@ struct objtool_file {
 	struct list_head insn_list;
 	DECLARE_HASHTABLE(insn_hash, 16);
 	struct section *whitelist;
+	struct section *ac_safe;
 	bool ignore_unreachables, c_file, hints, rodata;
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
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index 50af4e1274b3..72084cae8f35 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -166,8 +166,8 @@ int special_get_alts(struct elf *elf, struct list_head *alts)
 			continue;
 
 		if (sec->len % entry->size != 0) {
-			WARN("%s size not a multiple of %d",
-			     sec->name, entry->size);
+			WARN("%s size (%d) not a multiple of %d",
+			     sec->name, sec->len, entry->size);
 			return -1;
 		}
 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
