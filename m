Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA41C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:55:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5734920848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="riTqjIdI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kzBPLX6S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5734920848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b7ONnDu2BRHKf9g58889amKOySEXXK1T1xaueDKYLr4=; b=riTqjIdIRKb76I
	zk+7uL7gvZgWJ/b/CLFVpxlh75HAtlK3gZwaWs/r/QSD0u0tXyz/2Lc41ykENbTm15lCf2YOU0XB4
	Iruz2/So+Ya41Wzpd+EVVBGYPG7Jt7v/olTbLp9uCEAd8n72K8B+x4FhLJCC0Fl31bB+xmvx3xlYx
	O7/qotH5tSV+hRSQwLz7TS4pkSqjiKijpUUwspROO/xLk7ydm8xNYGpQ6AsU3s1FSCWxVuAXXJC5Y
	SSU7nEDD2Il589D4ybolTxuJXNij8mBhvGH2+J+1Ie00IF5rGCcjl7nuh45kDcmETybulAFBeiJkM
	cJqo/j7TtTxWq1UjmhmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTsQv-0007nl-LW; Mon, 03 Dec 2018 17:55:01 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTsQs-0007jI-Hx
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 17:55:00 +0000
Received: by mail-it1-x144.google.com with SMTP id i7so10720578iti.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 09:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eZp3EFHfOXjn5hR4NBNYSEz2Ut4OBnTT0NMxmY63Fbk=;
 b=kzBPLX6Su43DIYU9WIuYpGakoqtjwCAtBtLDt4B43oZTtI47hgkqz+uVvcv1OnrIqZ
 313l31hrnCPJdEW+Uph71Uqy4MxigAqZvZOznnlQ+Gy/mVBOcZiwMT6tYMGlPscmsRqh
 /D1iOqphvccSYAjDTM/7hqpYJTqjWd5JXlHWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eZp3EFHfOXjn5hR4NBNYSEz2Ut4OBnTT0NMxmY63Fbk=;
 b=IL50b5aH9lisIX6mWRi0nTZugUb1iNtj3aJ0SenPaOA8tUGAP3QsBLoL5bbI95sZMY
 05wUHrGwW6WhZ/b2QI80fYooYR/YsIoWs1tDPCTIrVOMOD+DFS3cdobBOfYBlUtf7pqn
 oDEmh28GDbGc862MXRp/LJkUp2Nc9WZJB7wraJOL4AROD3mBgCZ6G2QkK9VIimlCiDgs
 jQM65Nk3oqnVbRzTPKQCqbRO9Z7nPywQaS0RrGOK4nCIVRzLdlYZFCEH1rv8LfL2Nw7R
 NiEEzjMN41OdmUuo7oUSQpB/Xomy3o5Zh5So1+lTabEodjjr7Pbw4MUbuBBhXyN5WLRS
 7iSw==
X-Gm-Message-State: AA+aEWZPr4geeV1ZJy0IZ/yUFErswUjdHO/o/kfTFM3ia43DLY5dv/3M
 hKQuboA897Jp9IBK7uYs+xW1xOQEMZ4aPNSYGs9qQA==
X-Google-Smtp-Source: AFSGD/VjNn21gFNc8h5IEAEdtUlAsNynLGJcjyEMORBla8ydWWxaUvN3O6+HOScxnntb9NYer96NJsFGOzkXB5rCrw8=
X-Received: by 2002:a02:4c9:: with SMTP id 192mr15256962jab.2.1543859687140;
 Mon, 03 Dec 2018 09:54:47 -0800 (PST)
MIME-Version: 1.0
References: <20181201110144.15970-1-ard.biesheuvel@linaro.org>
 <c5c51e6a-a4d6-ca3d-b413-1ecbbf7186f5@arm.com>
 <CAKv+Gu88W79sMoCFse4iaXwr=N1JT73-htvmGSQkVHdP1DaAYA@mail.gmail.com>
 <20181203174506.GA28497@arm.com>
In-Reply-To: <20181203174506.GA28497@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 3 Dec 2018 18:54:35 +0100
Message-ID: <CAKv+Gu8NQ9T4FFXRB0SL5U8ddn=tAtZH67XNNAbw8FaHKP_AfQ@mail.gmail.com>
Subject: Re: [PATCH] arm64/mm: use correct operators for string comparison in
 cache.S
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_095458_848634_8A071991 
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
 Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 3 Dec 2018 at 18:44, Will Deacon <will.deacon@arm.com> wrote:
>
> On Mon, Dec 03, 2018 at 02:22:14PM +0100, Ard Biesheuvel wrote:
> > On Mon, 3 Dec 2018 at 14:11, Robin Murphy <robin.murphy@arm.com> wrote:
> > > On 01/12/2018 11:01, Ard Biesheuvel wrote:
> > > > The GAS directives that are currently being used in dcache_by_line_op
> > > > rely on assembler behavior that is not documented, and probably not
> > > > guaranteed to produce the correct behavior going forward.
> > > >
> > > > Currently, we end up with some undefined symbols in cache.o:
> > > >
> > > > $ nm arch/arm64/mm/cache.o
> > > >        ...
> > > >        U civac
> > > >        ...
> > > >        U cvac
> > > >        U cvap
> > > >        U cvau
> > > >
> > > > This is due to the fact that the comparisons used to select the
> > > > operation type in the dcache_by_line_op macro are comparing symbols
> > > > not strings, and even though it seems that GAS is doing the right
> > > > thing here (undefined symbols by the same name are equal to each
> > > > other), it seems unwise to rely on this.
> > > >
> > > > So let's provide some definitions that are guaranteed to be distinct,
> > > > and make them local so they don't pollute the gobal symbol space.
> > >
> > > Rather than making the unintended symbol comparisons work properly, can
> > > we not just implement the string comparisons that were supposed to be?
> > > Superficially, the diff below seems to still generate the desired output
> > > (although as always there's probably some subtlety I'm missing).
> > >
> > > Robin.
> > >
> > > ----->8-----
> > >
> > > diff --git a/arch/arm64/include/asm/assembler.h
> > > b/arch/arm64/include/asm/assembler.h
> > > index 6142402c2eb4..2c5f4825fee3 100644
> > > --- a/arch/arm64/include/asm/assembler.h
> > > +++ b/arch/arm64/include/asm/assembler.h
> > > @@ -383,13 +383,13 @@ alternative_endif
> > >         sub     \tmp2, \tmp1, #1
> > >         bic     \kaddr, \kaddr, \tmp2
> > >   9998:
> > > -       .if     (\op == cvau || \op == cvac)
> > > +       .if     ("\op" == "cvau" || "\op" == "cvac")
> > >   alternative_if_not ARM64_WORKAROUND_CLEAN_CACHE
> > >         dc      \op, \kaddr
> > >   alternative_else
> > >         dc      civac, \kaddr
> > >   alternative_endif
> > > -       .elseif (\op == cvap)
> > > +       .elseif ("\op" == "cvap")
> > >   alternative_if ARM64_HAS_DCPOP
> > >         sys 3, c7, c12, 1, \kaddr       // dc cvap
> > >   alternative_else
> > >
> >
> > Looking at the GAS info pages, I find
> >
> > "Operators" are arithmetic functions, like '+' or '%'.
> > "Arguments" are symbols, numbers or subexpressions.
> > An "expression" specifies an address or numeric value.
> >
> > so even if the comparison works as expected, I'm hesitant to rely on
> > it to work as expected on any version of GAS or any other assembler
> > claiming to implement the GAS asm dialect.
> >
> > We could change the logic to .ifc, which is defined to operate on string, i.e.,
>
> That looks better to me, although I'm not sure why you're inverted the logic
> here:
>
> >     .ifnc \op, civac
> >     .ifnc \op, cvap
>
> What am I missing?
>

.ifc does not permit '\op equals string1 or \op equals string2'

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
