Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AE2C37124
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:39:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 103222089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X2LAzeg2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpotKlWB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 103222089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5CQbUrfFvC61rw8cr8R6YR6vMfj/uGkdtjhB0MjdvU8=; b=X2LAzeg2CjBLcA
	P1/IPRaatWxnWA+DVQQL6tIw15gTxsF+YUL020by2TNg+2Z9HDafLB7y5lUkUQ/PKwv5TrCeafTnq
	7rZBfRyriWuAZlXbjudDcj8+AgrCNjxHhnHlaEmm2TBQ/HtLea8leSLRpX/6c/546Sj7M80E5TH/+
	NLZ1Q/IVNj5tWOEdii8+xR+WpRF0eQa3jOJmlilXqSRGDt+P43Urwh6gkQMxOnabpDqQ7WVS3mLdn
	GOV5zwRuVF9wo7H4ZLdCbzFwGvZMmlR67Zz/L5OJFbnweofGaC3GcYbEA4II8jSVsG/bNpg0hN08S
	HKKzCreFtKokP/hPAo6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gll2c-0000vi-64; Tue, 22 Jan 2019 01:39:50 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gll2X-0000v6-FY
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 01:39:47 +0000
Received: by mail-pl1-x644.google.com with SMTP id g9so10631798plo.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 17:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=oVaWtdJtOuAoP3jjxmvui3unmLN9WqNCtOi9fm612zY=;
 b=kpotKlWBGw1b0dFOJemGAV5DtAbJeaOL8YiHs4e5Q/NX6uQyr6Y365GqVQEEVw0XSx
 giQDEFa95dtnY7tNwuEP/GdwhaW6XMU2MAPM1oyFCXPJvfuUgU+RMa7zpdmYX5gx7w1B
 PEdLRL14JJJIPKJeKtBcQ7Mu4bhLg7jL3J2sT2l8gAEf05zTjv1yzaYjyWJLnYkZsdT7
 RX4w6FAQzR7aaBDohHBWiDZQ+FZWXnbzyDLXP9UKK7bpY+jCE4EWqdw+USaNXweT0sZ2
 wBULmxOiM7tFt9JfSaz0DdppagQllznhtFRBWMmc6AXRnRvTUElsetox2v9FzZm+vY36
 DZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oVaWtdJtOuAoP3jjxmvui3unmLN9WqNCtOi9fm612zY=;
 b=qAF9/ZC4dMp1jfwpc6OD9/LbtumSsDTW8qMru8qWkk7Z+DuPsnW56YG75143CtoPel
 be6cI3ooFbopg1tJ77IR4g78XWS4jkAQKNjYz1Mtnrbef7qL6AslKCVSFrLkgIvufODQ
 ycIqlQ/9LdkZqiqhUAGiXAMRKvLEWMveycA2vE9naNXy4kYg/Jg0ocTDMO0Ppn4x7u7x
 hvIYtzUCZMOgxTEkQPwPsb0LyWvN8D6rpA2tPkzd9aCxQ58JHReOhtevVeAZHW/03dTG
 h1Ll6iPWqwB/zFGg78vuWcy6zVLCPFhvf5aUWJ0gP/IIQ6KSliwkJp2yuHP14uzw1VMN
 M/4g==
X-Gm-Message-State: AJcUukfXjlTCvtFNEZDNlrjr09TdmsLwJC2kXrM42+Hp0g2cTpZaXYbj
 ce6MUR0wNuB6iJOZTjVVmvU=
X-Google-Smtp-Source: ALg8bN7rg7IzYARPIaN479nOpKYi0IFLyuJogCSnfo+6JyMXZ6GcTodhGNrRikxdk9H0bNunfhiGXA==
X-Received: by 2002:a17:902:d90d:: with SMTP id
 c13mr32471660plz.31.1548121182836; 
 Mon, 21 Jan 2019 17:39:42 -0800 (PST)
Received: from 8c8590bceeee.ant.amazon.com ([54.240.193.1])
 by smtp.gmail.com with ESMTPSA id i2sm20152195pfi.66.2019.01.21.17.39.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Jan 2019 17:39:42 -0800 (PST)
Subject: Re: [PATCH v7 2/3] arm64: implement ftrace with regs
To: Torsten Duwe <duwe@lst.de>, Mark Rutland <mark.rutland@arm.com>,
 Will Deacon <will.deacon@arm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Julien Thierry <julien.thierry@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Amit Daniel Kachhap <amit.kachhap@arm.com>
References: <20190118163736.6A99268CEB@newverein.lst.de>
 <20190118163908.E338E68D93@newverein.lst.de>
From: "Singh, Balbir" <bsingharora@gmail.com>
Message-ID: <b4081483-e5d6-2e7b-3540-6f3c3622fa24@gmail.com>
Date: Tue, 22 Jan 2019 14:39:32 +1300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190118163908.E338E68D93@newverein.lst.de>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_173945_565759_228A6D1A 
X-CRM114-Status: GOOD (  36.92  )
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
Cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 1/19/19 5:39 AM, Torsten Duwe wrote:
> Once gcc8 adds 2 NOPs at the beginning of each function, replace the
> first NOP thus generated with a quick LR saver (move it to scratch reg
> x9), so the 2nd replacement insn, the call to ftrace, does not clobber
> the value. Ftrace will then generate the standard stack frames.
> 
> Note that patchable-function-entry in GCC disables IPA-RA, which means
> ABI register calling conventions are obeyed *and* scratch registers
> such as x9 are available.
> 
> Introduce and handle an ftrace_regs_trampoline for module PLTs, right
> after ftrace_trampoline, and double the size of this special section.
> 
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> 
> ---
> 
> Mark, if you see your ftrace entry macro code being represented correctly
> here, please add your sign-off, As I've initially copied it from your mail.
> 
> ---
>  arch/arm64/include/asm/ftrace.h  |   17 ++++-
>  arch/arm64/include/asm/module.h  |    3 
>  arch/arm64/kernel/entry-ftrace.S |  125 +++++++++++++++++++++++++++++++++++++--
>  arch/arm64/kernel/ftrace.c       |  114 ++++++++++++++++++++++++++---------
>  arch/arm64/kernel/module-plts.c  |    3 
>  arch/arm64/kernel/module.c       |    2 
>  6 files changed, 227 insertions(+), 37 deletions(-)
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -14,9 +14,24 @@
>  #include <asm/insn.h>
>  
>  #define HAVE_FUNCTION_GRAPH_FP_TEST
> -#define MCOUNT_ADDR		((unsigned long)_mcount)
>  #define MCOUNT_INSN_SIZE	AARCH64_INSN_SIZE
>  
> +/*
> + * DYNAMIC_FTRACE_WITH_REGS is implemented by adding 2 NOPs at the beginning
> + * of each function, with the second NOP actually calling ftrace. In contrary
> + * to a classic _mcount call, the call instruction to be modified is thus
> + * the second one, and not the only one.
> + */
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +#define ARCH_SUPPORTS_FTRACE_OPS 1
> +#define REC_IP_BRANCH_OFFSET AARCH64_INSN_SIZE
> +/* All we need is some magic value. Simply use "_mCount:" */
> +#define MCOUNT_ADDR		(0x5f6d436f756e743a)
> +#else
> +#define REC_IP_BRANCH_OFFSET 0
> +#define MCOUNT_ADDR		((unsigned long)_mcount)
> +#endif
> +
>  #ifndef __ASSEMBLY__
>  #include <linux/compat.h>
>  
> --- a/arch/arm64/kernel/entry-ftrace.S
> +++ b/arch/arm64/kernel/entry-ftrace.S
> @@ -10,6 +10,7 @@
>   */
>  
>  #include <linux/linkage.h>
> +#include <asm/asm-offsets.h>
>  #include <asm/assembler.h>
>  #include <asm/ftrace.h>
>  #include <asm/insn.h>
> @@ -124,6 +125,7 @@ EXPORT_SYMBOL(_mcount)
>  NOKPROBE(_mcount)
>  
>  #else /* CONFIG_DYNAMIC_FTRACE */
> +#ifndef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>  /*
>   * _mcount() is used to build the kernel with -pg option, but all the branch
>   * instructions to _mcount() are replaced to NOP initially at kernel start up,
> @@ -163,11 +165,6 @@ GLOBAL(ftrace_graph_call)		// ftrace_gra
>  
>  	mcount_exit
>  ENDPROC(ftrace_caller)
> -#endif /* CONFIG_DYNAMIC_FTRACE */
> -
> -ENTRY(ftrace_stub)
> -	ret
> -ENDPROC(ftrace_stub)
>  
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>  /*
> @@ -187,7 +184,125 @@ ENTRY(ftrace_graph_caller)
>  
>  	mcount_exit
>  ENDPROC(ftrace_graph_caller)
> +#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
> +
> +#else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> +
> +	.macro  ftrace_regs_entry, allregs=0
> +	/* make room for pt_regs, plus a callee frame */
> +	sub	sp, sp, #(S_FRAME_SIZE + 16)
> +
> +	/* save function arguments */
> +	stp	x0, x1, [sp, #S_X0]
> +	stp	x2, x3, [sp, #S_X2]
> +	stp	x4, x5, [sp, #S_X4]
> +	stp	x6, x7, [sp, #S_X6]
> +	stp	x8, x9, [sp, #S_X8]
>  
> +	.if \allregs == 1
> +	stp	x10, x11, [sp, #S_X10]
> +	stp	x12, x13, [sp, #S_X12]
> +	stp	x14, x15, [sp, #S_X14]
> +	stp	x16, x17, [sp, #S_X16]
> +	stp	x18, x19, [sp, #S_X18]
> +	stp	x20, x21, [sp, #S_X20]
> +	stp	x22, x23, [sp, #S_X22]
> +	stp	x24, x25, [sp, #S_X24]
> +	stp	x26, x27, [sp, #S_X26]
> +	.endif
> +
> +	/* Save fp and x28, which is used in this function. */
> +	stp	x28, x29, [sp, #S_X28]
> +
> +	/* The stack pointer as it was on ftrace_caller entry... */
> +	add	x28, sp, #(S_FRAME_SIZE + 16)	
> +	/* ...and the link Register at callee entry */
> +	stp	x9, x28, [sp, #S_LR]	/* to pt_regs.r[30] and .sp */
> +
> +	/* The program counter just after the ftrace call site */
> +	str	lr, [sp, #S_PC]
> +
> +	/* Now fill in callee's preliminary stackframe. */
> +	stp	x29, x9, [sp, #S_FRAME_SIZE]
> +	/* Let FP point to it. */
> +	add	x29, sp, #S_FRAME_SIZE
> +
> +	/* Our stackframe, stored inside pt_regs. */
> +	stp	x29, x30, [sp, #S_STACKFRAME]
> +	add	x29, sp, #S_STACKFRAME
> +	.endm
> +
> +ENTRY(ftrace_regs_caller)
> +	ftrace_regs_entry	1
> +	b	ftrace_common
> +ENDPROC(ftrace_regs_caller)
> +
> +ENTRY(ftrace_caller)
> +	ftrace_regs_entry	0
> +	b	ftrace_common
> +ENDPROC(ftrace_caller)
> +
> +ENTRY(ftrace_common)
> +
> +	mov	x3, sp		/* pt_regs are @sp */
> +	ldr_l	x2, function_trace_op, x0
> +	mov	x1, x9		/* parent IP */
> +	sub	x0, lr, #8	/* function entry == IP */
> +
> +GLOBAL(ftrace_call)
> +	bl	ftrace_stub
> +
> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> +GLOBAL(ftrace_graph_call)		// ftrace_graph_caller();
> +	nop				// If enabled, this will be replaced
> +					// "b ftrace_graph_caller"
> +#endif
> +
> +/*
> + * GCC's patchable-function-entry implicitly disables IPA-RA,
> + * so all non-argument registers are either scratch / dead
> + * or callee-saved (within the ftrace framework). Function
> + * arguments of the call we are intercepting right now however
> + * need to be preserved in any case.
> + */
> +ftrace_common_return:
> +	/* restore function args */
> +	ldp	x0, x1, [sp]
> +	ldp	x2, x3, [sp, #S_X2]
> +	ldp	x4, x5, [sp, #S_X4]
> +	ldp	x6, x7, [sp, #S_X6]
> +	ldr	x8, [sp, #S_X8]
> +
> +	/* restore fp and x28 */
> +	ldp	x28, x29, [sp, #S_X28]
> +
> +	ldr	lr, [sp, #S_LR]
> +	ldr	x9, [sp, #S_PC]

Is it fair to assume that we never modify registers beyond LR and PC as a result of ftrace/livepatching? I presume it is, but just checking.

> +	/* clean up both frames, ours and callee preliminary */
> +	add	sp, sp, #S_FRAME_SIZE + 16
> +
> +	ret	x9
> +ENDPROC(ftrace_common)
> +
> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> +ENTRY(ftrace_graph_caller)
> +	ldr	x0, [sp, #S_PC]		   /* pc */
> +	sub	x0, x0, #8	/* start of the ftrace call site */
> +	add	x1, sp, #S_LR		   /* &lr */
> +	ldr	x2, [sp, #S_FRAME_SIZE]	   /* fp */
> +	bl	prepare_ftrace_return
> +	b	ftrace_common_return
> +ENDPROC(ftrace_graph_caller)
> +#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
> +#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> +#endif /* CONFIG_DYNAMIC_FTRACE */
> +
> +ENTRY(ftrace_stub)
> +	ret
> +ENDPROC(ftrace_stub)
> +
> +
> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
>  /*
>   * void return_to_handler(void)
>   *
> --- a/arch/arm64/kernel/ftrace.c
> +++ b/arch/arm64/kernel/ftrace.c
> @@ -65,19 +65,67 @@ int ftrace_update_ftrace_func(ftrace_fun
>  	return ftrace_modify_code(pc, 0, new, false);
>  }
>  
> +#ifdef CONFIG_ARM64_MODULE_PLTS
> +static int install_ftrace_trampoline(struct module *mod, unsigned long *addr)
> +{
> +	struct plt_entry trampoline, *mod_trampoline;
> +
> +	/*
> +	 * Iterate over
> +	 * mod->arch.ftrace_trampolines[MOD_ARCH_NR_FTRACE_TRAMPOLINES]
> +	 * The assignment to various ftrace functions happens here.
> +	 */
> +	if (*addr == FTRACE_ADDR)
> +		mod_trampoline = &mod->arch.ftrace_trampolines[0];
> +	else if (*addr == FTRACE_REGS_ADDR)
> +		mod_trampoline = &mod->arch.ftrace_trampolines[1];
> +	else
> +		return -EINVAL;
> +
> +	trampoline = get_plt_entry(*addr, mod_trampoline);
> +
> +	if (!plt_entries_equal(mod_trampoline, &trampoline)) {
> +		/* point the trampoline at our ftrace entry point */
> +		module_disable_ro(mod);
> +		*mod_trampoline = trampoline;
> +		module_enable_ro(mod, true);
> +
> +		/* update trampoline before patching in the branch */
> +		smp_wmb();
> +	}
> +	*addr = (unsigned long)(void *)mod_trampoline;
> +
> +	return 0;
> +}
> +#endif
> +
> +/*
> + * Ftrace with regs generates the tracer calls as close as possible to
> + * the function entry; no stack frame has been set up at that point.
> + * In order to make another call e.g to ftrace_caller, the LR must be
> + * saved from being overwritten.
> + * Between two functions, and with IPA-RA turned off, the scratch registers
> + * are available, so move the LR to x9 before calling into ftrace.
> + * "mov x9, lr" is officially aliased from "orr x9, xzr, lr".
> + */
> +#define MOV_X9_X30 aarch64_insn_gen_logical_shifted_reg( \
> +			AARCH64_INSN_REG_9, AARCH64_INSN_REG_ZR, \
> +			AARCH64_INSN_REG_LR, 0, AARCH64_INSN_VARIANT_64BIT, \
> +			AARCH64_INSN_LOGIC_ORR)
> +
>  /*
>   * Turn on the call to ftrace_caller() in instrumented function
>   */
>  int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
>  {
> -	unsigned long pc = rec->ip;
> +	unsigned long pc = rec->ip + REC_IP_BRANCH_OFFSET;
>  	u32 old, new;
>  	long offset = (long)pc - (long)addr;
>  
>  	if (offset < -SZ_128M || offset >= SZ_128M) {
>  #ifdef CONFIG_ARM64_MODULE_PLTS
> -		struct plt_entry trampoline;
>  		struct module *mod;
> +		int ret;
>  
>  		/*
>  		 * On kernels that support module PLTs, the offset between the
> @@ -96,32 +144,14 @@ int ftrace_make_call(struct dyn_ftrace *
>  		if (WARN_ON(!mod))
>  			return -EINVAL;
>  
> -		/*
> -		 * There is only one ftrace trampoline per module. For now,
> -		 * this is not a problem since on arm64, all dynamic ftrace
> -		 * invocations are routed via ftrace_caller(). This will need
> -		 * to be revisited if support for multiple ftrace entry points
> -		 * is added in the future, but for now, the pr_err() below
> -		 * deals with a theoretical issue only.
> -		 */
> -		trampoline = get_plt_entry(addr, mod->arch.ftrace_trampoline);
> -		if (!plt_entries_equal(mod->arch.ftrace_trampoline,
> -				       &trampoline)) {
> -			if (!plt_entries_equal(mod->arch.ftrace_trampoline,
> -					       &(struct plt_entry){})) {
> -				pr_err("ftrace: far branches to multiple entry points unsupported inside a single module\n");
> -				return -EINVAL;
> -			}
> -
> -			/* point the trampoline to our ftrace entry point */
> -			module_disable_ro(mod);
> -			*mod->arch.ftrace_trampoline = trampoline;
> -			module_enable_ro(mod, true);
> +		/* Check against our well-known list of ftrace entry points */
> +		if (addr == FTRACE_ADDR || addr == FTRACE_REGS_ADDR) {
> +			ret = install_ftrace_trampoline(mod, &addr);
> +			if (ret < 0)
> +				return ret;
> +		} else
> +			return -EINVAL;
>  
> -			/* update trampoline before patching in the branch */
> -			smp_wmb();
> -		}
> -		addr = (unsigned long)(void *)mod->arch.ftrace_trampoline;
>  #else /* CONFIG_ARM64_MODULE_PLTS */
>  		return -EINVAL;
>  #endif /* CONFIG_ARM64_MODULE_PLTS */
> @@ -133,17 +163,45 @@ int ftrace_make_call(struct dyn_ftrace *
>  	return ftrace_modify_code(pc, old, new, true);
>  }
>  
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
> +			unsigned long addr)
> +{
> +	unsigned long pc = rec->ip + REC_IP_BRANCH_OFFSET;
> +	u32 old, new;
> +
> +	old = aarch64_insn_gen_branch_imm(pc, old_addr, true);
> +	new = aarch64_insn_gen_branch_imm(pc, addr, true);
> +

Is this a branch or a call? Does addr always fit in the immediate limits?

> +	return ftrace_modify_code(pc, old, new, true);

Can you talk to the semantics of whether this operation is atomic w.r.t system? Will old and new return consistent values? Given the nature of ftrace, I presume it's well isolated. 

> +}
> +#endif
> +
>  /*
>   * Turn off the call to ftrace_caller() in instrumented function
>   */
>  int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
>  		    unsigned long addr)
>  {
> -	unsigned long pc = rec->ip;
> +	unsigned long pc = rec->ip + REC_IP_BRANCH_OFFSET;
>  	bool validate = true;
>  	u32 old = 0, new;
>  	long offset = (long)pc - (long)addr;
>  
> +	/*
> +	 * -fpatchable-function-entry= does not generate a profiling call
> +	 *  initially; the NOPs are already there. So instead,
> +	 *  put the LR saver there ahead of time, in order to avoid
> +	 *  any race condition over patching 2 instructions.
> +	 */
> +	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS) &&
> +		addr == MCOUNT_ADDR) {
> +		old = aarch64_insn_gen_nop();
> +		new = MOV_X9_X30;
> +		pc -= REC_IP_BRANCH_OFFSET;
> +		return ftrace_modify_code(pc, old, new, validate);

I presume all the icache flush and barrier handling is in ftrace_modify_code()?

> +	}
> +
>  	if (offset < -SZ_128M || offset >= SZ_128M) {
>  #ifdef CONFIG_ARM64_MODULE_PLTS
>  		u32 replaced;
> --- a/arch/arm64/include/asm/module.h
> +++ b/arch/arm64/include/asm/module.h
> @@ -32,7 +32,8 @@ struct mod_arch_specific {
>  	struct mod_plt_sec	init;
>  
>  	/* for CONFIG_DYNAMIC_FTRACE */
> -	struct plt_entry 	*ftrace_trampoline;
> +	struct plt_entry	*ftrace_trampolines;
> +#define MOD_ARCH_NR_FTRACE_TRAMPOLINES	2

I don't see the generation of ftrace_trampolines[1]

>  };
>  #endif
>  
> --- a/arch/arm64/kernel/module.c
> +++ b/arch/arm64/kernel/module.c
> @@ -452,7 +452,7 @@ int module_finalize(const Elf_Ehdr *hdr,
>  #ifdef CONFIG_ARM64_MODULE_PLTS
>  		if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
>  		    !strcmp(".text.ftrace_trampoline", secstrs + s->sh_name))
> -			me->arch.ftrace_trampoline = (void *)s->sh_addr;
> +			me->arch.ftrace_trampolines = (void *)s->sh_addr;
>  #endif
>  	}
>  
> --- a/arch/arm64/kernel/module-plts.c
> +++ b/arch/arm64/kernel/module-plts.c
> @@ -333,7 +333,8 @@ int module_frob_arch_sections(Elf_Ehdr *
>  		tramp->sh_type = SHT_NOBITS;
>  		tramp->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
>  		tramp->sh_addralign = __alignof__(struct plt_entry);
> -		tramp->sh_size = sizeof(struct plt_entry);
> +		tramp->sh_size = MOD_ARCH_NR_FTRACE_TRAMPOLINES
> +				 * sizeof(struct plt_entry);
>  	}
>  
>  	return 0;
> 

Balbir Singh.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
