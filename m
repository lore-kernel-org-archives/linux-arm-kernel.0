Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD6FC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:02:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A09D2082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="USxtUIqI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W009ofsd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A09D2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3LMrsUxeRJlNZ0Z1MgW3dAwemlQFC39+JrqoykmO/J8=; b=USxtUIqIY9T7Nz
	LpamGhv2GFT6k46oVbrDg/R3M+40OK0h6g16+ajseoAq/NRbo8jDHX9w1iADdGnQVGRIp1uhXD+rj
	tfStDZgMIuWbGoAf07uHbyHeAszZs4suWZqTxzt90JxOagRQ21ZK6jYCUD85UJBDjtU9YY7XhpEDb
	rJDkjM6vj9HbSwcWgnXxTd8AiiSwui8pTcyQJyY6GjF8xAQ3UAyf899XiKqsw0S4dC7WGvO+31PeK
	I3OEv8ZGPiPdsZ30r5gK3cBwlzrGF6VxHWuzKpRTBI7+zc1m8DprFbBDmSmzFL6qf8EBlojcOG74Q
	FiI3U3S8f/tSiZ14i2nQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVKSB-0006Lp-Ia; Fri, 07 Dec 2018 18:02:19 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVKS7-0006LH-DL
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 18:02:17 +0000
Received: by mail-it1-x141.google.com with SMTP id g76so8193669itg.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 10:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/jLwhnJ9d6Xz2ShK5DOagGRCfl4SzyAXVWDXMe+WzfQ=;
 b=W009ofsd7ZSHOS0m+3RJea5qOVeeH/ewv5Vma0UNZSbYlShdM+JZXBjwlhlIxeEt59
 fW+Go3u54wK6O+JpRT9ccDKfWAp7tiGj/hKPhRJG2v258lrcQaraLUdGkDG1kKlRark5
 4zS4Y7pJEXFTCnTPpvY0EAlyxwDlBRAxK2cZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/jLwhnJ9d6Xz2ShK5DOagGRCfl4SzyAXVWDXMe+WzfQ=;
 b=msfPs9o618SLQSgfiYazkfsB1Kcy73HkTDjatsH8gqqHEh12GyZEgZJc2sGUFnUzwl
 p6wJRQ7oig3rtjmQaGb5Rs3Y4qhIhREOgZMNvi8kvgP9uQVHgKclwGmgqenDlATSJDbu
 akGksxV8bnXmi8BgfPIpnbArvbwwTV26buINlnQm9xap0UPhxWS7bW3KGxpT9msLMwjt
 0906/hZBJfMWHhVCKVRlH78dMf0sIPE6YyxFUt04T4zRSZf43DzehrgKC6GALssiU6jP
 DLIKXuzEneT0YPXvOQkg8TXbxWy2pNT8I7YissvL1WHiM5HLzz+IXj1dp8d7mM3Z8TqI
 8IIw==
X-Gm-Message-State: AA+aEWaS8sdk1yhiu6pkNSr9X17mzsZdW9l6zan+bD2+dL98TPzjwVv0
 djkCqWBEuKEopaynh50k6U6hyjeOc7358/OwpRlYcg==
X-Google-Smtp-Source: AFSGD/WVOH6Tg65ui5G6TRAlopud6iFIzGU0JIdovz3BOxWNXXYsjHSISs1ytke3ijqu4Jbs9vWagScXKzgBu9CVXM8=
X-Received: by 2002:a02:4c9:: with SMTP id 192mr2673415jab.2.1544205724188;
 Fri, 07 Dec 2018 10:02:04 -0800 (PST)
MIME-Version: 1.0
References: <20181206155739.20229-1-ard.biesheuvel@linaro.org>
 <20181207175326.GB11430@edgewater-inn.cambridge.arm.com>
In-Reply-To: <20181207175326.GB11430@edgewater-inn.cambridge.arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 7 Dec 2018 19:01:52 +0100
Message-ID: <CAKv+Gu9LJzMm_xGQOZ=wS6Wr=W1hN7cS+GsVAS0mPUFJ3NT0ng@mail.gmail.com>
Subject: Re: [PATCH 0/5] arm64: assorted fixes for dcache_by_line_op
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_100215_465760_2BA51333 
X-CRM114-Status: GOOD (  19.63  )
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
Cc: "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Dave Martin <Dave.Martin@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 7 Dec 2018 at 18:53, Will Deacon <will.deacon@arm.com> wrote:
>
> Hi Ard,
>
> Cheers for looking at this.
>
> On Thu, Dec 06, 2018 at 04:57:34PM +0100, Ard Biesheuvel wrote:
> > This fixes two issues in dcache_by_line_op: patch #4 fixes the logic
> > that is applied when patching DC CVAP instructions, and patch #5 gets
> > rid of some unintended undefined symbols resulting from incorrect use
> > of conditional GAS directives.
> >
> > Patches #1 to #3 are groundwork for #4.
> >
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Suzuki Poulose <suzuki.poulose@arm.com>
> > Cc: Dave Martin <Dave.Martin@arm.com>
> >
> > Ard Biesheuvel (5):
> >   arm64/alternative_cb: move callback reference into replacements
> >     section
> >   arm64/alternative_cb: add nr_alts parameter to callback handlers
> >   arm64/alternative_cb: add support for alternative sequences
> >   arm64/assembler: use callback to 3-way alt-patch DC CVAP instructions
> >   arm64/mm: use string comparisons in dcache_by_line_op
> >
> >  arch/arm64/include/asm/alternative.h | 54 +++++++++++---------
> >  arch/arm64/include/asm/assembler.h   | 17 +++---
> >  arch/arm64/include/asm/kvm_mmu.h     |  4 +-
> >  arch/arm64/kernel/alternative.c      | 22 +++++---
> >  arch/arm64/kernel/cpu_errata.c       | 24 ++++++---
> >  arch/arm64/kvm/va_layout.c           |  8 +--
> >  6 files changed, 79 insertions(+), 50 deletions(-)
>
> Whilst I can see that this solves the problem, I do wonder whether the
> additional infrastructure is really worth it. Couldn't we just do something
> really simple like the diff below instead?
>

That looks fine to me, although not as elegant :-) You are in a better
position to assess if the additional infrastructure may see other uses
in the near future.

In any case, I don't feel strongly about it, so pick whatever you feel
is most suitable. (I just spotted the undefined symbols when I was
playing with lld.)


> --->8
>
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index 953208267252..8dea015b6599 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -390,27 +390,38 @@ alternative_endif
>   *     size:           size of the region
>   *     Corrupts:       kaddr, size, tmp1, tmp2
>   */
> +       .macro __dcache_op_workaround_clean_cache, op, kaddr
> +alternative_if_not ARM64_WORKAROUND_CLEAN_CACHE
> +       dc      \op, \kaddr
> +alternative_else
> +       dc      civac, \kaddr
> +alternative_endif
> +       .endm
> +
>         .macro dcache_by_line_op op, domain, kaddr, size, tmp1, tmp2
>         dcache_line_size \tmp1, \tmp2
>         add     \size, \kaddr, \size
>         sub     \tmp2, \tmp1, #1
>         bic     \kaddr, \kaddr, \tmp2
>  9998:
> -       .if     (\op == cvau || \op == cvac)
> -alternative_if_not ARM64_WORKAROUND_CLEAN_CACHE
> -       dc      \op, \kaddr
> -alternative_else
> -       dc      civac, \kaddr
> -alternative_endif
> -       .elseif (\op == cvap)
> +       .ifc    \op, cvau
> +       __dcache_op_workaround_clean_cache \op, \kaddr
> +       .else
> +       .ifc    \op, cvac
> +       __dcache_op_workaround_clean_cache \op, \kaddr
> +       .else
> +       .ifc    \op, cvap
>  alternative_if ARM64_HAS_DCPOP
>         sys 3, c7, c12, 1, \kaddr       // dc cvap
> -alternative_else
> -       dc      cvac, \kaddr
> -alternative_endif
> +       b       9996f
> +alternative_else_nop_endif
> +       __dcache_op_workaround_clean_cache cvac, \kaddr
> +9996:
>         .else
>         dc      \op, \kaddr
>         .endif
> +       .endif
> +       .endif
>         add     \kaddr, \kaddr, \tmp1
>         cmp     \kaddr, \size
>         b.lo    9998b

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
