Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10F5C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:12:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E9B720850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Yus+AXS8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P6sks7Hj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E9B720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zG9e3xjMtUsHSrxnrTv3iFHj3nCZnwUXN4GXqtMBkeI=; b=Yus+AXS8MxHpnQ
	wvtUxnUYIbY0IXQjFXGL0hVIaRLsNLS5NtD4r2ATxCR0XQ1p75MfJgvxOGDZ1NE0xSIP/CcW/mH3d
	Iufgf45DdgLfklHsnQMPobnknVAboYWnBWBMKBkBc76RkthdBV9RappqLH5ljRQbPZPfZp1CqA8pq
	+FENE4w0drcoY6w1BpSyXlxOuv2buiUV293L2Ln59uDYQLRjBnVVHop8IEs2NS/e4YfqvKHIIx6Yq
	h5SsJLr7g0rqEqB6vGkg90fa1BvErXg8dyzAPomG5PMclYKAcgWeBQCl4/JOad+u8C2EcYHlgsoOD
	64MQvqggydGOyaaOYu+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVCBk-0003M5-5R; Fri, 07 Dec 2018 09:12:48 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVCB3-0002ZO-QO
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 09:12:36 +0000
Received: by mail-it1-x142.google.com with SMTP id g76so5883084itg.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 01:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UhfkvwR9bTzsthf3kd4FnUYJhIk/0hwAkBrhFB04Sgc=;
 b=P6sks7Hjo+dHzU79stP67pT1BJ/jG+KqBzHxhm2LqPgKomfTP83H8hXAtdcuWRmwJj
 NSwU3KyPp7kNA3i9C8X/4NhcgH/l/iUImH65DPJY0/abQJMus9ItZe5GR4GCVg6N4aXW
 e7tjxEcnckpid9eRTynF9ttYl8jjZMiTBMVos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UhfkvwR9bTzsthf3kd4FnUYJhIk/0hwAkBrhFB04Sgc=;
 b=cv/Sr2qrx+dl6Ioca/81yWQ9G5VO6OEan1nH0RxcpYy8Ku5Z6OMKBqN5Nr8HzUZIlF
 KvQeQm03X9XGkRA9D9gntA1CSHavsui2mxvwLdI66/Zno2meFN40cu//oazDRRe4jQ5Y
 0dBXYjSDAhLUYyFiu27cH05aEj1HveJWFyZfC0Ad9H0f1DsW+TrBH3Qt8n2laJ8B6YCC
 0nMoYy00ReTLSEy4u8I1aAPHxyiWqIjSeXodFYpYfNXAcXO4lJ73n6KbXxxAinj+BuMe
 x3T+Okf60Zvu2C9CI+NR0+vLMQzdmrHy7SuQen67lSsBJltIBKBtWdhfQfgSXfLntjh0
 kgfA==
X-Gm-Message-State: AA+aEWaBJuQFR8cnFD99C0BPanqTwsVVWOFLutM/h2zEE8UNiPclzQZ/
 4+MH1W18c0GenbrPTX90sWGax7zVFXlMi/d5M8K9DR9Llgw=
X-Google-Smtp-Source: AFSGD/WLx02SKc2wBltxF9LFlwZ1gitOM9jHQOz5DgkpbwwNZDKX9t4xCyRHiCZwkWY9O7erGNEt160mvymUed4eDtE=
X-Received: by 2002:a24:710:: with SMTP id f16mr1242474itf.121.1544173913776; 
 Fri, 07 Dec 2018 01:11:53 -0800 (PST)
MIME-Version: 1.0
References: <E1gK0dU-0007Mp-4h@rmk-PC.armlinux.org.uk>
 <dda0be26-5ac8-a158-3210-4bc6861bede2@samsung.com>
 <20181206100052.GR30658@n2100.armlinux.org.uk>
 <CAJKOXPdUFfOXqMkgdv4fjhpbrmjNmw_f9cMj03a2h65snNJ4qw@mail.gmail.com>
 <20181206123956.GS30658@n2100.armlinux.org.uk>
 <CAJKOXPf=nGN53EK=+bjhKyaY_knMnY5J+JSW2Jb6KRQuJy37vA@mail.gmail.com>
 <20181206140717.GU30658@n2100.armlinux.org.uk>
 <CAJKOXPdUABPbni+1H=tTvA5wKe8Rc8EPTFKtLGMwQ8yLcb3=gg@mail.gmail.com>
 <20181206143703.GV30658@n2100.armlinux.org.uk>
 <CAJKOXPchTZtFKtycEEhYoxZR53VckqZYQfOrGNhDvUARxBS4fw@mail.gmail.com>
 <20181206153128.GW30658@n2100.armlinux.org.uk>
 <CAJKOXPdF7f+zhzfQ6tGtxkrgaz0GQfM6N-5LwymfoZozBgsELQ@mail.gmail.com>
In-Reply-To: <CAJKOXPdF7f+zhzfQ6tGtxkrgaz0GQfM6N-5LwymfoZozBgsELQ@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 7 Dec 2018 10:11:42 +0100
Message-ID: <CAKv+Gu9hMQXunSmq56nz+Ndmu_mRAeump4VefY5yaa-_798QTg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] ARM: spectre-v2: per-CPU vtables to work around
 big.Little systems
To: Krzysztof Kozlowski <krzk@kernel.org>, Russell King <linux@armlinux.org.uk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_011206_009527_9F359A52 
X-CRM114-Status: GOOD (  23.36  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Julien Thierry <julien.thierry@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Will Deacon <will.deacon@arm.com>, Qais.Yousef@arm.com,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Morten.Rasmussen@arm.com, dietmar.eggemann@arm.com,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 6 Dec 2018 at 16:58, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Thu, 6 Dec 2018 at 16:31, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> >
> > On Thu, Dec 06, 2018 at 04:03:27PM +0100, Krzysztof Kozlowski wrote:
> > > On Thu, 6 Dec 2018 at 15:37, Russell King - ARM Linux
> > > <linux@armlinux.org.uk> wrote:
> > > >
> > > > On Thu, Dec 06, 2018 at 03:30:22PM +0100, Krzysztof Kozlowski wrote:
> > > > > On Thu, 6 Dec 2018 at 15:07, Russell King - ARM Linux
> > > > > > That basically means that the dcache_clean_area method for CPU1
> > > > > > differs from the dcache_clean_area method for CPU0.  If all your
> > > > > > CPUs are identical, that definitely should not be happening.
> > > > > >
> > > > > > Hmm.  Interestingly, OMAP4430 passes hotplug tests just fine.
> > > > > >
> > > > > > Please try this patch.
> > > > >
> > > > > This fixes both hotplug and suspend to RAM. I was trying to narrow why
> > > > > the pointers to all processor functions differ. During first boot they
> > > > > were OK but it seems they were changed just before suspend.
> > > >
> > > > Thanks for testing.  I think this is probably a better patch which
> > > > should end up with the same result.
> > > >
> > > > I suspect no one else has noticed because most people have big.Little
> > > > support disabled - that'd explain why it doesn't show up on OMAP4.
> > > >
> > > > diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
> > > > index 81d0efb055c6..44f9776139a8 100644
> > > > --- a/arch/arm/mm/proc-macros.S
> > > > +++ b/arch/arm/mm/proc-macros.S
> > > > @@ -274,6 +274,13 @@
> > > >         .endm
> > > >
> > > >  .macro define_processor_functions name:req, dabort:req, pabort:req, nommu=0, suspend=0, bugs=0
> > > > +/*
> > > > + * If we are building for big.Little with branch predictor hardening,
> > > > + * we need the processor function tables to remain available after boot.
> > > > + */
> > > > +#if defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
> > > > +       .rodata
> > > > +#endif
> > > >         .type   \name\()_processor_functions, #object
> > > >         .align 2
> > > >  ENTRY(\name\()_processor_functions)
> > > > @@ -309,6 +316,9 @@ ENTRY(\name\()_processor_functions)
> > > >         .endif
> > > >
> > > >         .size   \name\()_processor_functions, . - \name\()_processor_functions
> > > > +#if defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
> > > > +       .previous
> > > > +#endif
> > > >  .endm
> > > >
> > > >  .macro define_cache_functions name:req

Russell,

I noticed that the patch merged by Linus has

#if 1 // defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)

Was that what you intended?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
