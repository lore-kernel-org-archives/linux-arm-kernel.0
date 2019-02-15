Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AF4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:35:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9BDF2192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fM1KNV3k";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFcj0djA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9BDF2192D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WHDR5086w6MfqmNoC+GqtAU2JC5wBgAdURJcg92OEzE=; b=fM1KNV3kbVYSaV
	JmNcGuKp1lf8mGL5V5ZhB2H9JNHTuMF0ANShgLpak4Jq4+UT/mje3w/LaKgpynQJFX95DQR05ohnH
	68qE2mAm2Yl1se3FCgokF4HTrufKkjUDk5tRqGclrQAZwqmyVJmHrZhyV5TSP+iQkQUR5aVRl7uNM
	MKxGW7vMdUBFfkD2gKnnpI1Y19CIVIGKHDowov5QcaIcZxBO9gZgOWKVws9BPDT4Kv3JO4fHQj3NQ
	oIgXXIPrYh41ha5BB2z2198/GAyex2pWHbufnqXtE+Q3qvsdp5aTRetrC6yfd6mh3yZi0N1fv81iI
	wgeHMy/z97QJHjy4Sjyg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guea1-0007tm-Pn; Fri, 15 Feb 2019 14:35:05 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gueZi-0007Lp-Sj
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 14:34:49 +0000
Received: by mail-it1-x143.google.com with SMTP id f10so983634ita.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 06:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ojihXwYJZXpueZiM1yAaMkX88J1QXCnqKd3YiH6Zt2k=;
 b=RFcj0djAEfAfndouItnBtiHQcA1dN4Bsdwjt+GPvXcp0EfV16VSmVUOhiLJ5djfJvF
 mnOIfyvFYdk6gdLhV22bNR9AILesB6BetNQPbXNfg2zR6h/BeXQ3piJGPahfCFX5/9nb
 gD9Pchbg3NXYATK36PvMhgnUxpUSQd7B/VuOr5zj9QLMmZtX8feDNOkavBF3a3Ie1Fez
 3DZXh8U41DaWfqdO5B2tll7WugP9QcIuKpiHVHMEMJfL9O3OWzCaX4NCi1g4EQBTK6Th
 QVNt7xW+abdAJk5Yw8y/Ix5aIjmby0tKCyGsLAwH0DJ4a11WHptaZaiTR5VVMkQoCeNF
 SQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ojihXwYJZXpueZiM1yAaMkX88J1QXCnqKd3YiH6Zt2k=;
 b=RC12jZbXgdudMf3PRS0AZjPFZsdn536rUdfMCZRHYrOevchLAVR1QCXWOlHessjdtw
 s32ZV2d3ikMWk/rrTJHdXj/bhyezLwJ+3DRIurYPb5h2l+XNoRyiYIx/v7VLedbeB21S
 oZK0ZuPpGcsZP7C4S7/51r3Zwv9cOXcycjY/oatC0L9+nN1pbaeJCWzyG+ox8gqMk/7x
 o7MejW53qEEvgvO20yvcL1/9881cs8DFm2immNurzzwJtniolBeRtkMGZbGp+11OF7lL
 6LKnawlHuFUi/Pgd6Hnq6CEf++bAD5CIWEi2jW3F3Jqcp8P6/W7spObFfEURANwcWTqx
 MbCg==
X-Gm-Message-State: AHQUAubjGRbU+eXrdzHLF9METBwDLeHpuMT8cnoV6uMMl6bLl783k+Hj
 GVS7CUGR+bPWgDNfDI/A+8Xnpk9IVIFykwaUuQ==
X-Google-Smtp-Source: AHgI3IZX7unmXPPynnlAgBjT/+QOx8cWc93xL81cnkXDLfw5dwo3J4DGawrMlTaIW/zu9QPFpeKPelbKZl4OxU2LicQ=
X-Received: by 2002:a24:d04:: with SMTP id 4mr4823672itx.19.1550241285756;
 Fri, 15 Feb 2019 06:34:45 -0800 (PST)
MIME-Version: 1.0
References: <20190213140025.GB6346@brain-police>
 <20190213142524.GW32494@hirez.programming.kicks-ass.net>
 <dd33cc20-f335-0e4c-e3f4-02497ecc3710@arm.com>
 <20190213144145.GY32494@hirez.programming.kicks-ass.net>
 <20190213154532.GQ32534@hirez.programming.kicks-ass.net>
 <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net>
 <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
 <20190214101429.GD32494@hirez.programming.kicks-ass.net>
 <CAMzpN2hg+CY+AuF=BtetS2HrMQYdxhBZL9QMvJX4LjAs7vwwAw@mail.gmail.com>
 <20190214193432.GR32477@hirez.programming.kicks-ass.net>
In-Reply-To: <20190214193432.GR32477@hirez.programming.kicks-ass.net>
From: Brian Gerst <brgerst@gmail.com>
Date: Fri, 15 Feb 2019 09:34:33 -0500
Message-ID: <CAMzpN2g54zWYOAzmJdUm+1ziivkciLEeSDp4+b89KHkO4Lem+A@mail.gmail.com>
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
To: Peter Zijlstra <peterz@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_063447_110078_10D798A4 
X-CRM114-Status: GOOD (  15.40  )
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
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Julien Thierry <julien.thierry@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, valentin.schneider@arm.com,
 Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>,
 James Morse <james.morse@arm.com>, Andy Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 14, 2019 at 2:34 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Feb 14, 2019 at 11:18:01AM -0500, Brian Gerst wrote:
>
> > > --- a/arch/x86/include/asm/switch_to.h
> > > +++ b/arch/x86/include/asm/switch_to.h
> > > @@ -40,6 +40,7 @@ asmlinkage void ret_from_fork(void);
> > >   * order of the fields must match the code in __switch_to_asm().
> > >   */
> > >  struct inactive_task_frame {
> > > +       unsigned long flags;
> > >  #ifdef CONFIG_X86_64
> > >         unsigned long r15;
> > >         unsigned long r14;
> >
> > flags should be initialized in copy_thread_tls().  I think the new
> > stack is zeroed already, but it would be better to explicitly set it.
>
> Ah indeed. I somehow misread that code and thought we got initialized
> with a copy of current.
>
> Something like the below, right?
>
> ---
>
> --- a/arch/x86/kernel/process_32.c
> +++ b/arch/x86/kernel/process_32.c
> @@ -127,6 +127,7 @@ int copy_thread_tls(unsigned long clone_
>         struct task_struct *tsk;
>         int err;
>
> +       frame->flags = 0;
>         frame->bp = 0;
>         frame->ret_addr = (unsigned long) ret_from_fork;
>         p->thread.sp = (unsigned long) fork_frame;
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -392,6 +392,7 @@ int copy_thread_tls(unsigned long clone_
>         childregs = task_pt_regs(p);
>         fork_frame = container_of(childregs, struct fork_frame, regs);
>         frame = &fork_frame->frame;
> +       frame->flags = 0;
>         frame->bp = 0;
>         frame->ret_addr = (unsigned long) ret_from_fork;
>         p->thread.sp = (unsigned long) fork_frame;

Yes, this looks good.

--
Brian Gerst

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
