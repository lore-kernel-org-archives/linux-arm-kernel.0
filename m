Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52961C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:58:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B697214DE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KsZcr3IL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0biMiLq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B697214DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=adEpv7q4sYR2YE/xiXcHuPnkEUuz65GeKJ/5m1eF5PU=; b=KsZcr3ILw1zgVo
	+6knVFwFdUqSmaSmCihDMh1nu991rEd9Udj1Ayobff73lTbB23T+kOZLKfd35HWHkac0cFoKVEl45
	6Ley8b6f7n/Wnc7QpzJw3SpY1y1VH2+uiGasjUPBc+cn4AsPE2b4cxw+6RnLvjxmaNR8OK0RqHxso
	jWnONO6Piep9nNOVqV3twDVtz43t+ghtOHY0J8ZLsampqyg3wjOoMZpEDS9QjpKq/RywHneV0wuA2
	a7GSut63my3gpHlKb9NPaMBwKZLD2u3n7UePLXyvOa3JvQF87a/f9xIvPVeAYEbgue8VgGUrYAXiq
	/mgpXdMRtkd3eMAgoE9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUw2t-0002h0-6s; Thu, 06 Dec 2018 15:58:35 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUw2n-0002gN-7O
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 15:58:32 +0000
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
 [209.85.167.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8D073214C1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu,  6 Dec 2018 15:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544111898;
 bh=/kwpy3ggzBDgvpX4BW5m0JPR1cTiTa/cL6L86JsVG/E=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=p0biMiLq1kfp3U3+SACGBot/15OLCN8b77UHB4m1x5AASuDn4AB2Kcx/mI0Q1Uy+k
 NvNRoXLahMDTfOFFYU4BSZlenyG2D7n9IJRFCIrRSjelRtMYqlU/zaxVP+58i42ATX
 c+HoanbdbcO0MdxRZb93AmISeaN8ylYJqIcafV3Q=
Received: by mail-lf1-f46.google.com with SMTP id u18so714439lff.10
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 07:58:18 -0800 (PST)
X-Gm-Message-State: AA+aEWb8h8iwlTBikx/WKa4YjnjhvCljZfv8kmydBh0zTTU/69CRc+D5
 zrLl8VxSmSirU3iZfmgkXW6aBM5vsNbLyIGSzho=
X-Google-Smtp-Source: AFSGD/XfRPoYzW2pWzX5OAONyDRu+mPaX0ao9vjyvgFtDZDESi9NaMN2CcZUcmohPf5JBGFj5Ue/atsOGs/SAzWoGgQ=
X-Received: by 2002:a19:c396:: with SMTP id
 t144mr16857263lff.110.1544111896698; 
 Thu, 06 Dec 2018 07:58:16 -0800 (PST)
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
In-Reply-To: <20181206153128.GW30658@n2100.armlinux.org.uk>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 6 Dec 2018 16:58:05 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdF7f+zhzfQ6tGtxkrgaz0GQfM6N-5LwymfoZozBgsELQ@mail.gmail.com>
Message-ID: <CAJKOXPdF7f+zhzfQ6tGtxkrgaz0GQfM6N-5LwymfoZozBgsELQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] ARM: spectre-v2: per-CPU vtables to work around
 big.Little systems
To: linux@armlinux.org.uk
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_075829_302747_681CE1F3 
X-CRM114-Status: GOOD (  26.22  )
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

On Thu, 6 Dec 2018 at 16:31, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> On Thu, Dec 06, 2018 at 04:03:27PM +0100, Krzysztof Kozlowski wrote:
> > On Thu, 6 Dec 2018 at 15:37, Russell King - ARM Linux
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Thu, Dec 06, 2018 at 03:30:22PM +0100, Krzysztof Kozlowski wrote:
> > > > On Thu, 6 Dec 2018 at 15:07, Russell King - ARM Linux
> > > > > That basically means that the dcache_clean_area method for CPU1
> > > > > differs from the dcache_clean_area method for CPU0.  If all your
> > > > > CPUs are identical, that definitely should not be happening.
> > > > >
> > > > > Hmm.  Interestingly, OMAP4430 passes hotplug tests just fine.
> > > > >
> > > > > Please try this patch.
> > > >
> > > > This fixes both hotplug and suspend to RAM. I was trying to narrow why
> > > > the pointers to all processor functions differ. During first boot they
> > > > were OK but it seems they were changed just before suspend.
> > >
> > > Thanks for testing.  I think this is probably a better patch which
> > > should end up with the same result.
> > >
> > > I suspect no one else has noticed because most people have big.Little
> > > support disabled - that'd explain why it doesn't show up on OMAP4.
> > >
> > > diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
> > > index 81d0efb055c6..44f9776139a8 100644
> > > --- a/arch/arm/mm/proc-macros.S
> > > +++ b/arch/arm/mm/proc-macros.S
> > > @@ -274,6 +274,13 @@
> > >         .endm
> > >
> > >  .macro define_processor_functions name:req, dabort:req, pabort:req, nommu=0, suspend=0, bugs=0
> > > +/*
> > > + * If we are building for big.Little with branch predictor hardening,
> > > + * we need the processor function tables to remain available after boot.
> > > + */
> > > +#if defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
> > > +       .rodata
> > > +#endif
> > >         .type   \name\()_processor_functions, #object
> > >         .align 2
> > >  ENTRY(\name\()_processor_functions)
> > > @@ -309,6 +316,9 @@ ENTRY(\name\()_processor_functions)
> > >         .endif
> > >
> > >         .size   \name\()_processor_functions, . - \name\()_processor_functions
> > > +#if defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
> > > +       .previous
> > > +#endif
> > >  .endm
> > >
> > >  .macro define_cache_functions name:req
> >
> > Does not compile:
> > ../arch/arm/mm/proc-v7.S: Assembler messages:
> > ../arch/arm/mm/proc-v7.S:560: Error: unknown pseudo-op: `.rodata'
> > ../arch/arm/mm/proc-v7.S:575: Error: unknown pseudo-op: `.rodata'
> > ../arch/arm/mm/proc-v7.S:596: Error: unknown pseudo-op: `.rodata'
> > ../arch/arm/mm/proc-v7.S:611: Error: unknown pseudo-op: `.rodata'
> > ../arch/arm/mm/proc-v7.S:629: Error: unknown pseudo-op: `.rodata'
>
> It should be .section ".rodata", sorry.

Tested hotplug and suspend on Odroid U3 (Exynos4412), hotplug on
Odroid XU3 and HC1 (Exynos5422).
Tested-by: Krzysztof Kozlowski <krzk@kernel.org>

On Odroid U3 and HC1 the cpuhotplug_04 from Linaro's PM-QA fails:
cpuhotplug_04.0/cpu1: checking affinity is set...                           Err
v4.19 also fails here.

On HC1 the board hang once during cpuhotplug_05 test
(https://wiki.linaro.org/WorkingGroups/PowerManagement/Resources/TestSuite/PmQaSpecification#cpuhotplug_05).

Both errors above seems to be unrelated to your fixup. If needed I
could do some more testing during the weekend but in general looks
fine for me.

Thanks!

Best regards,
Krzysztof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
