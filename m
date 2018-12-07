Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5197C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:04:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4D952082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C+TcyDd0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D0CL+/n5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D952082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0aymVcqImNVy5GqpSr+XTm5NPdmYGGNoAAytZBhuKc8=; b=C+TcyDd0/Lu70J
	HKs15a99vifILV4jmopKx7QuXOtmK8SCvhKkphWjeItpLQ7cLLIClIGKro/QCq6w1mn608osofeQK
	MKP9z2RBxML3kbEWj0NlbegycEhicBeVv1W3eZpqPPIFB8eUGMaB6xXD4ML+7rMdCSuXkFdGzRKmt
	5ponTx/Evdt2NCarjEEMsjRooOMuANBIQXtjkBr+2+M4M4pyZwnjBUkzAHHQTGBq08LPRGkY/f6Cw
	7r1hPMulFpQHvgFZRFj46jYClZep9j5pltCIp1XIlu4SjGbj2J6YoYQK3CJsfJJwo6hJHoahLxl71
	RKH3kROUZwsxoCSFMyxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVJXl-0005Ul-Vp; Fri, 07 Dec 2018 17:04:01 +0000
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVJXi-0005Tj-4X
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 17:03:59 +0000
Received: by mail-io1-xd41.google.com with SMTP id t24so3846914ioi.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 09:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DVJcU4voi44kmH6GQvIqQ8aKhXjnT/U/2Ec1QAFi4eE=;
 b=D0CL+/n5gp6MRTKT6P8xFXUkGi/ArTcCZRywQvJ9DAF2ZLNbUMlKjIUOiVt9e4FZ7J
 Wk/5Yy02UBuFuSgpfs2K+N2VBHRrB/Hm1XewlVnMD8jzGUzSoQsr93/XmpRJWStpc/Ul
 D92LJpmvSXmXLDGauX5MOWOMqbXMLHFshR0cE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DVJcU4voi44kmH6GQvIqQ8aKhXjnT/U/2Ec1QAFi4eE=;
 b=BOPWdi4wTkpZEcuyPiWR4cUE3QA5UxBJyLdEauQGi6vo/bteE9cPE9EPe1dsKD9PW8
 ODAAk8IyBo4qbaUacaVMrvDpx+PLy8haBAtkrbxpEEB3BGvPm9CpSSLrzcqow3phZgXm
 lf6r5gwynz2o1LiLs4oeuIcRstapGjMrO9KNGjbVDMn8rVPKtHJWHs53n7XHClC1kjMC
 rBxgL9SIDc6n6wveG3eYHepxi4/sQjdAWf0lKjbL+3mM26h48t6zCyD4kG4mmKH66PK5
 /60gqotYs4ip2YEKgyD/A9O2kknLkBdcK1ptzwGcfe/mB8RC9Dwi465tBGGQbnStUBhS
 jjHg==
X-Gm-Message-State: AA+aEWaVk4DhPKJHk8C0f82VrRtRjvNuQ3gk5zeUKroTYrkteQZ11E1P
 vbhQZ6TlNL/AkQckHeCdbEsEmL+20jeQBXza2u3dxR4s
X-Google-Smtp-Source: AFSGD/UuNDHmoTXQXiLL1xPRqRYUWYhNwWe6kWLPiMaQRaQcVgb3n8AWG993+goasglhX8kv+h0xGyBw1c+cgDxCYb0=
X-Received: by 2002:a6b:5d01:: with SMTP id r1mr2173927iob.170.1544202226826; 
 Fri, 07 Dec 2018 09:03:46 -0800 (PST)
MIME-Version: 1.0
References: <1543347887-21101-1-git-send-email-will.deacon@arm.com>
 <1543347887-21101-3-git-send-email-will.deacon@arm.com>
 <CAKv+Gu9jR3EgWDzyNB3YNRrvtD2L5Xo81VJ5+FpufDTNqSs8Kw@mail.gmail.com>
 <20181207154952.GA4000@edgewater-inn.cambridge.arm.com>
 <CAKv+Gu9deCArTiuGXSw3U0hzFTd27DJmr+m1vFy+VOWZa41QuA@mail.gmail.com>
 <20181207162224.GA4159@edgewater-inn.cambridge.arm.com>
In-Reply-To: <20181207162224.GA4159@edgewater-inn.cambridge.arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 7 Dec 2018 18:03:35 +0100
Message-ID: <CAKv+Gu_Pq8+JGZ9QCAj+U7JreqD3WzW68gJf5ZxY1tHjaS5ZUQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm64: Avoid masking "old" for LSE cmpxchg()
 implementation
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_090358_179609_CBDC2469 
X-CRM114-Status: GOOD (  25.03  )
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

On Fri, 7 Dec 2018 at 17:22, Will Deacon <will.deacon@arm.com> wrote:
>
> On Fri, Dec 07, 2018 at 05:05:16PM +0100, Ard Biesheuvel wrote:
> > On Fri, 7 Dec 2018 at 16:49, Will Deacon <will.deacon@arm.com> wrote:
> > >
> > > Hi Ard,
> > >
> > > On Tue, Dec 04, 2018 at 05:58:50PM +0100, Ard Biesheuvel wrote:
> > > > On Tue, 27 Nov 2018 at 20:44, Will Deacon <will.deacon@arm.com> wrote:
> > > > >
> > > > > The CAS instructions implicitly access only the relevant bits of the "old"
> > > > > argument, so there is no need for explicit masking via type-casting as
> > > > > there is in the LL/SC implementation.
> > > > >
> > > > > Move the casting into the LL/SC code and remove it altogether for the LSE
> > > > > implementation.
> > > > >
> > > > > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > > > > ---
> > > > >  arch/arm64/include/asm/atomic_ll_sc.h | 8 ++++++++
> > > > >  arch/arm64/include/asm/atomic_lse.h   | 4 ++--
> > > > >  arch/arm64/include/asm/cmpxchg.h      | 4 ++--
> > > > >  3 files changed, 12 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/arch/arm64/include/asm/atomic_ll_sc.h b/arch/arm64/include/asm/atomic_ll_sc.h
> > > > > index f02d3bf7b9e6..b53f70dd6e10 100644
> > > > > --- a/arch/arm64/include/asm/atomic_ll_sc.h
> > > > > +++ b/arch/arm64/include/asm/atomic_ll_sc.h
> > > > > @@ -257,6 +257,14 @@ __LL_SC_PREFIX(__cmpxchg_case_##name##sz(volatile void *ptr,               \
> > > > >         unsigned long tmp;                                              \
> > > > >         u##sz oldval;                                                   \
> > > > >                                                                         \
> > > > > +       /*                                                              \
> > > > > +        * Sub-word sizes require explicit casting so that the compare  \
> > > > > +        * part of the cmpxchg doesn't end up interpreting non-zero     \
> > > > > +        * upper bits of the register containing "old".                 \
> > > > > +        */                                                             \
> > > > > +       if (sz < 32)                                                    \
> > > > > +               old = (u##sz)old;                                       \
> > > > > +                                                                       \
> > > > >         asm volatile(                                                   \
> > > > >         "       prfm    pstl1strm, %[v]\n"                              \
> > > > >         "1:     ld" #acq "xr" #sfx "\t%" #w "[oldval], %[v]\n"          \
> > > > > diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
> > > > > index 4d6f917b654e..a424355240c5 100644
> > > > > --- a/arch/arm64/include/asm/atomic_lse.h
> > > > > +++ b/arch/arm64/include/asm/atomic_lse.h
> > > > > @@ -448,11 +448,11 @@ static inline long atomic64_dec_if_positive(atomic64_t *v)
> > > > >
> > > > >  #define __CMPXCHG_CASE(w, sfx, name, sz, mb, cl...)                    \
> > > > >  static inline u##sz __cmpxchg_case_##name##sz(volatile void *ptr,      \
> > > > > -                                             unsigned long old,        \
> > > > > +                                             u##sz old,                \
> > > > >                                               u##sz new)                \
> > > > >  {                                                                      \
> > > > >         register unsigned long x0 asm ("x0") = (unsigned long)ptr;      \
> > > > > -       register unsigned long x1 asm ("x1") = old;                     \
> > > > > +       register u##sz x1 asm ("x1") = old;                             \
> > > >
> > > > This looks backwards to me, but perhaps I am missing something:
> > > > changing from unsigned long to a narrower type makes it the compiler's
> > > > job to perform the cast, no? Given that 'cas' ignores the upper bits
> > > > anyway, what does this change buy us?
> > >
> > > A narrowing cast doesn't actually result in any additional instructions --
> > > the masking occurs if you do a widening cast. In this case, the change I'm
> > > proposing means we avoid the redundant widening casts for the LSE operations
> > > because, as you point out, the underlying instruction only operates on the
> > > relevant bits.
> > >
> >
> > Playing around with some code, I found out that
> >
> > static inline void foo(unsigned char x)
> > {
> >     asm("" :: "r"(x));
> > }
> >
> > void bar(unsigned long l)
> > {
> >     foo(l);
> > }
> >
> > produces different code than
> >
> > static inline void foo(unsigned longr x)
> > {
> >     asm("" :: "r"(x));
> > }
> >
> > void bar(unsigned long l)
> > {
> >     foo((unsigned char)l);
> > }
> >
> > so what you are saying appears to be accurate. Whether it is correct,
> > is another matter, though, since the 'unsigned char' argument passed
> > into the asm() block may have higher bits set.
>
> Right, which is why I've kept the casting for sizes < 32 bits in the LL/SC
> code.
>

OK.

So if we are relying on the cast to occur implicitly by the cas
instruction, does it really make sense to change the prototype?
Shouldn't we keep it at unsigned long so that we explicitly pass the
whole value in (but use an explicit cast in the LL/SC implementation
as you did)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
