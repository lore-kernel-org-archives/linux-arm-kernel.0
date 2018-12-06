Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B22AC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:47:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5049C20868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jDcTIJNY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SRcsjsJX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5049C20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=alJ6AXR6eHHZ5FBgZQjUAQW4GLZJG0qVwgvZmtLt2Ro=; b=jDcTIJNYTJXAVR
	/XwhRdWvKFsr+c6f3Gde9T5F4Az9LrK/SQWe6iKlrq5yxX+vULvhX7d+socJwlCgkbU5piN/nQ8P4
	/yFf7TtPSN4TUJnK2onHn+Y5NtyrVUURiuua08lpj1p9UxtY5xFjXN2UQU9EwwMI+Y3zstUlRBvIT
	7GkspMJBZz74DWCAGSan/3K2ZV9Kw1bH1SBP9EBfoq6uu7EfeJ1drO6Oe2Zc+zN5KlV3B4DiychO+
	GiQo9I5D/2IbkOim7dXs67QzSpL2p3MigLacXaQy3SHS2NSZWONhW6h6kdDPlvcLIVyjCFRULbgxv
	5IrhogXlaOINh6mnOsYA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUs86-0004WL-Ve; Thu, 06 Dec 2018 11:47:42 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUs83-0004Vc-OI
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 11:47:41 +0000
Received: by mail-it1-x142.google.com with SMTP id x19so874310itl.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 03:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=z/7EUJSRcshyk5FgWqQc80b94ERQVmxzhHociOyW6EQ=;
 b=SRcsjsJXCtGfkj14kUC7Ynvjk+jTNd+X4b4z/b+fNniJZIksuAPxtQwYzERq94NX1G
 sOj46AzDY3IVv6bQLm3RV5B3M2xSivxFRCLMV7DMNXC2/B/u6tWACmbwuBtVeK2V6l5G
 Ete34gXBzOISCfz/HxuKcLWLT0GEqRYp3btIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z/7EUJSRcshyk5FgWqQc80b94ERQVmxzhHociOyW6EQ=;
 b=Xg7hOCFN7ZJcJb3pu9aXsJOvsEwLfGAjxxu6OrOjE3cpcXILLqOUTYjfhv5TULTNb5
 9wRmjELRXHEnkeTA22LxST2fy/YRZSnFjJ7aFKv1lA0MTephRqH/NB+Wbb+ZgCcezPd9
 GuSTPQkpOV0QHOSl5qqhHtGnBmMhxYBy68RNO8jVr3lxzOnTRZ/gsdmtRxC0hgF2JXGE
 xy40L2aIZTcEAKmGQzb6CSMgzmacfWOaSgMiKCoAfax+VRJglM+AGzuuLvp+zwMdd6OW
 s2/potAv76widWi7ZYBxBVbt4wPuEEY+Hil9YTuCNwkQdYg62AY66nQtypOfo/6mWhkm
 JH+w==
X-Gm-Message-State: AA+aEWaykLGF0MMKk2W+f4eDMhVGBP7TOHAaeW+ONht1vjN+WTg+hYbm
 z2NSRo/f03Ke+kH0JDnEqnjzk7BbXlXnK4WteLPaWQ==
X-Google-Smtp-Source: AFSGD/Xv7FHODMpJdS6JybIkXvXcYLPXci57l/RmaH9cBSa7xDTKHuDsuUtQaQYeWa3y6TQuZ4MyfJUPLFvZzo5QvKc=
X-Received: by 2002:a02:4c9:: with SMTP id 192mr25352693jab.2.1544096848688;
 Thu, 06 Dec 2018 03:47:28 -0800 (PST)
MIME-Version: 1.0
References: <20181201110144.15970-1-ard.biesheuvel@linaro.org>
 <c5c51e6a-a4d6-ca3d-b413-1ecbbf7186f5@arm.com>
 <CAKv+Gu88W79sMoCFse4iaXwr=N1JT73-htvmGSQkVHdP1DaAYA@mail.gmail.com>
 <20181203174506.GA28497@arm.com>
 <20181206112026.GV3505@e103592.cambridge.arm.com>
In-Reply-To: <20181206112026.GV3505@e103592.cambridge.arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 6 Dec 2018 12:47:16 +0100
Message-ID: <CAKv+Gu9oQbJHXThZYWue_Mko-CtfT2dcqXozTxs5TXy_UfaYRA@mail.gmail.com>
Subject: Re: [PATCH] arm64/mm: use correct operators for string comparison in
 cache.S
To: Dave Martin <Dave.Martin@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_034739_801210_5D021754 
X-CRM114-Status: GOOD (  29.32  )
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
 Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 6 Dec 2018 at 12:20, Dave Martin <Dave.Martin@arm.com> wrote:
>
> On Mon, Dec 03, 2018 at 05:45:06PM +0000, Will Deacon wrote:
> > On Mon, Dec 03, 2018 at 02:22:14PM +0100, Ard Biesheuvel wrote:
> > > On Mon, 3 Dec 2018 at 14:11, Robin Murphy <robin.murphy@arm.com> wrote:
> > > > On 01/12/2018 11:01, Ard Biesheuvel wrote:
> > > > > The GAS directives that are currently being used in dcache_by_line_op
> > > > > rely on assembler behavior that is not documented, and probably not
> > > > > guaranteed to produce the correct behavior going forward.
> > > > >
> > > > > Currently, we end up with some undefined symbols in cache.o:
> > > > >
> > > > > $ nm arch/arm64/mm/cache.o
> > > > >        ...
> > > > >        U civac
> > > > >        ...
> > > > >        U cvac
> > > > >        U cvap
> > > > >        U cvau
> > > > >
> > > > > This is due to the fact that the comparisons used to select the
> > > > > operation type in the dcache_by_line_op macro are comparing symbols
> > > > > not strings, and even though it seems that GAS is doing the right
> > > > > thing here (undefined symbols by the same name are equal to each
> > > > > other), it seems unwise to rely on this.
> > > > >
> > > > > So let's provide some definitions that are guaranteed to be distinct,
> > > > > and make them local so they don't pollute the gobal symbol space.
> > > >
> > > > Rather than making the unintended symbol comparisons work properly, can
> > > > we not just implement the string comparisons that were supposed to be?
> > > > Superficially, the diff below seems to still generate the desired output
> > > > (although as always there's probably some subtlety I'm missing).
> > > >
> > > > Robin.
> > > >
> > > > ----->8-----
> > > >
> > > > diff --git a/arch/arm64/include/asm/assembler.h
> > > > b/arch/arm64/include/asm/assembler.h
> > > > index 6142402c2eb4..2c5f4825fee3 100644
> > > > --- a/arch/arm64/include/asm/assembler.h
> > > > +++ b/arch/arm64/include/asm/assembler.h
> > > > @@ -383,13 +383,13 @@ alternative_endif
> > > >         sub     \tmp2, \tmp1, #1
> > > >         bic     \kaddr, \kaddr, \tmp2
> > > >   9998:
> > > > -       .if     (\op == cvau || \op == cvac)
> > > > +       .if     ("\op" == "cvau" || "\op" == "cvac")
> > > >   alternative_if_not ARM64_WORKAROUND_CLEAN_CACHE
> > > >         dc      \op, \kaddr
> > > >   alternative_else
> > > >         dc      civac, \kaddr
> > > >   alternative_endif
> > > > -       .elseif (\op == cvap)
> > > > +       .elseif ("\op" == "cvap")
>
> (Whatever this looks like, it's still comparing symbols someone probably
> already pointed that out.  Oh, and the () are redundant.  This isn't C,
> but, meh.)
>
> > > >   alternative_if ARM64_HAS_DCPOP
> > > >         sys 3, c7, c12, 1, \kaddr       // dc cvap
> > > >   alternative_else
> > > >
> > >
> > > Looking at the GAS info pages, I find
> > >
> > > "Operators" are arithmetic functions, like '+' or '%'.
> > > "Arguments" are symbols, numbers or subexpressions.
> > > An "expression" specifies an address or numeric value.
> > >
> > > so even if the comparison works as expected, I'm hesitant to rely on
> > > it to work as expected on any version of GAS or any other assembler
> > > claiming to implement the GAS asm dialect.
> > >
> > > We could change the logic to .ifc, which is defined to operate on string, i.e.,
> >
> > That looks better to me, although I'm not sure why you're inverted the logic
> > here:
> >
> > >     .ifnc \op, civac
> > >     .ifnc \op, cvap
> >
> > What am I missing?
>
> I vote for the .ifc approach.
>
> Note, the current works-by-accident approach using == has the odd side-
> effect of spitting out undefined symbol references in the .o file.  It
> seems that isn't breaking the link, but I wonder whether there are any
> side-effects we're not aware of.
>

Did you read the commit log at all? :-)

> If we don't like the inverted logic, there is always
>
>         .set .L__foo_\@, 0
>         .ifc \op, civac
>         .set .L__foo_\@, 1
>         .endif
>         .ifc \op, cvap
>         .set .L__foo_\@, 1
>         .endif
>
>         .if .L__foo_\@
>         // ...
>         .endif
>
> which is ugly.  Either way, the logic could be wrapped as a helper:
>
>         .macro if_string_is_either str, cmp1, cmp2, insn:vararg
>                 .ifnc "\str","\cmp1"
>                 .ifnc "\str","\cmp2"
>                 .exitm
>                 .endif
>                 .endif
>
>                 \insn
>         .endm
>

Yeah, I don't think this is an improvement over using inverted logic.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
