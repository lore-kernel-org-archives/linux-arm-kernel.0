Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4882C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:19:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85AAB2082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oYjMFLXP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VCX7AMra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85AAB2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BTyaQbUfO28fZUgUgrX2KU01PLfxZrBWgO1BVUEHvas=; b=oYjMFLXPlsYQbd
	q/AJFdyf9P7JnKS7F6C1RMSmgoeuGoIsVmzk/VxiPM2TR4V9cmKgJFwyET6yQlk4aGjWoHJASo0ht
	PhOoXAvNI2D5TDUD871fEMvaFGDJXXgpCoEaRYusRLRo5CrCu6FcOi0UBR/wwe8+tFIbVkT3DUvC3
	xgOPNfmc6+jN0DswrcJ5EuOednTZlOdTfen6DiTDa2aUCKMKHzc7D2MmuuGW+qHWIIJA7rqeyDiBm
	0Cgf3W6CvVO7NmEOhiGbnX4WH/8tcib6KynC+zOkGREbQJTV2uIXNxoXtPGF5ktfPLa9Or0m+0veD
	/4obGY5t9n7oEBIxEvFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVJmW-0003ks-R2; Fri, 07 Dec 2018 17:19:16 +0000
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVJmS-0003kF-GQ
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 17:19:14 +0000
Received: by mail-io1-xd35.google.com with SMTP id f14so3850287iol.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 09:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LKjB/zRHMo7JF5eZDgdlk4PEoCBvCDpTk9CMfosG+E8=;
 b=VCX7AMrawELnXcT4HDKc/pNZf07VSyb53hox1K+/kIGRPdbf6kPlUcmW5WfyqEpJKV
 P5UxiM646GMrbVO7A58t5777qsQLTjM+nY2FzJk1rJDxHqo7mJSU9N0vLQ/PMs3KUNAk
 qIqH4cOPVxnLybZ6fGDt0pPHJY88V1XYfKp9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LKjB/zRHMo7JF5eZDgdlk4PEoCBvCDpTk9CMfosG+E8=;
 b=LDPxcFEaYUuPi2Sz9B5M2KTWEjeLMyNnLECDJrLzhqAGqowRrni4LQFhajVf8zTeAq
 eEG7GrIGhbAg/xbzlpykaTEQ/51krciiyygSvTjPYv0IM4W8PtFepHJvnAE9+nGem4XL
 1d+SlR1fm2xxmDmN6vx0C8Xuq8cC7lLWGajXd1L94+U7Q3n6sWd13rBiCrdGdHjVkwJI
 xof6Xtu7M/fG8+JDRdJLhf+pk/aBrdVoqYLbJWb/Z6xZ8VjJCKTPsgBEXUpkE08cbjv9
 kEzxatZiWrRIxjfyTp+qjzVu+Oq/qTmWHF6CVhU07qkcqluy5W18WUopxMoLI139aXGr
 0yXg==
X-Gm-Message-State: AA+aEWY/fell+5EQY/Y3Fpa70ofpGSrlTG4lwhlztEzlzHJpmzineCM6
 TNy9X2XmsLZFG+TYhZpBqcHSsSFqJjkr2f0yxzg7Qg==
X-Google-Smtp-Source: AFSGD/WrOKZrlicDDjvGACq6RYMfbzXXI/G7D+eOHXZYFQhMcf29ic/4IeqdBv2MLRYFDB8dGfb0hRs3/jkb7deNmRQ=
X-Received: by 2002:a5d:8415:: with SMTP id i21mr2326491ion.173.1544203141221; 
 Fri, 07 Dec 2018 09:19:01 -0800 (PST)
MIME-Version: 1.0
References: <1543347887-21101-1-git-send-email-will.deacon@arm.com>
 <1543347887-21101-3-git-send-email-will.deacon@arm.com>
 <CAKv+Gu9jR3EgWDzyNB3YNRrvtD2L5Xo81VJ5+FpufDTNqSs8Kw@mail.gmail.com>
 <20181207154952.GA4000@edgewater-inn.cambridge.arm.com>
 <CAKv+Gu9deCArTiuGXSw3U0hzFTd27DJmr+m1vFy+VOWZa41QuA@mail.gmail.com>
 <20181207162224.GA4159@edgewater-inn.cambridge.arm.com>
 <CAKv+Gu_Pq8+JGZ9QCAj+U7JreqD3WzW68gJf5ZxY1tHjaS5ZUQ@mail.gmail.com>
 <20181207171529.GA2044@edgewater-inn.cambridge.arm.com>
In-Reply-To: <20181207171529.GA2044@edgewater-inn.cambridge.arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 7 Dec 2018 18:18:49 +0100
Message-ID: <CAKv+Gu-PTnEeAjHc7b3fasDP6UG+gAfw0xHfzKnBC-6FV9QEfA@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm64: Avoid masking "old" for LSE cmpxchg()
 implementation
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_091912_556419_80D1C683 
X-CRM114-Status: GOOD (  23.40  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 7 Dec 2018 at 18:15, Will Deacon <will.deacon@arm.com> wrote:
>
> On Fri, Dec 07, 2018 at 06:03:35PM +0100, Ard Biesheuvel wrote:
> > On Fri, 7 Dec 2018 at 17:22, Will Deacon <will.deacon@arm.com> wrote:
> > > On Fri, Dec 07, 2018 at 05:05:16PM +0100, Ard Biesheuvel wrote:
> > > > On Fri, 7 Dec 2018 at 16:49, Will Deacon <will.deacon@arm.com> wrote:
> > > > > On Tue, Dec 04, 2018 at 05:58:50PM +0100, Ard Biesheuvel wrote:
> > > > > > On Tue, 27 Nov 2018 at 20:44, Will Deacon <will.deacon@arm.com> wrote:
> > > > > > > diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
> > > > > > > index 4d6f917b654e..a424355240c5 100644
> > > > > > > --- a/arch/arm64/include/asm/atomic_lse.h
> > > > > > > +++ b/arch/arm64/include/asm/atomic_lse.h
> > > > > > > @@ -448,11 +448,11 @@ static inline long atomic64_dec_if_positive(atomic64_t *v)
> > > > > > >
> > > > > > >  #define __CMPXCHG_CASE(w, sfx, name, sz, mb, cl...)                    \
> > > > > > >  static inline u##sz __cmpxchg_case_##name##sz(volatile void *ptr,      \
> > > > > > > -                                             unsigned long old,        \
> > > > > > > +                                             u##sz old,                \
> > > > > > >                                               u##sz new)                \
> > > > > > >  {                                                                      \
> > > > > > >         register unsigned long x0 asm ("x0") = (unsigned long)ptr;      \
> > > > > > > -       register unsigned long x1 asm ("x1") = old;                     \
> > > > > > > +       register u##sz x1 asm ("x1") = old;                             \
> > > > > >
> > > > > > This looks backwards to me, but perhaps I am missing something:
> > > > > > changing from unsigned long to a narrower type makes it the compiler's
> > > > > > job to perform the cast, no? Given that 'cas' ignores the upper bits
> > > > > > anyway, what does this change buy us?
> > > > >
> > > > > A narrowing cast doesn't actually result in any additional instructions --
> > > > > the masking occurs if you do a widening cast. In this case, the change I'm
> > > > > proposing means we avoid the redundant widening casts for the LSE operations
> > > > > because, as you point out, the underlying instruction only operates on the
> > > > > relevant bits.
> > > > >
> > > >
> > > > Playing around with some code, I found out that
> > > >
> > > > static inline void foo(unsigned char x)
> > > > {
> > > >     asm("" :: "r"(x));
> > > > }
> > > >
> > > > void bar(unsigned long l)
> > > > {
> > > >     foo(l);
> > > > }
> > > >
> > > > produces different code than
> > > >
> > > > static inline void foo(unsigned longr x)
> > > > {
> > > >     asm("" :: "r"(x));
> > > > }
> > > >
> > > > void bar(unsigned long l)
> > > > {
> > > >     foo((unsigned char)l);
> > > > }
> > > >
> > > > so what you are saying appears to be accurate. Whether it is correct,
> > > > is another matter, though, since the 'unsigned char' argument passed
> > > > into the asm() block may have higher bits set.
> > >
> > > Right, which is why I've kept the casting for sizes < 32 bits in the LL/SC
> > > code.
> > >
> >
> > OK.
> >
> > So if we are relying on the cast to occur implicitly by the cas
> > instruction, does it really make sense to change the prototype?
> > Shouldn't we keep it at unsigned long so that we explicitly pass the
> > whole value in (but use an explicit cast in the LL/SC implementation
> > as you did)
>
> If we change the prototype of the __cmpxchg_case_* functions so that the
> old and new parameters are unsigned long, then we'll get widening casts
> (and explicit masking) for any caller of cmpxchg() that passes narrower
> types such as u16.
>
> Or are you suggesting something else?
>

No. It's all a bit counter intuitive, at least to me, but if this gets
rid of the casts, then let's go with it.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
