Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131FFC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:19:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0EF62146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AqGw5Lh8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dXnxlHiw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0EF62146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yXlFWunD0B26ntqQTYbhhn/KCwwN9FFw98P/jqgC5NE=; b=AqGw5Lh8DpC3ah
	WNerXzncxwZ1FBLdCZrVo4J0fRhTBswCePHN7KuQVTwKd833bsI0KCdITpWB/8BMXId9OQhaEJIbp
	Pf4wiW8x19Ppe5harqYVj9wm62rBDb0KrVlowzNcoL5QcfPkIqPoL4iJDXUEX54Wdy8YK8mwq2aBN
	D9PCjGDWHS37X1CbQ0hh1ZCljjkFNocHmK1yd7RTR2/6rsuOokZX+7+sFdh1+C/uNvz8LzfhY8Xh5
	yl/sDKxcFipWJm40eX70ygc97jXoTC0RCtlIj5m+EHrAP1iTAFvoR0dDLpNdLcWdX8MbRT85NeYgC
	3ZKkVRL8JOs7ilRmB2yA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu3oW-0001m3-QK; Wed, 13 Feb 2019 23:19:36 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu3oT-0001le-0m
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 23:19:34 +0000
Received: by mail-lf1-x142.google.com with SMTP id g2so3091934lfh.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 15:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WgVsJUTMnnCaCQDHvEM6XpYkBOEcgxFKcSfGDRa84GY=;
 b=dXnxlHiw2i/q9AM8vmhwbkVle9HbCuDxTJD/8szwNtgM5LWwooWFjbaCwLz+oZXAqJ
 Av4s6GLuP9JdrJKrMKI8Ez3MSvPbvQGZbiFqlPwvNMTDRBD6PJlmYLqYWC5HeeIvOK+b
 gRTPxAWAdlF1buqHitCwXrupsytDHVGxyf+pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WgVsJUTMnnCaCQDHvEM6XpYkBOEcgxFKcSfGDRa84GY=;
 b=O6YQn1vUYgQrO0Mf2yIcEIaJUNhocuF+ZsDmQk+vvlA9DTRzAZRPPl5MNnw1czeNXS
 aj7ASF7UEOh03DG1S3IB2aSPLKAlMnx+Ua3jqPfOQJFU76G53MedD2grAIOK8PXL2tdd
 5URmlCmJyOjj1GJSzaQR1SLta68JE9iZTPVMoMqF18CNYLlkZiFmKs6yxUBkBGy2wa6S
 S3wezSomwo3Y9UXPXajK03HLiiySImPg1H4bvRYvqz2AmeJSim2FD6Y+a/2GyDW82+rq
 V/cDwJcCE0n8QgazkSMZ8t3txekuus4OEkmq53alE+au6M9k5XGFd8rXAq6+D328ZOpG
 vWkw==
X-Gm-Message-State: AHQUAuZun2otjUxDkGtVfBKl93fVOIiWrEh1muRvdnd9s4oN6tOnfTcR
 d17X/DcjENc4ZwnRO/FMDBS7wJCjTOk=
X-Google-Smtp-Source: AHgI3Ia3zG9Jh/C+bjnANTwvgBNgf0g2o6MSMEkWQTcFyYdbh5p7Xv/SSSp8yuqddJDaXyqhShmGjA==
X-Received: by 2002:a19:4851:: with SMTP id v78mr376803lfa.98.1550099968979;
 Wed, 13 Feb 2019 15:19:28 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com.
 [209.85.167.53])
 by smtp.gmail.com with ESMTPSA id y12sm125164lfh.32.2019.02.13.15.19.26
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Feb 2019 15:19:27 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id n15so3122265lfe.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 15:19:26 -0800 (PST)
X-Received: by 2002:a19:ab09:: with SMTP id u9mr338489lfe.149.1550099966013;
 Wed, 13 Feb 2019 15:19:26 -0800 (PST)
MIME-Version: 1.0
References: <20190211134527.GA121589@gmail.com>
 <20190211135159.GC32511@hirez.programming.kicks-ass.net>
 <a23fdd84-8c4b-0c1f-d877-24d946cff6d0@arm.com>
 <20190213103553.GO32494@hirez.programming.kicks-ass.net>
 <1c2429a4-9df9-40a3-98e0-51577de4bd6a@arm.com>
 <20190213131720.GU32494@hirez.programming.kicks-ass.net>
 <20190213140025.GB6346@brain-police>
 <20190213142524.GW32494@hirez.programming.kicks-ass.net>
 <dd33cc20-f335-0e4c-e3f4-02497ecc3710@arm.com>
 <20190213144145.GY32494@hirez.programming.kicks-ass.net>
 <20190213154532.GQ32534@hirez.programming.kicks-ass.net>
In-Reply-To: <20190213154532.GQ32534@hirez.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 Feb 2019 15:19:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiSqQtuudpKSa9RwEGALw-Yw7v+YFonAEcNPEbY_-0m+g@mail.gmail.com>
Message-ID: <CAHk-=wiSqQtuudpKSa9RwEGALw-Yw7v+YFonAEcNPEbY_-0m+g@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] uaccess: Check no rescheduling function is called
 in unsafe region
To: Peter Zijlstra <peterz@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_151933_073660_51AC5AEE 
X-CRM114-Status: GOOD (  16.05  )
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
Cc: dvlasenk@redhat.com, brgerst@gmail.com,
 Julien Thierry <julien.thierry@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Will Deacon <will.deacon@arm.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 valentin.schneider@arm.com, Ingo Molnar <mingo@redhat.com>,
 James Morse <james.morse@arm.com>, Andrew Lutomirski <luto@kernel.org>,
 Peter Anvin <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 13, 2019 at 7:45 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Before that, x86_64 switch_to() read like (much simplified):
>
>         asm volatile ( /* do RSP twiddle */
>           : /* output */
>           : /* input */
>           : "memory", "cc", .... "flags");
>
> (see __EXTRA_CLOBBER)
>
> Which I suppose means that GCC generates the PUSHF/POPF to preserve the
> EFLAGS, since we mark those explicitly clobbered.

No, it only means that gcc won't keep conditionals in the flags over
the asm. It doesn't make gcc save anything.

The push/pop got removed elsewhere as Andy says.

That said, I do agree that it's probably a good idea to save/restore
flags anyway when scheduling. It's not just AC, actually, now that I
look at it again I worry a bit about DF too.

We have the rule that we run with DF clear in the kernel, and all the
kernel entry points do clear it properly (so that memcpy etc don't
need to). But there are a few places that set DF temporarily because
they do something odd (backwards memmove), and those atcually have the
*exact* same issue as stac/clac has: it's ok to take a trap or
interrupt, and schedule due to that (because the trap/irq will clear
DF), but it would be a horrible bug to have a synchronous scheduling
point there.

Arguably the DF issue really isn't even remotely likely to actually be
a real issue (the code that sets DF really is very special and should
never do any kind of preemption), but it's conceptually quite
similar..

Of course, if DF is ever set, and we end up calling any C code at all,
I guess it would already be a huge problem. If the C code then does
memcpy or something, it would corrupt things quite badly.

So I guess save/restore isn't going to save us wrt DF. If we get
anywhere close to the scheduler with the DF bit set, we've already
lost.

But I still do kind of prefer saving flags. We have other sticky state
in there too, although none of it matters in the kernel currently (eg
iopl etc - only matters in user space, and user space will always
reload eflags on return).

                 Linus

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
