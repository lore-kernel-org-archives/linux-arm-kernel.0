Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A14DC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:28:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5943821721
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X6ZOeE9U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5943821721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6jFwzk1pA9h/qiOK+CNbXsobcjNMTfDyeWmMKkGjntU=; b=X6ZOeE9UprkJb3
	ciLcHuvawh6H/erNcdoJEnzvB0xJDBc+5oFHGJ+qYnN6P1RptyIsuNPM0FwhJjAlh0gjz+ORNuxoW
	ysD3m5QahmMb3FEmfRfFzbGt7nq7uxHq+AiDCBUXE2OD/LO0rkDI3czrNTibfjIa0DtuuD7WeM7KE
	Ny5X0RkvO/CKt4HVobwWRwr0BQULxx0ScunUSgmo7OCpW+yGouar3XZdoKf3o5UQSaCbCPk/TOmiC
	pRAAPZfjLw/O9w2wWXdZciGoEpP/jGYkuLCjPZIjF1aTc0iEJwAHoe8Jo5Xr4u22JGf4NvQQi7+hW
	HfG+iOaMGT0obqYyqwAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glw6Y-0008Ip-1B; Tue, 22 Jan 2019 13:28:38 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glw6U-0008IV-AI
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 13:28:36 +0000
Received: by newverein.lst.de (Postfix, from userid 2005)
 id 782DA6FA7F; Tue, 22 Jan 2019 14:28:32 +0100 (CET)
Date: Tue, 22 Jan 2019 14:28:32 +0100
From: Torsten Duwe <duwe@lst.de>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v7 2/3] arm64: implement ftrace with regs
Message-ID: <20190122132832.GB16778@lst.de>
References: <20190118163736.6A99268CEB@newverein.lst.de>
 <20190118163908.E338E68D93@newverein.lst.de>
 <bdcbdda9-d9e8-20e5-429e-35473ade56cc@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bdcbdda9-d9e8-20e5-429e-35473ade56cc@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_052834_649272_D29F0513 
X-CRM114-Status: GOOD (  18.77  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, "Singh,
 Balbir" <bsingharora@gmail.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, Ingo Molnar <mingo@redhat.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 Amit Daniel Kachhap <amit.kachhap@arm.com>, live-patching@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 22, 2019 at 10:18:17AM +0000, Julien Thierry wrote:
> Hi Torsten,
> 
> A few suggestions below.
> 
> > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> > +#define ARCH_SUPPORTS_FTRACE_OPS 1
> > +#define REC_IP_BRANCH_OFFSET AARCH64_INSN_SIZE
> > +/* All we need is some magic value. Simply use "_mCount:" */
> 
> Nit: Should the casing be "_mcount" ?

No! The string makes it clear what it's supposed to be and the peculiar
casing makes it unique and leaves no doubt were it came from. So whenever
you see this register value in a crash dump you don't have to wonder about
weird linkage errors, as it surely did not originate from a symtab.

> > +#define MCOUNT_ADDR		(0x5f6d436f756e743a)
> > +#else
> > +#define REC_IP_BRANCH_OFFSET 0
> > +#define MCOUNT_ADDR		((unsigned long)_mcount)
> > +#endif
> > +
> >  #ifndef __ASSEMBLY__
> >  #include <linux/compat.h>
> >  
> > --- a/arch/arm64/kernel/entry-ftrace.S
> > +++ b/arch/arm64/kernel/entry-ftrace.S
> > @@ -10,6 +10,7 @@
> >   */
> >  
> >  #include <linux/linkage.h>
> > +#include <asm/asm-offsets.h>
> >  #include <asm/assembler.h>
> >  #include <asm/ftrace.h>
> >  #include <asm/insn.h>
^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +ENTRY(ftrace_common)
> > +
> > +	mov	x3, sp		/* pt_regs are @sp */
> > +	ldr_l	x2, function_trace_op, x0
> > +	mov	x1, x9		/* parent IP */
> > +	sub	x0, lr, #8	/* function entry == IP */
> 
> The #8 is because we go back two instructions right? Can we use
> #(AARCH64_INSN_SIZE * 2) instead?

Hmm, <asm/insn.h> was already included, so why not. (same below)

> > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> > +int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
> > +			unsigned long addr)
> > +{
> > +	unsigned long pc = rec->ip + REC_IP_BRANCH_OFFSET;
> > +	u32 old, new;
> > +
> > +	old = aarch64_insn_gen_branch_imm(pc, old_addr, true);
> > +	new = aarch64_insn_gen_branch_imm(pc, addr, true);
> 
> The last argument of aarch64_insn_gen_branch_imm() is an enum, not a
> boolean.
> 
> You should use AARCH64_INSN_BRANCH_LINK here which happens to be equal to 1.

That's what you get when you keep copying code...
Good catch, thanks!

> > +	 *  initially; the NOPs are already there. So instead,
> > +	 *  put the LR saver there ahead of time, in order to avoid
> > +	 *  any race condition over patching 2 instructions.
> > +	 */
> > +	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS) &&
> > +		addr == MCOUNT_ADDR) {
> 
> This works, however it feels a bit weird since core code asked to
> generate a NOP but not only we don't generate it but we put another
> instruction instead.

It's not the first time weird x86 sets the standards and all others
need workarounds. But here it just came handy to abuse this call :-)

> I think it would be useful to state that the replacement of mcount calls
> by nops is only ever done once at system initialization.
> 
> Or maybe have a intermediate function:
> 
> static int ftrace_setup_patchable_entry(unsigned long addr)
> {
>   	u32 old, new;
> 
> 	old = aarch64_insn_gen_nop();
> 	new = MOV_X9_X30;
> 	pc -= REC_IP_BRANCH_OFFSET;
> 	return ftrace_modify_code(pc, old, new, validate);
> }
> 
> 	[...]
> 
> 	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS) &&
> 		addr == MCOUNT_ADDR)
> 		return ftrace_setup_patchable_entry(pc);
> 
> 
> This way it clearly show that this is a setup/init corner case.

I'll definitely consider this.

Thanks for the input,

	Torsten



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
