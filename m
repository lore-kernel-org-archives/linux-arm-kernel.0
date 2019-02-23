Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A80CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 08:37:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F11E2206A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 08:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u6Qe/loU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F11E2206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MTtWayu0dpb1Gp+9uYTP9llsPpOd8bAf3xtQPXmkXOY=; b=u6Qe/loUAh1pBL
	wi4cScujLBr7bR74bNP5capi282H3MSWDAwloeqQeUw2hDP/9TNzG8B8yJvBFsPSRAh/z3zDi2qk5
	ZcOKS65rVuhg8WyKVwqQvL0Tx6OmklHIf7EV9klmemIkwWvJVSLPtOZIy/SGO2v7qIGmWOrLLfPRz
	AYcvixJjLWInTcdAPJNzqdfKPMKgamuYM6SalgInVq2fab5CpFhYHJGW+FwziRbZfAj4bt2ZEdsxd
	eJie13dKri+jytYMFy/ixeAX6OYYTCP1Zva9QAE0NKwL7ZORTvsYbMl2Ns5F0IeTHA7n6RQwerTUr
	jfwCKopiUOAyBOlWE3yA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxSo4-0004r7-Fm; Sat, 23 Feb 2019 08:37:12 +0000
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxSnz-0004qx-Oo; Sat, 23 Feb 2019 08:37:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 2019B20259708; Sat, 23 Feb 2019 09:37:06 +0100 (CET)
Date: Sat, 23 Feb 2019 09:37:06 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC][PATCH] objtool: STAC/CLAC validation
Message-ID: <20190223083706.GE32477@hirez.programming.kicks-ass.net>
References: <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
 <20190219090409.GW32494@hirez.programming.kicks-ass.net>
 <20190219124808.GG8501@fuggles.cambridge.arm.com>
 <f8e99706-4e3b-68ec-7a3e-6e6dd876ad2f@zytor.com>
 <cb221e71-243d-fdbd-1d18-b175bc88979b@arm.com>
 <alpine.DEB.2.21.1902212231490.1612@nanos.tec.linutronix.de>
 <CAHk-=wh1B9eRG=gj7wsFVC5XNEedk8Edive-2cQok6T2dNq2aQ@mail.gmail.com>
 <alpine.DEB.2.21.1902221853330.1666@nanos.tec.linutronix.de>
 <20190222222635.GK14054@worktop.programming.kicks-ass.net>
 <CALCETrV0XAv_tuw3WzQG+dx0iKEahw9V6DLACq4PtNQrkJBwhw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALCETrV0XAv_tuw3WzQG+dx0iKEahw9V6DLACq4PtNQrkJBwhw@mail.gmail.com>
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

On Fri, Feb 22, 2019 at 03:55:25PM -0800, Andy Lutomirski wrote:
> On Fri, Feb 22, 2019 at 2:26 PM Peter Zijlstra <peterz@infradead.org> wrote:

> >   arch/x86/entry/entry_64.o: warning: objtool: .altinstr_replacement+0xb1: redundant CLAC
> 
> Does objtool understand altinstr?

Yep, otherwise it would've never found any of the STAC/CLAC instructions
to begin with, they're all alternatives. The emitted code is all NOPs.

> If it understands that this is an
> altinstr associated with a not-actually-a-fuction (i.e. END not
> ENDPROC) piece of code, it could suppress this warning.

Using readelf on entry_64.o the symbol type appears to be STT_NOTYPE for
these 'functions', so yes, I can try and ignore this warning for those.

> > +#define AC_SAFE(func) \
> > +       static void __used __section(.discard.ac_safe) \
> > +               *__func_ac_safe_##func = func
> 
> Are we okay with annotating function *declarations* in a way that
> their addresses get taken whenever the declaration is processed?  It
> would be nice if we could avoid this.
> 
> I'm wondering if we can just change the code that does getreg() and
> load_gs_index() so it doesn't do it with AC set.  Also, what about
> paravirt kernels?  They'll call into PV code for load_gs_index() with
> AC set.

Fixing that code would be fine; but we need that annotation regardless,
read Linus' email a little further back, he wants things like
copy_{to,from}_user_unsafe().

Those really would need to be marked AC-safe, there's no inlining that.

That said, yes these annotations _suck_. But it's what we had and works,
I'm just copying it (from STACK_FRAME_NON_STANDARD).

That said; maybe we can do something like:

#define AC_SAFE(func)						\
	asm (".pushsection .discard.ac_safe_sym\n\t"		\
	     "999: .ascii \"" #func "\"\n\t"			\
	     ".popsection\n\t"					\
	     ".pushsection .discard.ac_safe\n\t"		\
	     _ASM_PTR " 999b\n\t"				\
	     ".popsection")

I just don't have a clue on how to read that in objtool; weak elf foo.
I'll see if I can make it work.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
