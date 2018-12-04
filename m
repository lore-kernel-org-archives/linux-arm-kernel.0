Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F31C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:44:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0D8C2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qL48A/3P";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="X2Jv3A/A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D8C2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Yvtf8RCrfq9uB5PTymR5E05j9SsbWgnzooDS1y7tsFw=; b=qL48A/3PfcKcz4
	k+YgkIuo3ZqUbKoCysAZB1vs30JUnS18Yn9yF9dDCABgnrDKoxtCYzPdObrKvGW2JLaa63H16t1pw
	A0OsyR3C76015ezvSNUdxj2s0qfw0Iq6amIvz6hbpylEMB6a1OFrMDsIk3JcxDvHnvjaPndCbFmRg
	CFY2zloiNuyppToA1M0ZgeeAeIxA8RKBkuBTKO7R0HTgJXhBYqGtxy78bt6ziob6Q6blcRjSuvlV1
	uktHDaMe+L7WNz5t/PoM/eHibhaCilSyjh/JOyP/yfy5BuGvwiyDdrJ6eMO0IA73UqxnEw7itWJ3w
	U1qSSFfOJrZlgdv3XLIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTypB-0007uT-C6; Tue, 04 Dec 2018 00:44:29 +0000
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTyp6-0007tv-KF
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 00:44:27 +0000
Received: by mail-io1-xd42.google.com with SMTP id n9so4146388ioo.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 16:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XamOsHdCDf3W3ihHmjPQv9pXJ6p/UIzEWlrxAtf2VJc=;
 b=X2Jv3A/ADoRUSpnqF+EqimIwed8yxRIo2I85Am/+obKQxutIC73V00LVS7X5LvpYSl
 dmPHM7IdDTURR1bg1XAbO+PmHF73yAjF++G07/ealQPbI5yFIRbXsLG3wlNsuRmdOpcH
 7xkmvYk2uOEoEpMNQqJ7ETO8Z3CqUvOa5PIeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XamOsHdCDf3W3ihHmjPQv9pXJ6p/UIzEWlrxAtf2VJc=;
 b=Gj2cSuvAmFOWfFu2DwXEoKvZ+k1LPTkHLIKajdML/nuZl3RbAnd4xMOHHOlu/u7guE
 Fm1junr1ZRj7puXRNcZ4rPa+LadXp1ifmehb9xDXyLTAkvHKv67xqDmu09Ja+oyJrsMq
 8BG81XYqZj+lSb8dam37fFRzD+l9yacm0YjOEXMTB2j/etFPo583ZWdM6DJCDuh4FEb9
 Mdz31/uYpn468Sshx3e82FEk5XbDTp5XKNUcykck7YeSVkYrgF5Qmpm2kLuKIbjdu0dO
 Ious99sOPzesbMgLFPT5ziQoFd3iH9g/qSJweorrunrL+1lAvNgp5X7xD2O/G1/VZUbj
 zXjA==
X-Gm-Message-State: AA+aEWYdIHCAW4po/q+0eKedx8MbGSgy+AY5WhDaj1xo0P5zTlTkwnFW
 w7C87R1R08q0ZnYXVtjQM2d33UxyVGsMpFSIbNZSqw==
X-Google-Smtp-Source: AFSGD/Wtrtc41Mt2G9+Vn3KxIyjs2dGTvbhylNUiX9iX70bSGifQdDPMcAKS0pjggFfuIL+OToumTJ2kbnE0GRT6+eM=
X-Received: by 2002:a6b:5d01:: with SMTP id r1mr15058172iob.170.1543884252946; 
 Mon, 03 Dec 2018 16:44:12 -0800 (PST)
MIME-Version: 1.0
References: <20181201110144.15970-1-ard.biesheuvel@linaro.org>
 <c5c51e6a-a4d6-ca3d-b413-1ecbbf7186f5@arm.com>
 <CAKv+Gu88W79sMoCFse4iaXwr=N1JT73-htvmGSQkVHdP1DaAYA@mail.gmail.com>
 <20181203174506.GA28497@arm.com>
 <CAKv+Gu8NQ9T4FFXRB0SL5U8ddn=tAtZH67XNNAbw8FaHKP_AfQ@mail.gmail.com>
 <20181203181100.GA28700@arm.com>
In-Reply-To: <20181203181100.GA28700@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 4 Dec 2018 01:44:01 +0100
Message-ID: <CAKv+Gu8=_PH1n2Z7QBNYpLMKAodo0GVWfzduo4UBdH_vmOnc1w@mail.gmail.com>
Subject: Re: [PATCH] arm64/mm: use correct operators for string comparison in
 cache.S
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_164424_670639_4DC8E02A 
X-CRM114-Status: GOOD (  26.59  )
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
 Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 3 Dec 2018 at 19:10, Will Deacon <will.deacon@arm.com> wrote:
>
> On Mon, Dec 03, 2018 at 06:54:35PM +0100, Ard Biesheuvel wrote:
> > On Mon, 3 Dec 2018 at 18:44, Will Deacon <will.deacon@arm.com> wrote:
> > >
> > > On Mon, Dec 03, 2018 at 02:22:14PM +0100, Ard Biesheuvel wrote:
> > > > On Mon, 3 Dec 2018 at 14:11, Robin Murphy <robin.murphy@arm.com> wrote:
> > > > > On 01/12/2018 11:01, Ard Biesheuvel wrote:
> > > > > > The GAS directives that are currently being used in dcache_by_line_op
> > > > > > rely on assembler behavior that is not documented, and probably not
> > > > > > guaranteed to produce the correct behavior going forward.
> > > > > >
> > > > > > Currently, we end up with some undefined symbols in cache.o:
> > > > > >
> > > > > > $ nm arch/arm64/mm/cache.o
> > > > > >        ...
> > > > > >        U civac
> > > > > >        ...
> > > > > >        U cvac
> > > > > >        U cvap
> > > > > >        U cvau
> > > > > >
> > > > > > This is due to the fact that the comparisons used to select the
> > > > > > operation type in the dcache_by_line_op macro are comparing symbols
> > > > > > not strings, and even though it seems that GAS is doing the right
> > > > > > thing here (undefined symbols by the same name are equal to each
> > > > > > other), it seems unwise to rely on this.
> > > > > >
> > > > > > So let's provide some definitions that are guaranteed to be distinct,
> > > > > > and make them local so they don't pollute the gobal symbol space.
> > > > >
> > > > > Rather than making the unintended symbol comparisons work properly, can
> > > > > we not just implement the string comparisons that were supposed to be?
> > > > > Superficially, the diff below seems to still generate the desired output
> > > > > (although as always there's probably some subtlety I'm missing).
> > > > >
> > > > > Robin.
> > > > >
> > > > > ----->8-----
> > > > >
> > > > > diff --git a/arch/arm64/include/asm/assembler.h
> > > > > b/arch/arm64/include/asm/assembler.h
> > > > > index 6142402c2eb4..2c5f4825fee3 100644
> > > > > --- a/arch/arm64/include/asm/assembler.h
> > > > > +++ b/arch/arm64/include/asm/assembler.h
> > > > > @@ -383,13 +383,13 @@ alternative_endif
> > > > >         sub     \tmp2, \tmp1, #1
> > > > >         bic     \kaddr, \kaddr, \tmp2
> > > > >   9998:
> > > > > -       .if     (\op == cvau || \op == cvac)
> > > > > +       .if     ("\op" == "cvau" || "\op" == "cvac")
> > > > >   alternative_if_not ARM64_WORKAROUND_CLEAN_CACHE
> > > > >         dc      \op, \kaddr
> > > > >   alternative_else
> > > > >         dc      civac, \kaddr
> > > > >   alternative_endif
> > > > > -       .elseif (\op == cvap)
> > > > > +       .elseif ("\op" == "cvap")
> > > > >   alternative_if ARM64_HAS_DCPOP
> > > > >         sys 3, c7, c12, 1, \kaddr       // dc cvap
> > > > >   alternative_else
> > > > >
> > > >
> > > > Looking at the GAS info pages, I find
> > > >
> > > > "Operators" are arithmetic functions, like '+' or '%'.
> > > > "Arguments" are symbols, numbers or subexpressions.
> > > > An "expression" specifies an address or numeric value.
> > > >
> > > > so even if the comparison works as expected, I'm hesitant to rely on
> > > > it to work as expected on any version of GAS or any other assembler
> > > > claiming to implement the GAS asm dialect.
> > > >
> > > > We could change the logic to .ifc, which is defined to operate on string, i.e.,
> > >
> > > That looks better to me, although I'm not sure why you're inverted the logic
> > > here:
> > >
> > > >     .ifnc \op, civac
> > > >     .ifnc \op, cvap
> > >
> > > What am I missing?
> > >
> >
> > .ifc does not permit '\op equals string1 or \op equals string2'
>
> Thanks. Then I guess we invert the logic as you suggest, or we duplicate the
> alternative code. Looking at this some more, I think what we currently have
> is broken because on a system with ARM64_WORKAROUND_CLEAN_CACHE but not
> ARM64_HAS_DCPOP, you'll get DC CVAC for __clean_dcache_area_pop, which
> would be broken on that CPU.
>

Can we just fallback to civac instead? Or do we need to add logic to
combine the two feature flags?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
