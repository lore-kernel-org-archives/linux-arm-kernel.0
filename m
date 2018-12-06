Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F9FC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:04:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE87020700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jjXbY9Jk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Na3G9uR7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE87020700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gyooaZIGlHg3hyzJqTTotmlNw4Gtz2qpL48MtbDG1qE=; b=jjXbY9JkuHlABT
	MeICmuoQ8BlsKgi7RvXmFdT6IfDcMKlULXPd5LFFgj7Rn+ZKt/BQlSLtRNMRMD7vY0nqTK3ahNYba
	yh5I6N7qh60gv5w7/7gQ8wsmbI4gUDXq6GGwt2sQXB3I9sO8PFsd28Zk8faHr634nE7g0xRmz+Z4p
	J5EmozwPMFnEFtLrGdmDrsUrcl2Vu9fWmwgXj1CqtqKUdMYfhp3g/sf5zphcjVrlHX2O2Vr//Yycn
	HjsTacMglbgFXXkRHLmCRu9oLWm34W67kzoFscQVbue3Qx9BNO05jBzbhJQAPiSOONSTTcmIIcSiu
	W/HCP5PVlHG0XFEI4idw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUvC4-0000x5-Mu; Thu, 06 Dec 2018 15:04:00 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUvBw-0000vj-89
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 15:03:58 +0000
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com
 [209.85.167.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9F3D2214C1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu,  6 Dec 2018 15:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544108621;
 bh=juOyGuOQVJqPSPk1wHyaZQUCrstLYHXKpE1tsqtPsAU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Na3G9uR7/VXm2/bm+5JV1LJYNjB6GH0tAvxFqmSO2x7RJ8cm8mya8lRy4a9p5gdXK
 B+gAIjckG8SwNCZlrnGMk52aT7Wpsv7cSL36RMgiOr/Ex6cLr2NQ7fe/IwDMoVTH64
 GX0O/jbPmLzxGSgPxJ7FjbSz/EQD0EqWJ5Ae0Kcg=
Received: by mail-lf1-f42.google.com with SMTP id z13so569234lfe.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 07:03:40 -0800 (PST)
X-Gm-Message-State: AA+aEWaKV0NJ9/at8Zh8K+cdsMsa3NoJC71oz4JAKhQNUe7Xl9WWt3PO
 pXTWbW7M5rXsYwiV9Dr0/MznkMs3vX/lepCL2iE=
X-Google-Smtp-Source: AFSGD/Ui7/qyzS8L7vl1f4awr0MKhww3fIrohh1/AIiKoCZo3XJCeNf0WjbMSkQ0+oUUB8rt+74PjKX2Y29LnUtb/qY=
X-Received: by 2002:a19:a28e:: with SMTP id l136mr18329809lfe.87.1544108618721; 
 Thu, 06 Dec 2018 07:03:38 -0800 (PST)
MIME-Version: 1.0
References: <20181106123700.GA30658@n2100.armlinux.org.uk>
 <CGME20181106124037epcas4p35f0ed44d430e44310e764190f15c2883@epcas4p3.samsung.com>
 <E1gK0dU-0007Mp-4h@rmk-PC.armlinux.org.uk>
 <dda0be26-5ac8-a158-3210-4bc6861bede2@samsung.com>
 <20181206100052.GR30658@n2100.armlinux.org.uk>
 <CAJKOXPdUFfOXqMkgdv4fjhpbrmjNmw_f9cMj03a2h65snNJ4qw@mail.gmail.com>
 <20181206123956.GS30658@n2100.armlinux.org.uk>
 <CAJKOXPf=nGN53EK=+bjhKyaY_knMnY5J+JSW2Jb6KRQuJy37vA@mail.gmail.com>
 <20181206140717.GU30658@n2100.armlinux.org.uk>
 <CAJKOXPdUABPbni+1H=tTvA5wKe8Rc8EPTFKtLGMwQ8yLcb3=gg@mail.gmail.com>
 <20181206143703.GV30658@n2100.armlinux.org.uk>
In-Reply-To: <20181206143703.GV30658@n2100.armlinux.org.uk>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 6 Dec 2018 16:03:27 +0100
X-Gmail-Original-Message-ID: <CAJKOXPchTZtFKtycEEhYoxZR53VckqZYQfOrGNhDvUARxBS4fw@mail.gmail.com>
Message-ID: <CAJKOXPchTZtFKtycEEhYoxZR53VckqZYQfOrGNhDvUARxBS4fw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] ARM: spectre-v2: per-CPU vtables to work around
 big.Little systems
To: linux@armlinux.org.uk
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_070352_415988_38A1020D 
X-CRM114-Status: GOOD (  24.07  )
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

On Thu, 6 Dec 2018 at 15:37, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> On Thu, Dec 06, 2018 at 03:30:22PM +0100, Krzysztof Kozlowski wrote:
> > On Thu, 6 Dec 2018 at 15:07, Russell King - ARM Linux
> > > That basically means that the dcache_clean_area method for CPU1
> > > differs from the dcache_clean_area method for CPU0.  If all your
> > > CPUs are identical, that definitely should not be happening.
> > >
> > > Hmm.  Interestingly, OMAP4430 passes hotplug tests just fine.
> > >
> > > Please try this patch.
> >
> > This fixes both hotplug and suspend to RAM. I was trying to narrow why
> > the pointers to all processor functions differ. During first boot they
> > were OK but it seems they were changed just before suspend.
>
> Thanks for testing.  I think this is probably a better patch which
> should end up with the same result.
>
> I suspect no one else has noticed because most people have big.Little
> support disabled - that'd explain why it doesn't show up on OMAP4.
>
> diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
> index 81d0efb055c6..44f9776139a8 100644
> --- a/arch/arm/mm/proc-macros.S
> +++ b/arch/arm/mm/proc-macros.S
> @@ -274,6 +274,13 @@
>         .endm
>
>  .macro define_processor_functions name:req, dabort:req, pabort:req, nommu=0, suspend=0, bugs=0
> +/*
> + * If we are building for big.Little with branch predictor hardening,
> + * we need the processor function tables to remain available after boot.
> + */
> +#if defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
> +       .rodata
> +#endif
>         .type   \name\()_processor_functions, #object
>         .align 2
>  ENTRY(\name\()_processor_functions)
> @@ -309,6 +316,9 @@ ENTRY(\name\()_processor_functions)
>         .endif
>
>         .size   \name\()_processor_functions, . - \name\()_processor_functions
> +#if defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
> +       .previous
> +#endif
>  .endm
>
>  .macro define_cache_functions name:req

Does not compile:
../arch/arm/mm/proc-v7.S: Assembler messages:
../arch/arm/mm/proc-v7.S:560: Error: unknown pseudo-op: `.rodata'
../arch/arm/mm/proc-v7.S:575: Error: unknown pseudo-op: `.rodata'
../arch/arm/mm/proc-v7.S:596: Error: unknown pseudo-op: `.rodata'
../arch/arm/mm/proc-v7.S:611: Error: unknown pseudo-op: `.rodata'
../arch/arm/mm/proc-v7.S:629: Error: unknown pseudo-op: `.rodata'

I am building with exynos_defconfig.

Best regards,
Krzysztof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
