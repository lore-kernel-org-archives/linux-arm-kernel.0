Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D951C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:32:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E801C20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YbHEL109";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nuMCyX13"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E801C20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=21phIo2Hz/ht6C+Ml8nzKlnpJgV6QbqVggzxxkrs2sU=; b=YbHEL109UAx1ND
	GIwxyTYBcxDVI6abRPnYu9rUeWNVx19M1rASIdk7kA2h3DODvhkWUDOKkMC+3tIdcXil6ezJS/6Jb
	BisyG69fB5NQvqehLNhCtKgOOvxrTzEdJrtnAeW55d5knqVOfP71m3nR0OuOB8HxIW0oAsNr4ImlV
	V+neRPoJJP4C5yzII3ceoy8vlFkc+9BVCDODLXj94t7ljZYnXkvwyopklBsniIkyiTj8OVczQSs4p
	gLZiyu311zfGr8opFWl+FkdglJrxZ4Vom/3NIaXwPtVBrweVW9pWUkZfvTHK36u8//dmF7NX/ku1L
	PMDNDNkADKtsMaI5+tSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUvdJ-0006dl-UI; Thu, 06 Dec 2018 15:32:09 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUvdC-0006ch-Tr
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 15:32:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wWeo1acCm0q7A9T5UHLfULOQlwqLiXmfdtoVjP+fYDw=; b=nuMCyX13efLh5XvDOUAtRQasC
 BOGvuNqIIW+EOnH99NOd1AB+J9OlH/p1UTHCXEmPbt6t2C2topvxRlareS/RBdV+LJUxo7KWyeCHY
 /Qb4h5PHUeyBU9DSgy2bpNroy+OEyAQzyUHK5CRtvJzu3KwJ1oi057tmIDAmT/GyIG+kc=;
Received: from n2100.armlinux.org.uk
 ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:46383)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gUvcv-0002SQ-M3; Thu, 06 Dec 2018 15:31:45 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gUvck-0003vm-Nl; Thu, 06 Dec 2018 15:31:34 +0000
Date: Thu, 6 Dec 2018 15:31:29 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 5/5] ARM: spectre-v2: per-CPU vtables to work around
 big.Little systems
Message-ID: <20181206153128.GW30658@n2100.armlinux.org.uk>
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
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJKOXPchTZtFKtycEEhYoxZR53VckqZYQfOrGNhDvUARxBS4fw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_073202_961835_7F00CF25 
X-CRM114-Status: GOOD (  23.08  )
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
Cc: mark.rutland@arm.com, julien.thierry@arm.com, marc.zyngier@arm.com,
 will.deacon@arm.com, Morten.Rasmussen@arm.com, Qais.Yousef@arm.com,
 dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 06, 2018 at 04:03:27PM +0100, Krzysztof Kozlowski wrote:
> On Thu, 6 Dec 2018 at 15:37, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> >
> > On Thu, Dec 06, 2018 at 03:30:22PM +0100, Krzysztof Kozlowski wrote:
> > > On Thu, 6 Dec 2018 at 15:07, Russell King - ARM Linux
> > > > That basically means that the dcache_clean_area method for CPU1
> > > > differs from the dcache_clean_area method for CPU0.  If all your
> > > > CPUs are identical, that definitely should not be happening.
> > > >
> > > > Hmm.  Interestingly, OMAP4430 passes hotplug tests just fine.
> > > >
> > > > Please try this patch.
> > >
> > > This fixes both hotplug and suspend to RAM. I was trying to narrow why
> > > the pointers to all processor functions differ. During first boot they
> > > were OK but it seems they were changed just before suspend.
> >
> > Thanks for testing.  I think this is probably a better patch which
> > should end up with the same result.
> >
> > I suspect no one else has noticed because most people have big.Little
> > support disabled - that'd explain why it doesn't show up on OMAP4.
> >
> > diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
> > index 81d0efb055c6..44f9776139a8 100644
> > --- a/arch/arm/mm/proc-macros.S
> > +++ b/arch/arm/mm/proc-macros.S
> > @@ -274,6 +274,13 @@
> >         .endm
> >
> >  .macro define_processor_functions name:req, dabort:req, pabort:req, nommu=0, suspend=0, bugs=0
> > +/*
> > + * If we are building for big.Little with branch predictor hardening,
> > + * we need the processor function tables to remain available after boot.
> > + */
> > +#if defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
> > +       .rodata
> > +#endif
> >         .type   \name\()_processor_functions, #object
> >         .align 2
> >  ENTRY(\name\()_processor_functions)
> > @@ -309,6 +316,9 @@ ENTRY(\name\()_processor_functions)
> >         .endif
> >
> >         .size   \name\()_processor_functions, . - \name\()_processor_functions
> > +#if defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
> > +       .previous
> > +#endif
> >  .endm
> >
> >  .macro define_cache_functions name:req
> 
> Does not compile:
> ../arch/arm/mm/proc-v7.S: Assembler messages:
> ../arch/arm/mm/proc-v7.S:560: Error: unknown pseudo-op: `.rodata'
> ../arch/arm/mm/proc-v7.S:575: Error: unknown pseudo-op: `.rodata'
> ../arch/arm/mm/proc-v7.S:596: Error: unknown pseudo-op: `.rodata'
> ../arch/arm/mm/proc-v7.S:611: Error: unknown pseudo-op: `.rodata'
> ../arch/arm/mm/proc-v7.S:629: Error: unknown pseudo-op: `.rodata'

It should be .section ".rodata", sorry.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
