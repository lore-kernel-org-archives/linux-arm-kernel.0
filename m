Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D71C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:36:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B985F208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tdjDCo11";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQYUvzFg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B985F208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AChWvnTcXC/9I6MCwCsEOwCzkqpBBRmuuD0aPh8lyBU=; b=tdjDCo11fy8Fb6
	bsNCwvGQEJzXaC9AFYj9IbzpyVGp+U8PxZhEQH6xzSoPSVJv+WtzOYzpGu1pQ1YRFJR0Egb0QiBnc
	i54ar2BfbhhkLTBFUy7tZAcywze0kD74XaLmGHZ3Q7jRdzYmjDXfDlFnNUHS0sZ9f47DgwGBAg73M
	U+p8Fd/qUuw9HR2cLzp6FUgKZKQyZv45iskEGj6kyzYv3BoIWRNCBDbZ76HXsIrgGkcHycyrvoJVY
	w54ws1pt2ss7Zn37drjpcUkwlNkTQGO2uyLqtY3WXm8VGYSWnywcDS4OTJWaHPFdegrNrqcaZkfla
	nB55pIAPmRl9+5rG+quA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUc25-0004zT-1T; Wed, 05 Dec 2018 18:36:25 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUc21-0004xe-NP
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 18:36:23 +0000
Received: by mail-wm1-x344.google.com with SMTP id y139so14264650wmc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 10:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=QdeLinFVWlRffPPHpnfEES3zo4hzZSLEoEYwaiieWlQ=;
 b=DQYUvzFgyT9aIMFj52X9fYmF9+HFOk16vU7bA+zH4ECEepnWIA6P9Daffin6+eJea/
 CYtYRNRwCbPUkura2R2TU3RO4VmT9CrYIMYzQpunfJsCLMx9ur1cHpfNiGSNDozLm6uh
 huSa0YPv92BQpTD9e/W493VH8KuWNEzjczfOQetHO7NoGLgUwPq/hFfjzncd1XyW5U3b
 E41jMakN5zx89o3U+pIPOYSEp7V7Ct1j/QV2feNjUR5VhOT3z/udXxbMONoJe7Vi+kHK
 /9hv0/Mp1xCFQGRzgJrXF7D8KSP1dhAi5SDokyp76JH9gLI3QTJ2H9neOW7Uev/JSEZe
 fQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=QdeLinFVWlRffPPHpnfEES3zo4hzZSLEoEYwaiieWlQ=;
 b=i2U9Y1Gxpz+tenhCfF7LadjHtN5rRt1Uvu4vE17bT1ZOzVFdHVJP0aQVO6TH/afYIH
 adWcB8oLYEW8Zl1Bpev1MhJMYesX1RxwLVUGu99eHk3B773yyjt3pIhqUS7a8h0v9+6Y
 0QWrwRfI1KWVVq3HUkM5Oixu7v5hhg1TlFQPkhAw4s6CQpy/eOSToT4iqb2+kg7Mqnvd
 v+E3in/aSNJwztEg3jrqZhhH66C0TuQ/spxJeSKfe0KY5gP37StMpDJETzrMC2RY7P/N
 e9usRH+47N7PZ22RcVlNjpVqT8IJTXfEbdEDvB4Y/Eu5aMHiLyTNWVLOWyQ56bqxkRxv
 ZqBA==
X-Gm-Message-State: AA+aEWYSOcssYXqbgfXYBn70I009CX0DClDi77Ea0E8P9+mugg3pB2bX
 8q76wabcapkbVs4TFe92+ac=
X-Google-Smtp-Source: AFSGD/VdnihbwcrWWNsq+TpV00iIjO/2MKYax/+IfJcMzBjitTLGR5ORcnMu5mgwVKxjwyjn4nMDRg==
X-Received: by 2002:a1c:96ce:: with SMTP id y197mr17695633wmd.36.1544034969401; 
 Wed, 05 Dec 2018 10:36:09 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
 by smtp.gmail.com with ESMTPSA id h16sm31801534wrb.62.2018.12.05.10.36.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 05 Dec 2018 10:36:08 -0800 (PST)
Date: Wed, 5 Dec 2018 11:36:06 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH 2/2] ARM: Wrap '--pic-veneer' with ld-option
Message-ID: <20181205183606.GA7274@flashbox>
References: <20181205014213.943-1-natechancellor@gmail.com>
 <20181205014213.943-2-natechancellor@gmail.com>
 <CAKv+Gu-N9j5X4WoFDbQrzeOCfBaNm6ujXe_fAruusE_kWdj8iQ@mail.gmail.com>
 <20181205080645.GA11936@flashbox>
 <CAKv+Gu9Nq51Fj_14MYS6MEm0VPHOJB1CBFkCHmyC8Wt0=NWpRg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9Nq51Fj_14MYS6MEm0VPHOJB1CBFkCHmyC8Wt0=NWpRg@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_103621_766862_36446E40 
X-CRM114-Status: GOOD (  28.54  )
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
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Russell King <linux@armlinux.org.uk>, Stefan Agner <stefan@agner.ch>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 05, 2018 at 09:09:56AM +0100, Ard Biesheuvel wrote:
> (+ Arnd)
> 
> On Wed, 5 Dec 2018 at 09:06, Nathan Chancellor <natechancellor@gmail.com> wrote:
> >
> > On Wed, Dec 05, 2018 at 08:37:05AM +0100, Ard Biesheuvel wrote:
> > > On Wed, 5 Dec 2018 at 02:42, Nathan Chancellor <natechancellor@gmail.com> wrote:
> > > >
> > > > This flag is not supported by lld:
> > > >
> > > >     ld.lld: error: unknown argument: --pic-veneer
> > > >
> > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > >
> > > Hi Nate,
> > >
> > > Does this mean ld.lld is guaranteed to produce position independent
> > > veneers if you build kernels that are bigger than the typical range of
> > > a relative branch?
> > >
> >
> > Hi Ard,
> >
> > Honestly, I'm not quite sure. I saw your commit that introduced this
> > flag and I wasn't quite sure what to make of it for lld. What
> > configuration would I use to verify and what would I check for?
> >
> 
> Try building allyesconfig, and check the resulting binary for veneers
> (which have 'veneer' in the symbol name, at least when ld.bfd emits
> them). These veneers should not take the [virtual] address of the
> branch target directly, but take a PC relative offset (as in the
> example in the commit log of that patch you are referring to)
> 

Alright, compiling with allyesconfig is a little rough at the moment
(bug reports I will file in due time) but I was able to do it. Here's
the disassembly specifically for the functions you had in your commit,
my assembly knowledge is pretty much non-existent unfortunately so I am
not sure what to make of it (it doesn't look like there is a virtual
address for pc in that mix?). I am happy to provide any more information
that is needed.

c03030cc <__enable_mmu>:
c03030cc:	e3c00002 	bic	r0, r0, #2
c03030d0:	e3c00b02 	bic	r0, r0, #2048	; 0x800
c03030d4:	e3c00a01 	bic	r0, r0, #4096	; 0x1000
c03030d8:	e3a05051 	mov	r5, #81	; 0x51
c03030dc:	ee035f10 	mcr	15, 0, r5, cr3, cr0, {0}
c03030e0:	ee024f10 	mcr	15, 0, r4, cr2, cr0, {0}
c03030e4:	eafff3c5 	b	c0300000 <__turn_mmu_on>
c03030e8:	e320f000 	nop	{0}
c03030ec:	e320f000 	nop	{0}
c03030f0:	e320f000 	nop	{0}
c03030f4:	e320f000 	nop	{0}
c03030f8:	e320f000 	nop	{0}
c03030fc:	e320f000 	nop	{0}

c0300000 <__turn_mmu_on>:
c0300000:	e1a00000 	nop			; (mov r0, r0)
c0300004:	ee070f95 	mcr	15, 0, r0, cr7, cr5, {4}
c0300008:	ee010f10 	mcr	15, 0, r0, cr1, cr0, {0}
c030000c:	ee103f10 	mrc	15, 0, r3, cr0, cr0, {0}
c0300010:	ee070f95 	mcr	15, 0, r0, cr7, cr5, {4}
c0300014:	e1a03003 	mov	r3, r3
c0300018:	e1a0300d 	mov	r3, sp
c030001c:	e1a0f003 	mov	pc, r3

Thanks,
Nathan

> > Additionally, I have filed an LLVM bug for the lld developers to
> > check and see if this is a flag they should support:
> >
> > https://bugs.llvm.org/show_bug.cgi?id=39886
> >
> > Thanks for the quick reply,
> > Nathan
> >
> > > > ---
> > > >  arch/arm/Makefile | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> > > > index e2a0baf36766..4fab2aa29570 100644
> > > > --- a/arch/arm/Makefile
> > > > +++ b/arch/arm/Makefile
> > > > @@ -10,7 +10,7 @@
> > > >  #
> > > >  # Copyright (C) 1995-2001 by Russell King
> > > >
> > > > -LDFLAGS_vmlinux        := --no-undefined -X --pic-veneer
> > > > +LDFLAGS_vmlinux        := --no-undefined -X $(call ld-option,--pic-veneer)
> > > >  ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
> > > >  LDFLAGS_vmlinux        += --be8
> > > >  KBUILD_LDFLAGS_MODULE  += --be8
> > > > --
> > > > 2.20.0.rc1
> > > >

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
