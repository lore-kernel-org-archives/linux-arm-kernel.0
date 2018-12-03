Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C5BC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:22:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41E8120834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CmJ+sm1X";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="c8n4+MKg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E8120834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GmCDQgZvsH4tIoySM62rmpqyemtDkfLYUcfW7dvMEsw=; b=CmJ+sm1XERZDgK
	Czq8VSB7QFXw6YZ2XxY3BTi1XDCYy7qc9VZJeN0TA+NokdRn7/+bQ63bPhvGrucgZeDFG7vssXa+R
	6VZLIptu9Q6FCj3qvphxLug2wZpetH0iBj3FULQF6uhEvtH5NUGOh25mXdG1rdaPSxU8QWIYVMXIf
	WfZ41Zvl2OCR1cD/Cgvx4OQHWWRu0nKuEfVbMQMi/Hvp8exJhgStID127Vo6sJLYJn9wPWVR4yjWS
	VZ7UODA977TO55GLOW0bln58pQ16Ywn3Nef/9rFw5vfdDD4wGEVC+uFswmRWHRRw9G+asmqYnb7KX
	da4ZJtYX+47CTc0NHpMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gToBO-0000dG-4K; Mon, 03 Dec 2018 13:22:42 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gToBL-0000cu-3W
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 13:22:40 +0000
Received: by mail-it1-x142.google.com with SMTP id x124so8402589itd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 05:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=76PfNSqko18tS0DDVfe88YF5Ck7VccbiQNMMS/N08uo=;
 b=c8n4+MKguJTnD9y3dPl+4tpZ3/9L/k2xa+vnbaXAO486lOuBOL1wVLYAQwJiCJK/OR
 FKQorIhzb/KF8gQ8FMVspz3F+ovatSTXGa2ShYN3g2PyXJdSlTXefo5iHkTsI12Pqvkp
 9GP/YaAr221jBCWus1Do9zxxPXezUu0Hwttas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=76PfNSqko18tS0DDVfe88YF5Ck7VccbiQNMMS/N08uo=;
 b=o9idXYePo5jrVmn/awb78/tWC5TLavOf9w5wD26RG306dnCwJIfs2c0YAJAN2Ug73v
 iW/byW8YBL/rU0sMZqLc5JCbuOC9LmBaNtciQhQ+zKUrs8cjWe84rxePmJxhXuw8334x
 qH36Xnj2uEzHpZW7YRpLt9Xza+Ka8PxT4JNzKPJt5jMW0z1bLybnCzjUxtDljED5/VHE
 Gvranh7YnWeyJHpjnrfzkFTYN257Pw0my4XsEdGqIjQxkFvhfvDoC57G7w8P3TEu81J2
 zoDUJAGoLWJkPFv2tX2L42Feqs8ewb0aAk0nAVh5VCOyNO8A7kzBR4wDPJIEtWBM5hDl
 Qd2g==
X-Gm-Message-State: AA+aEWZXsMROXC4mEFng+T1SjbxMUMjQIG9ICi28feBcMn/TeelR5Sk5
 GE3deIGe7WQ7cQG3o5YHtI80F/REMDXJr2k4oCrHOHPClL91dg==
X-Google-Smtp-Source: AFSGD/UrQRkBkP+ZEVXLBle3x5mzP81l5QfZw/7PLeQfx+ChVb36nWjPGA609JQsSOHeUpM7SuTdYScIbggmZwhIxVM=
X-Received: by 2002:a24:edc4:: with SMTP id r187mr8540043ith.158.1543843347613; 
 Mon, 03 Dec 2018 05:22:27 -0800 (PST)
MIME-Version: 1.0
References: <20181201110144.15970-1-ard.biesheuvel@linaro.org>
 <c5c51e6a-a4d6-ca3d-b413-1ecbbf7186f5@arm.com>
In-Reply-To: <c5c51e6a-a4d6-ca3d-b413-1ecbbf7186f5@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 3 Dec 2018 14:22:14 +0100
Message-ID: <CAKv+Gu88W79sMoCFse4iaXwr=N1JT73-htvmGSQkVHdP1DaAYA@mail.gmail.com>
Subject: Re: [PATCH] arm64/mm: use correct operators for string comparison in
 cache.S
To: Robin Murphy <robin.murphy@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_052239_160868_C3335250 
X-CRM114-Status: GOOD (  23.67  )
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
 Will Deacon <will.deacon@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 3 Dec 2018 at 14:11, Robin Murphy <robin.murphy@arm.com> wrote:
>
> Hi Ard,
>
> On 01/12/2018 11:01, Ard Biesheuvel wrote:
> > The GAS directives that are currently being used in dcache_by_line_op
> > rely on assembler behavior that is not documented, and probably not
> > guaranteed to produce the correct behavior going forward.
> >
> > Currently, we end up with some undefined symbols in cache.o:
> >
> > $ nm arch/arm64/mm/cache.o
> >        ...
> >        U civac
> >        ...
> >        U cvac
> >        U cvap
> >        U cvau
> >
> > This is due to the fact that the comparisons used to select the
> > operation type in the dcache_by_line_op macro are comparing symbols
> > not strings, and even though it seems that GAS is doing the right
> > thing here (undefined symbols by the same name are equal to each
> > other), it seems unwise to rely on this.
> >
> > So let's provide some definitions that are guaranteed to be distinct,
> > and make them local so they don't pollute the gobal symbol space.
>
> Rather than making the unintended symbol comparisons work properly, can
> we not just implement the string comparisons that were supposed to be?
> Superficially, the diff below seems to still generate the desired output
> (although as always there's probably some subtlety I'm missing).
>
> Robin.
>
> ----->8-----
>
> diff --git a/arch/arm64/include/asm/assembler.h
> b/arch/arm64/include/asm/assembler.h
> index 6142402c2eb4..2c5f4825fee3 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -383,13 +383,13 @@ alternative_endif
>         sub     \tmp2, \tmp1, #1
>         bic     \kaddr, \kaddr, \tmp2
>   9998:
> -       .if     (\op == cvau || \op == cvac)
> +       .if     ("\op" == "cvau" || "\op" == "cvac")
>   alternative_if_not ARM64_WORKAROUND_CLEAN_CACHE
>         dc      \op, \kaddr
>   alternative_else
>         dc      civac, \kaddr
>   alternative_endif
> -       .elseif (\op == cvap)
> +       .elseif ("\op" == "cvap")
>   alternative_if ARM64_HAS_DCPOP
>         sys 3, c7, c12, 1, \kaddr       // dc cvap
>   alternative_else
>

Looking at the GAS info pages, I find

"Operators" are arithmetic functions, like '+' or '%'.
"Arguments" are symbols, numbers or subexpressions.
An "expression" specifies an address or numeric value.

so even if the comparison works as expected, I'm hesitant to rely on
it to work as expected on any version of GAS or any other assembler
claiming to implement the GAS asm dialect.

We could change the logic to .ifc, which is defined to operate on string, i.e.,

    .ifnc \op, civac
    .ifnc \op, cvap
alternative_if_not ARM64_WORKAROUND_CLEAN_CACHE
    dc \op, \kaddr
alternative_else
    dc civac, \kaddr
alternative_endif
    .else
alternative_if ARM64_HAS_DCPOP
    sys 3, c7, c12, 1, \kaddr // dc cvap
alternative_else
    dc cvac, \kaddr
alternative_endif
    .endif
    .else
     dc      civac, \kaddr
    .endif

> >
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> >   arch/arm64/include/asm/assembler.h | 9 +++++++--
> >   1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> > index 6142402c2eb4..d11c32df85c2 100644
> > --- a/arch/arm64/include/asm/assembler.h
> > +++ b/arch/arm64/include/asm/assembler.h
> > @@ -377,19 +377,24 @@ alternative_endif
> >    *  size:           size of the region
> >    *  Corrupts:       kaddr, size, tmp1, tmp2
> >    */
> > +     .set    .Lcvau,  0
> > +     .set    .Lcvac,  1
> > +     .set    .Lcvap,  2
> > +     .set    .Lcivac, 3
> > +
> >       .macro dcache_by_line_op op, domain, kaddr, size, tmp1, tmp2
> >       dcache_line_size \tmp1, \tmp2
> >       add     \size, \kaddr, \size
> >       sub     \tmp2, \tmp1, #1
> >       bic     \kaddr, \kaddr, \tmp2
> >   9998:
> > -     .if     (\op == cvau || \op == cvac)
> > +     .if     (.L\op == .Lcvau || .L\op == .Lcvac)
> >   alternative_if_not ARM64_WORKAROUND_CLEAN_CACHE
> >       dc      \op, \kaddr
> >   alternative_else
> >       dc      civac, \kaddr
> >   alternative_endif
> > -     .elseif (\op == cvap)
> > +     .elseif (.L\op == .Lcvap)
> >   alternative_if ARM64_HAS_DCPOP
> >       sys 3, c7, c12, 1, \kaddr       // dc cvap
> >   alternative_else
> >

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
